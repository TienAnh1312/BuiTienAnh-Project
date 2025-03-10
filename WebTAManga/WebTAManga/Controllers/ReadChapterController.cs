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

            var chapter = _context.Chapters
                                  .Include(c => c.ChapterImages)
                                  .FirstOrDefault(c => c.ChapterId == id);
            if (chapter == null) return NotFound();

            bool isPurchased = false;

            // Nếu người dùng đã đăng nhập, kiểm tra xem họ đã mua chương chưa
            if (userId != null && chapter.Coins > 0)
            {
                isPurchased = _context.PurchasedChapters.Any(pc => pc.UserId == userId && pc.ChapterId == id);
            }

            // Xác định chương có được mở khóa không (miễn phí hoặc đã mua)
            chapter.IsUnlocked = isPurchased || chapter.Coins == 0;
            ViewBag.IsPurchased = isPurchased;
            ViewBag.IsUnlocked = chapter.IsUnlocked;

            // Nếu người dùng đã đăng nhập, cập nhật lịch sử đọc
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

            // Lấy chương trước và chương sau
            ViewBag.PreviousChapter = _context.Chapters
                                              .Where(c => c.StoryId == chapter.StoryId && c.ChapterId < chapter.ChapterId)
                                              .OrderByDescending(c => c.ChapterId)
                                              .FirstOrDefault();
            ViewBag.NextChapter = _context.Chapters
                                          .Where(c => c.StoryId == chapter.StoryId && c.ChapterId > chapter.ChapterId)
                                          .OrderBy(c => c.ChapterId)
                                          .FirstOrDefault();

            // Lấy tất cả các chương của câu chuyện để hiển thị trong dropdown
            ViewBag.AllChapters = _context.Chapters
                                          .Where(c => c.StoryId == chapter.StoryId)
                                          .ToList();

            return View(chapter);
        }

        //kiểm tra đã đọc
        public IActionResult ChapterList(int storyId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Login", "Account");
            }

            var chapters = _context.Chapters.Where(c => c.StoryId == storyId).ToList();

            // Lấy danh sách các chapter đã được đọc
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
                readingHistory.EndTime = DateTime.Now; // Đánh dấu hoàn thành
                user.ExpPoints += 10;

                _context.ExpHistories.Add(new ExpHistory
                {
                    UserId = userId.Value,
                    ExpAmount = 10,
                    Reason = "Hoàn thành đọc chương " + chapterId,
                    CreatedAt = DateTime.Now
                });

                _context.SaveChanges();
                UpdateUserLevel(user); // Cập nhật cấp độ nếu đủ EXP
            }

            return RedirectToAction("Index", "Home");
        }

        //cập nhập cấp độ
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