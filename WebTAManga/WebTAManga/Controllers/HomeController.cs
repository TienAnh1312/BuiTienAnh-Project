using System;
using System.Diagnostics;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Migrations;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly WebMangaContext _context;
        private readonly IWebHostEnvironment _environment;
        private readonly IWebHostEnvironment _hostingEnvironment;

        // Constructor duy nhất để nhận cả ILogger và WebMangaContext
        public HomeController(ILogger<HomeController> logger, WebMangaContext context, IWebHostEnvironment environment, IWebHostEnvironment hostingEnvironment)
        {
            _logger = logger;
            _context = context;
            _environment = environment;
            _hostingEnvironment = hostingEnvironment;
        }

        public IActionResult Index()
        {
            // Lấy danh sách các truyện từ cơ sở dữ liệu
            var stories = _context.Stories.ToList(); // Giả sử Stories là tên DbSet trong DbContext

            // Truyền dữ liệu vào view
            return View(stories);
        }

        // Phương thức Detail để hiển thị chi tiết một truyện
        public IActionResult Details(int? id)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (id == null || userId == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var story = _context.Stories
                                .Include(s => s.StoryGenres)
                                .ThenInclude(sg => sg.Genre)
                                .Include(s => s.Chapters)
                                .Include(s => s.Comments) // Bao gồm bình luận
                                .ThenInclude(c => c.User) // Bao gồm người dùng của mỗi bình luận
                                .FirstOrDefault(s => s.StoryId == id);

            if (story == null)
            {
                return NotFound();
            }

            // Lấy danh sách bình luận cha và bình luận trả lời
            var comments = _context.Comments
                                   .Where(c => c.StoryId == id && c.ParentCommentId == null)
                                   .OrderByDescending(c => c.CreatedAt)
                                   .Include(c => c.User)
                                   .Include(c => c.InverseParentComment) // Bao gồm các bình luận trả lời
                                   .ToList();

            ViewBag.Comments = comments;
            var readingHistories = _context.ReadingHistories
                                          .Where(r => r.UserId == userId && r.StoryId == id)
                                          //.Select(r => r.ChapterId)
                                          .ToList();
            ViewBag.ReadingHistories = readingHistories;
            return View(story);
        }

        public IActionResult ReadChapter(int id)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");

            if (userId == null)
            {
                return RedirectToAction("Index", "Login"); // Chuyển đến trang đăng nhập nếu chưa đăng nhập
            }

            // Lấy thông tin chapter kèm hình ảnh
            var chapter = _context.Chapters
                                  .Include(c => c.ChapterImages)
                                  .FirstOrDefault(c => c.ChapterId == id);

            if (chapter == null)
            {
                return NotFound(); // Nếu chapter không tồn tại
            }

            //  Kiểm tra xem user đã mua chưa
            var isPurchased = _context.PurchasedChapters
                                    .Any(pc => pc.UserId == userId && pc.ChapterId == id);

            // trạng thái mở khóa chapter
            chapter.IsUnlocked = isPurchased || chapter.Coins == 0;

            ViewBag.IsPurchased = isPurchased;
            ViewBag.IsUnlocked = chapter.IsUnlocked;

            // Kiểm tra nếu chapter chưa được đánh dấu đã đọc
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
                    LastReadAt = DateTime.Now
                });
                _context.SaveChanges();
            }
           
            // Cập nhật chương cuối cùng đã đọc trong FollowedStory
            var followedStory = _context.FollowedStories
                                        .FirstOrDefault(f => f.UserId == userId && f.StoryId == chapter.StoryId);

            if (followedStory != null)
            {
                followedStory.LastReadChapterId = chapter.ChapterId;
                _context.SaveChanges();
            }

            // Tìm chương trước và chương sau
            var previousChapter = _context.Chapters
                                           .Where(c => c.StoryId == chapter.StoryId && c.ChapterId < chapter.ChapterId)
                                           .OrderByDescending(c => c.ChapterId)
                                           .FirstOrDefault();

            var nextChapter = _context.Chapters
                                       .Where(c => c.StoryId == chapter.StoryId && c.ChapterId > chapter.ChapterId)
                                       .OrderBy(c => c.ChapterId)
                                       .FirstOrDefault();

            ViewBag.PreviousChapter = previousChapter;
            ViewBag.NextChapter = nextChapter;

            return View(chapter);
        }

        //kiểm tra đã đọc
        public IActionResult ChapterList(int storyId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var chapters = _context.Chapters.Where(c => c.StoryId == storyId).ToList();

            // Lấy danh sách các chapter đã được đọc
            var readingHistories = _context.ReadingHistories
                                           .Where(r => r.UserId == userId && r.StoryId == storyId)
                                           .ToList();

            ViewBag.ReadingHistories = readingHistories;

            return View(chapters);
        }

        //thêm vào danh sách yêu thích
        [HttpPost]
        public IActionResult AddToFavorites(int storyId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Index", "Login"); // Chuyển đến trang đăng nhập nếu chưa đăng nhập
            }

            var favorite = _context.Favorites.FirstOrDefault(f => f.UserId == userId && f.StoryId == storyId);
            if (favorite == null)
            {
                favorite = new Favorite
                {
                    UserId = userId.Value,
                    StoryId = storyId,
                    AddedAt = DateTime.Now
                };
                _context.Favorites.Add(favorite);
                _context.SaveChanges();
                TempData["SuccessMessage"] = "The story has been added to your favorites!";
            }
            else
            {
                TempData["InfoMessage"] = "This story is already in your favorites.";
            }

            return RedirectToAction("Details", new { id = storyId });
        }

        //danh sách yêu thích
        public IActionResult FavoriteList()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Index", "Login"); // Chuyển đến trang đăng nhập nếu chưa đăng nhập
            }

            var favorites = _context.Favorites
                                    .Include(f => f.Story)
                                    .Where(f => f.UserId == userId)
                                    .Select(f => f.Story)
                                    .ToList();

            return View(favorites);
        }

        //xóa khỏi danh sách yêu thích
        [HttpPost]
        public IActionResult RemoveFromFavorites(int storyId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Index", "Login"); // Chuyển đến trang đăng nhập nếu chưa đăng nhập
            }

            var favorite = _context.Favorites.FirstOrDefault(f => f.UserId == userId && f.StoryId == storyId);
            if (favorite != null)
            {
                _context.Favorites.Remove(favorite);
                _context.SaveChanges();
            }

            return RedirectToAction("FavoriteList"); // Quay lại danh sách yêu thích
        }

        //thêm vào danh sách theo dõi
        [HttpPost]
        public IActionResult AddToFollowed(int storyId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Index", "Login"); // Chuyển đến trang đăng nhập nếu chưa đăng nhập
            }

            // Kiểm tra nếu câu chuyện đã có trong danh sách theo dõi của người dùng
            var followedStory = _context.FollowedStories.FirstOrDefault(f => f.UserId == userId && f.StoryId == storyId);
            if (followedStory == null)
            {
                followedStory = new FollowedStory
                {
                    UserId = userId.Value,
                    StoryId = storyId,
                    LastReadChapterId = null, // Chưa có chương nào được đọc
                };
                _context.FollowedStories.Add(followedStory);

                // Cập nhật lại thông báo
                TempData["SuccessMessage"] = "The story has been added to your followed stories!";
                _context.SaveChanges();

            }
            else
            {
                TempData["InfoMessage"] = "This story is already in your followed stories.";
            }

            return RedirectToAction("Details", new { id = storyId });
        }

        //theo dõi truyện
        public IActionResult FollowedStories()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Index", "Login");
            }

            // Lấy danh sách các câu chuyện mà người dùng đang theo dõi
            var followedStories = _context.FollowedStories
                                           .Where(f => f.UserId == userId)
                                           .Include(f => f.Story)
                                           .Include(f => f.LastReadChapter) // Bao gồm thông tin chương cuối đã đọc
                                           .ToList();

            return View(followedStories);
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

            TempData["SuccessMessage"] = "Bình luận thành công! Bạn đã nhận 5 EXP.";

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
                return RedirectToAction("Details", new { id = storyId });
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
                user.ExpPoints += 10; // Cộng 5 EXP khi trả lời bình luận

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
            return RedirectToAction("Details", new { id = storyId });
        }


        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public interface IStoryRepository
        {
            IEnumerable<Story> GetAllStories();
        }

        public IActionResult CompleteReading(int chapterId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null) return RedirectToAction("Index", "Login");

            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            var readingHistory = _context.ReadingHistories
                .FirstOrDefault(r => r.UserId == userId && r.ChapterId == chapterId);

            if (user != null && readingHistory != null)
            {
                TimeSpan minReadingTime = TimeSpan.FromMinutes(2);
                TimeSpan readingDuration = DateTime.Now - readingHistory.StartTime;

                if (readingDuration >= minReadingTime)
                {
                    user.ExpPoints += 10; // Đọc xong 1 chapter cộng 10 EXP
                    _context.SaveChanges();
                }
            }

            return RedirectToAction("Index", "Home");
        }


        [HttpPost]
        public IActionResult BuyChapter(int chapterId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                TempData["ErrorMessage"] = "Bạn cần đăng nhập để mua chapter!";
                return RedirectToAction("Login", "Auth");
            }

            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            var chapter = _context.Chapters.FirstOrDefault(c => c.ChapterId == chapterId);

            if (chapter == null || user == null)
            {
                TempData["ErrorMessage"] = "Không tìm thấy chapter hoặc người dùng!";
                return RedirectToAction("ReadChapter", new { id = chapterId });
            }

            // Kiểm tra xem user đã mua chapter này chưa
            bool isAlreadyPurchased = _context.PurchasedChapters
                .Any(pc => pc.UserId == userId && pc.ChapterId == chapterId);

            if (isAlreadyPurchased)
            {
                TempData["InfoMessage"] = "Bạn đã mua chapter này rồi!";
                return RedirectToAction("ReadChapter", new { id = chapterId });
            }

            // Kiểm tra số xu của người dùng trước khi thực hiện giao dịch
            if (user.Coins < chapter.Coins)
            {
                TempData["ErrorMessage"] = "Bạn không có đủ xu để mua chapter này!";
                return RedirectToAction("ReadChapter", new { id = chapterId });
            }

            // Nếu đủ xu, tiến hành giao dịch
            using (var transaction = _context.Database.BeginTransaction())
            {
                try
                {
                    // Trừ xu của người dùng
                    user.Coins -= chapter.Coins;

                    // Thêm vào danh sách chương đã mua
                    _context.PurchasedChapters.Add(new PurchasedChapter
                    {
                        UserId = user.UserId,
                        ChapterId = chapter.ChapterId,
                        PurchasedAt = DateTime.Now
                    });

                    _context.SaveChanges();

                    // Commit transaction
                    transaction.Commit();

                    TempData["SuccessMessage"] = "Mua chapter thành công!";
                }
                catch (Exception ex)
                {
                    // Rollback nếu có lỗi
                    transaction.Rollback();
                    TempData["ErrorMessage"] = "Có lỗi xảy ra, vui lòng thử lại!";
                }
            }
            return RedirectToAction("ReadChapter", new { id = chapterId });
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

    }
}