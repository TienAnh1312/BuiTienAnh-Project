using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class ReadChapterController : Controller
    {
        private readonly WebMangaContext _context;

        // Constructor 
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
                .OrderByDescending(c => c.ChapterNumber) // Giữ thứ tự giảm dần cho dropdown
                .ToList();

            ViewBag.AllChapters = allChapters.Select(c => c.Chapter).ToList();

            // Lấy số thứ tự của chapter hiện tại
            int currentChapterNumber = int.TryParse(chapter.ChapterTitle?.Replace("Chương ", ""), out int num) ? num : 0;

            // Tìm chapter trước (số nhỏ hơn hiện tại)
            ViewBag.PreviousChapter = allChapters
                .Where(c => c.ChapterNumber < currentChapterNumber)
                .OrderByDescending(c => c.ChapterNumber) // Chương gần nhất nhỏ hơn
                .FirstOrDefault()?.Chapter;

            // Tìm chapter sau (số lớn hơn hiện tại)
            ViewBag.NextChapter = allChapters
                .Where(c => c.ChapterNumber > currentChapterNumber)
                .OrderBy(c => c.ChapterNumber) // Chương gần nhất lớn hơn
                .FirstOrDefault()?.Chapter;

            // Trả về view với chapter hiện tại
            return View(chapter);
        }

        // Hiển thị danh sách chapter của một story
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

        // Đánh dấu hoàn thành đọc chapter
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

        // Cập nhật cấp độ người dùng
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
    }
}