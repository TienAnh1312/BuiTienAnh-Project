using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ganss.Xss;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class ReadChapterController : Controller
    {
        private readonly WebMangaContext _context;

        public ReadChapterController(WebMangaContext context)
        {
            _context = context;
        }

        public IActionResult ReadChapter(int id)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");

            // Lấy thông tin chapter hiện tại
            var chapter = _context.Chapters
                .Include(c => c.ChapterImages)
                .Include(c => c.Story) // Thêm để lấy StoryId
                .FirstOrDefault(c => c.ChapterId == id);

            if (chapter == null) return NotFound();

            // Kiểm tra xem chapter đã được mua chưa nếu yêu cầu xu
            bool isPurchased = false;
            if (userId != null && chapter.Coins > 0)
            {
                isPurchased = _context.PurchasedChapters
                    .Any(pc => pc.UserId == userId && pc.ChapterCode == chapter.ChapterCode);
            }

            // Xác định trạng thái mở khóa
            chapter.IsUnlocked = isPurchased || chapter.Coins == 0;
            ViewBag.IsPurchased = isPurchased;
            ViewBag.IsUnlocked = chapter.IsUnlocked;

            // Cập nhật lịch sử đọc nếu người dùng đăng nhập
            if (userId != null)
            {
                var readingHistory = _context.ReadingHistories
                    .FirstOrDefault(r => r.UserId == userId && r.ChapterId == id);

                if (readingHistory == null)
                {
                    _context.ReadingHistories.Add(new ReadingHistory
                    {
                        UserId = userId.Value,
                        ChapterId = id,
                        StoryId = chapter.StoryId,
                        StartTime = DateTime.Now,
                        LastReadAt = DateTime.Now,
                        EndTime = null
                    });
                }
                else
                {
                    readingHistory.LastReadAt = DateTime.Now;
                }

                _context.SaveChanges();

                var followedStory = _context.FollowedStories
                    .FirstOrDefault(f => f.UserId == userId && f.StoryId == chapter.StoryId);
                if (followedStory != null)
                {
                    followedStory.LastReadChapterId = chapter.ChapterId;
                    _context.SaveChanges();
                }
            }

            // Lấy tất cả các chapter của story và tính số thứ tự
            var allChapters = _context.Chapters
                .Where(c => c.StoryId == chapter.StoryId)
                .ToList()
                .Select(c => new
                {
                    Chapter = c,
                    ChapterNumber = int.TryParse(c.ChapterTitle?.Replace("Chương ", ""), out int num) ? num : 0
                })
                .OrderByDescending(c => c.ChapterNumber)
                .ToList();

            ViewBag.AllChapters = allChapters.Select(c => c.Chapter).ToList();

            int currentChapterNumber = int.TryParse(chapter.ChapterTitle?.Replace("Chương ", ""), out int num) ? num : 0;

            ViewBag.PreviousChapter = allChapters
                .Where(c => c.ChapterNumber < currentChapterNumber)
                .OrderByDescending(c => c.ChapterNumber)
                .FirstOrDefault()?.Chapter;

            ViewBag.NextChapter = allChapters
                .Where(c => c.ChapterNumber > currentChapterNumber)
                .OrderBy(c => c.ChapterNumber)
                .FirstOrDefault()?.Chapter;

            // Lấy tất cả bình luận gốc của chương hiện tại
            var rootComments = _context.Comments
                .Where(c => c.ChapterId == id && c.ParentCommentId == null)
                .Include(c => c.User).ThenInclude(u => u.AvatarFrame)
                .Include(c => c.User).ThenInclude(u => u.CategoryRank)
                .Include(c => c.Sticker)
                .Include(c => c.Chapter)
                .OrderByDescending(c => c.CreatedAt)
                .ToList();

            // Lấy tất cả bình luận trả lời liên quan đến các bình luận gốc này (bao gồm từ Details)
            var allComments = new List<Comment>();
            foreach (var rootComment in rootComments)
            {
                allComments.Add(rootComment);
                var replies = _context.Comments
                    .Where(c => c.ParentCommentId == rootComment.CommentId)
                    .Include(c => c.User).ThenInclude(u => u.AvatarFrame)
                    .Include(c => c.User).ThenInclude(u => u.CategoryRank)
                    .Include(c => c.Sticker)
                    .Include(c => c.Chapter)
                    .OrderBy(c => c.CreatedAt)
                    .ToList();

                rootComment.InverseParentComment = replies;
            }

            ViewBag.Comments = rootComments;
            ViewBag.Stickers = _context.Stickers.ToList();
            ViewBag.CurrentUserId = userId;

            return View(chapter);
        }

        // Thêm bình luận cho chương
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddChapterComment(int chapterId, string content, int? stickerId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null) return RedirectToAction("Login", "Account");

            var chapter = await _context.Chapters
                .Include(c => c.Story)
                .FirstOrDefaultAsync(c => c.ChapterId == chapterId);
            if (chapter == null) return NotFound("Chapter not found.");

            var sanitizer = new HtmlSanitizer();
            var sanitizedContent = sanitizer.Sanitize(content);

            var comment = new Comment
            {
                UserId = userId.Value,
                StoryId = chapter.StoryId,
                ChapterId = chapterId,
                Content = sanitizedContent,
                CreatedAt = DateTime.Now,
                StickerId = stickerId
            };

            _context.Comments.Add(comment);

            var user = await _context.Users.FirstOrDefaultAsync(u => u.UserId == userId);
            if (user != null)
            {
                user.ExpPoints += 10;
                UpdateUserLevel(user); // Cập nhật level nếu cần
            }

            await _context.SaveChangesAsync();

            // Gửi thông báo cho người được tag
            var taggedUsernames = ExtractTaggedUsernames(sanitizedContent).Distinct();
            foreach (var username in taggedUsernames)
            {
                var taggedUser = await _context.Users.FirstOrDefaultAsync(u => u.Username == username);
                if (taggedUser != null && taggedUser.UserId != userId)
                {
                    var notification = new Notification
                    {
                        UserId = taggedUser.UserId,
                        Message = $"{user.Username} đã nhắc đến bạn trong bình luận chương {chapter.ChapterTitle}.",
                        CreatedAt = DateTime.Now,
                        IsRead = false,
                        Link = $"/ReadChapter/ReadChapter?id={chapterId}#comment-{comment.CommentId}",
                        CommentId = comment.CommentId
                    };
                    _context.Notifications.Add(notification);
                }
            }

            await _context.SaveChangesAsync();

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                return Json(new { success = true, message = "Bình luận thành công!" });

            TempData["SuccessMessage"] = "Bình luận thành công!";
            return RedirectToAction("ReadChapter", new { id = chapterId });
        }

        private List<string> ExtractTaggedUsernames(string content)
        {
            var usernames = new List<string>();
            var words = content.Split(' ');
            foreach (var word in words)
            {
                if (word.StartsWith("@") && word.Length > 1)
                {
                    usernames.Add(word.Substring(1));
                }
            }
            return usernames;
        }

        public IActionResult ChapterList(int storyId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Login", "Account");
            }

            var chapters = _context.Chapters.Where(c => c.StoryId == storyId).ToList();
            var readingHistories = _context.ReadingHistories
                                           .Where(r => r.UserId == userId && r.StoryId == storyId)
                                           .ToList();

            ViewBag.ReadingHistories = readingHistories;
            return View(chapters);
        }

        public IActionResult CompleteReading(int chapterId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null) return RedirectToAction("Login", "Account");

            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            var readingHistory = _context.ReadingHistories
                                         .FirstOrDefault(r => r.UserId == userId && r.ChapterId == chapterId);

            if (user != null && readingHistory != null && readingHistory.EndTime == null)
            {
                readingHistory.EndTime = DateTime.Now;
                user.ExpPoints += 10;

                _context.ExpHistories.Add(new ExpHistory
                {
                    UserId = userId.Value,
                    ExpAmount = 10,
                    Reason = "Hoàn thành đọc chương " + chapterId,
                    CreatedAt = DateTime.Now
                });

                _context.SaveChanges();
                UpdateUserLevel(user);
            }

            return RedirectToAction("Index", "Home");
        }

        private void UpdateUserLevel(User user)
        {
            var newLevel = _context.Levels
                                  .Where(l => l.ExpRequired <= user.ExpPoints)
                                  .OrderByDescending(l => l.LevelId)
                                  .FirstOrDefault();

            if (newLevel != null && newLevel.LevelId != user.Level)
            {
                user.Level = newLevel.LevelId;
                user.CategoryRankId = newLevel.CategoryRankId;
            }

            _context.SaveChanges();
        }

        public async Task<IActionResult> GetImage(int imageId)
        {
            var chapterImage = await _context.ChapterImages.FindAsync(imageId);
            if (chapterImage == null || string.IsNullOrEmpty(chapterImage.ImageUrl))
            {
                return NotFound();
            }

            try
            {
                using var client = new HttpClient();
                var response = await client.GetAsync(chapterImage.ImageUrl);
                if (!response.IsSuccessStatusCode)
                {
                    return NotFound();
                }

                var stream = await response.Content.ReadAsStreamAsync();
                var contentType = response.Content.Headers.ContentType?.MediaType ?? "image/jpeg";
                return File(stream, contentType);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Lỗi khi tải hình ảnh: {ex.Message}");
                return NotFound();
            }
        }
    }
}