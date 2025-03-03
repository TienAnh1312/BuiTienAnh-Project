using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class CommentController : Controller
    {
        private readonly WebMangaContext _context;

        // Constructor 
        public CommentController(WebMangaContext context)
        {
            _context = context;
        }

        // Thêm bình luận
        [HttpPost]
        public IActionResult AddComment(int storyId, string content, int? stickerId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null) return RedirectToAction("Index", "Login");

            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            if (user == null) return NotFound();

            var comment = new Comment
            {
                UserId = userId.Value,
                StoryId = storyId,
                Content = content,
                CreatedAt = DateTime.Now,
                StickerId = stickerId // Lưu StickerId nếu có
            };

            _context.Comments.Add(comment);
            user.ExpPoints += 10; // Cộng 10 EXP khi bình luận
            _context.SaveChanges();

            TempData["SuccessMessage"] = "Bình luận thành công!";
            return RedirectToAction("Details", "Home", new { id = storyId });
        }

        // Trả lời bình luận
        [HttpPost]
        public IActionResult ReplyComment(int storyId, int parentCommentId, int? grandParentCommentId, string content, int? stickerId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null || string.IsNullOrWhiteSpace(content))
            {
                TempData["ErrorMessage"] = "You must be logged in and provide a reply!";
                return RedirectToAction("Details", "Home", new { id = storyId });
            }

            var replyComment = new Comment
            {
                UserId = userId.Value,
                StoryId = storyId,
                Content = content,
                CreatedAt = DateTime.Now,
                ParentCommentId = parentCommentId,
                StickerId = stickerId // Lưu StickerId nếu có
            };

            if (grandParentCommentId.HasValue)
            {
                replyComment.ParentCommentId = grandParentCommentId.Value;
            }

            _context.Comments.Add(replyComment);

            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            if (user != null)
            {
                user.ExpPoints += 10;
                var newLevel = _context.Levels
                    .Where(l => l.ExpRequired <= user.ExpPoints)
                    .OrderByDescending(l => l.LevelId)
                    .FirstOrDefault();

                if (newLevel != null && newLevel.LevelId != user.Level)
                {
                    user.Level = newLevel.LevelId;
                    user.CategoryRankId = newLevel.CategoryRankId;
                }
            }

            _context.SaveChanges();

            TempData["SuccessMessage"] = "Your reply has been added!";
            return RedirectToAction("Details", "Home", new { id = storyId });
        }
    }
}
