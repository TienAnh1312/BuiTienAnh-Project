using Ganss.Xss;
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
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddComment(int storyId, string content, int? stickerId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null) return RedirectToAction("Login", "Account");

            var user = await _context.Users.FirstOrDefaultAsync(u => u.UserId == userId);
            if (user == null) return NotFound();

            if (!await _context.Stories.AnyAsync(s => s.StoryId == storyId))
                return NotFound("Story not found.");

            var sanitizer = new HtmlSanitizer();
            var sanitizedContent = sanitizer.Sanitize(content);

            var comment = new Comment
            {
                UserId = userId.Value,
                StoryId = storyId,
                Content = sanitizedContent,
                CreatedAt = DateTime.Now,
                StickerId = stickerId
            };

            _context.Comments.Add(comment);
            user.ExpPoints += 10;

            await _context.SaveChangesAsync();

            // Chỉ gửi thông báo cho người được tag
            var taggedUsernames = ExtractTaggedUsernames(sanitizedContent).Distinct();
            foreach (var username in taggedUsernames)
            {
                var taggedUser = await _context.Users.FirstOrDefaultAsync(u => u.Username == username);
                if (taggedUser != null && taggedUser.UserId != userId)
                {
                    var notification = new Notification
                    {
                        UserId = taggedUser.UserId,
                        Message = $"{user.Username} đã nhắc đến bạn trong một bình luận.",
                        CreatedAt = DateTime.Now,
                        IsRead = false,
                        Link = $"/Home/Details/{storyId}?commentPage=1#comment-{comment.CommentId}",
                        CommentId = comment.CommentId
                    };
                    _context.Notifications.Add(notification);
                }
            }

            await _context.SaveChangesAsync();

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                return Json(new { success = true, message = "Bình luận thành công!" });

            TempData["SuccessMessage"] = "Bình luận thành công!";
            return RedirectToAction("Details", "Home", new { id = storyId });
        }

        // Hàm helper để trích xuất @username từ nội dung
        private List<string> ExtractTaggedUsernames(string content)
        {
            var usernames = new List<string>();
            var words = content.Split(' ');
            foreach (var word in words)
            {
                if (word.StartsWith("@") && word.Length > 1)
                {
                    usernames.Add(word.Substring(1)); // Loại bỏ ký tự @
                }
            }
            return usernames;
        }

        // Trả lời bình luận
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ReplyComment(int storyId, int parentCommentId, int? grandParentCommentId, string content, int? stickerId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null || string.IsNullOrWhiteSpace(content))
            {
                TempData["ErrorMessage"] = "You must be logged in and provide a reply!";
                return RedirectToAction("Details", "Home", new { id = storyId });
            }

            var sanitizer = new HtmlSanitizer();
            var sanitizedContent = sanitizer.Sanitize(content);

            var replyComment = new Comment
            {
                UserId = userId.Value,
                StoryId = storyId,
                Content = sanitizedContent,
                CreatedAt = DateTime.Now,
                ParentCommentId = parentCommentId,
                StickerId = stickerId
            };

            if (grandParentCommentId.HasValue)
            {
                replyComment.ParentCommentId = grandParentCommentId.Value;
            }

            _context.Comments.Add(replyComment);

            var user = await _context.Users.FirstOrDefaultAsync(u => u.UserId == userId);
            if (user != null)
            {
                user.ExpPoints += 10;
                var newLevel = await _context.Levels
                    .Where(l => l.ExpRequired <= user.ExpPoints)
                    .OrderByDescending(l => l.LevelId)
                    .FirstOrDefaultAsync();

                if (newLevel != null && newLevel.LevelId != user.Level)
                {
                    user.Level = newLevel.LevelId;
                    user.CategoryRankId = newLevel.CategoryRankId;
                }
            }

            await _context.SaveChangesAsync();

            // Chỉ gửi thông báo cho người được tag
            var taggedUsernames = ExtractTaggedUsernames(sanitizedContent).Distinct();
            foreach (var username in taggedUsernames)
            {
                var taggedUser = await _context.Users.FirstOrDefaultAsync(u => u.Username == username);
                if (taggedUser != null && taggedUser.UserId != userId)
                {
                    var notification = new Notification
                    {
                        UserId = taggedUser.UserId,
                        Message = $"{user.Username} đã nhắc đến bạn trong một câu trả lời.",
                        CreatedAt = DateTime.Now,
                        IsRead = false,
                        Link = $"/Home/Details/{storyId}?commentPage=1#comment-{replyComment.CommentId}",
                        CommentId = replyComment.CommentId
                    };
                    _context.Notifications.Add(notification);
                }
            }

            await _context.SaveChangesAsync();

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                return Json(new { success = true, message = "Trả lời thành công!" });

            TempData["SuccessMessage"] = "Your reply has been added!";
            return RedirectToAction("Details", "Home", new { id = storyId });
        }
    }
}
