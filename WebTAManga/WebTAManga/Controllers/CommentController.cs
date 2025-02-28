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
        public IActionResult AddComment(int storyId, string content)
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
                CreatedAt = DateTime.Now
            };

            _context.Comments.Add(comment);
            user.ExpPoints += 10; // Bình luận cộng 5 EXP
            _context.SaveChanges();

            TempData["SuccessMessage"] = "Bình luận thành công!";

            return RedirectToAction("Details", "Home", new { id = storyId });
        }


        // Trả lời bình luận
        [HttpPost]
        public IActionResult ReplyComment(int storyId, int parentCommentId, int? grandParentCommentId, string content)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null || string.IsNullOrWhiteSpace(content))
            {
                TempData["ErrorMessage"] = "You must be logged in and provide a reply!";
                return RedirectToAction("Details","Home", new { id = storyId });
            }

            // Thêm bình luận trả lời vào cơ sở dữ liệu
            var replyComment = new Comment
            {
                UserId = userId.Value,
                StoryId = storyId,
                Content = content,
                CreatedAt = DateTime.Now,
                ParentCommentId = parentCommentId // Nếu có bình luận cha
            };

            if (grandParentCommentId.HasValue)
            {
                replyComment.ParentCommentId = grandParentCommentId.Value;
            }

            _context.Comments.Add(replyComment);

            // Cộng EXP cho người dùng
            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            if (user != null)
            {
                user.ExpPoints += 10; // Cộng EXP khi trả lời bình luận

                // Cập nhật level nếu đủ EXP
                var newLevel = _context.Levels
                    .Where(l => l.ExpRequired <= user.ExpPoints)
                    .OrderByDescending(l => l.LevelId)
                    .FirstOrDefault();

                if (newLevel != null && newLevel.LevelId != user.Level)
                {
                    user.Level = newLevel.LevelId;
                    user.CategoryRankId = newLevel.CategoryRankId; // Cập nhật Rank nếu cần
                }
            }

            _context.SaveChanges();

            TempData["SuccessMessage"] = "Your reply has been added!";
            return RedirectToAction("Details", "Home", new { id = storyId });
        }
    }
}
