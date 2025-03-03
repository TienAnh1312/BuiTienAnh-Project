using System;
using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly WebMangaContext _context;
        private readonly IWebHostEnvironment _environment;
        private readonly IWebHostEnvironment _hostingEnvironment;

        public HomeController(ILogger<HomeController> logger, WebMangaContext context, IWebHostEnvironment environment, IWebHostEnvironment hostingEnvironment)
        {
            _logger = logger;
            _context = context;
            _environment = environment;
            _hostingEnvironment = hostingEnvironment;
        }

        public IActionResult Index()
        {
            // --- Bảng xếp hạng tiêu xu ---

            // Top Xu theo ngày
            var coinsByDay = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    CoinsSpent = _context.PurchasedChapters
                        .Where(pc => pc.UserId == u.UserId && pc.PurchasedAt >= DateTime.Today)
                        .Sum(pc => pc.Chapter.Coins ?? 0) +
                        _context.PurchasedAvatarFrames
                        .Where(paf => paf.UserId == u.UserId && paf.PurchasedAt >= DateTime.Today)
                        .Sum(paf => paf.AvatarFrame.Price ?? 0)
                })
                .AsEnumerable() // Chuyển sang client-side evaluation
                .OrderByDescending(u => u.CoinsSpent)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.CoinsSpent })
                .ToList();

            // Top Xu theo tháng
            var coinsByMonth = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    CoinsSpent = _context.PurchasedChapters
                        .Where(pc => pc.UserId == u.UserId && pc.PurchasedAt >= DateTime.Today.AddMonths(-1))
                        .Sum(pc => pc.Chapter.Coins ?? 0) +
                        _context.PurchasedAvatarFrames
                        .Where(paf => paf.UserId == u.UserId && paf.PurchasedAt >= DateTime.Today.AddMonths(-1))
                        .Sum(paf => paf.AvatarFrame.Price ?? 0)
                })
                .AsEnumerable()
                .OrderByDescending(u => u.CoinsSpent)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.CoinsSpent })
                .ToList();

            // Top Xu theo năm
            var coinsByYear = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    CoinsSpent = _context.PurchasedChapters
                        .Where(pc => pc.UserId == u.UserId && pc.PurchasedAt >= DateTime.Today.AddYears(-1))
                        .Sum(pc => pc.Chapter.Coins ?? 0) +
                        _context.PurchasedAvatarFrames
                        .Where(paf => paf.UserId == u.UserId && paf.PurchasedAt >= DateTime.Today.AddYears(-1))
                        .Sum(paf => paf.AvatarFrame.Price ?? 0)
                })
                .AsEnumerable()
                .OrderByDescending(u => u.CoinsSpent)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.CoinsSpent })
                .ToList();

            // Top Xu tổng thể
            var coinsAllTime = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    CoinsSpent = _context.PurchasedChapters
                        .Where(pc => pc.UserId == u.UserId)
                        .Sum(pc => pc.Chapter.Coins ?? 0) +
                        _context.PurchasedAvatarFrames
                        .Where(paf => paf.UserId == u.UserId)
                        .Sum(paf => paf.AvatarFrame.Price ?? 0)
                })
                .AsEnumerable()
                .OrderByDescending(u => u.CoinsSpent)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.CoinsSpent })
                .ToList();

            // --- Bảng xếp hạng EXP ---

            // Top EXP theo ngày
            var expByDay = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    ExpPoints = _context.ExpHistories
                        .Where(eh => eh.UserId == u.UserId && eh.CreatedAt >= DateTime.Today)
                        .Sum(eh => eh.ExpAmount)
                })
                .AsEnumerable()
                .OrderByDescending(u => u.ExpPoints)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.ExpPoints })
                .ToList();

            // Top EXP theo tháng
            var expByMonth = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    ExpPoints = _context.ExpHistories
                        .Where(eh => eh.UserId == u.UserId && eh.CreatedAt >= DateTime.Today.AddMonths(-1))
                        .Sum(eh => eh.ExpAmount)
                })
                .AsEnumerable()
                .OrderByDescending(u => u.ExpPoints)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.ExpPoints })
                .ToList();

            // Top EXP theo năm
            var expByYear = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    ExpPoints = _context.ExpHistories
                        .Where(eh => eh.UserId == u.UserId && eh.CreatedAt >= DateTime.Today.AddYears(-1))
                        .Sum(eh => eh.ExpAmount)
                })
                .AsEnumerable()
                .OrderByDescending(u => u.ExpPoints)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.ExpPoints })
                .ToList();

            // Top EXP tổng thể
            var expAllTime = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    u.ExpPoints
                })
                .AsEnumerable()
                .OrderByDescending(u => u.ExpPoints)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, ExpPoints = u.ExpPoints ?? 0 })
                .ToList();

            // Truyền dữ liệu vào ViewBag
            ViewBag.TopCoinsByDay = coinsByDay;
            ViewBag.TopCoinsByMonth = coinsByMonth;
            ViewBag.TopCoinsByYear = coinsByYear;
            ViewBag.TopCoinsAllTime = coinsAllTime;

            ViewBag.TopExpByDay = expByDay;
            ViewBag.TopExpByMonth = expByMonth;
            ViewBag.TopExpByYear = expByYear;
            ViewBag.TopExpAllTime = expAllTime;

            var stories = _context.Stories.ToList();
            return View(stories);
        }

        public IActionResult Details(int? id)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");

            if (id == null)
            {
                return NotFound();
            }

            // Tải thông tin truyện với các liên kết cần thiết
            var story = _context.Stories
                .Include(s => s.StoryGenres)
                .ThenInclude(sg => sg.Genre)
                .Include(s => s.Chapters)
                .Include(s => s.Comments)
                .ThenInclude(c => c.User)
                .ThenInclude(u => u.AvatarFrame)
                .Include(s => s.Comments)
                .ThenInclude(c => c.User)
                .ThenInclude(u => u.CategoryRank)
                .FirstOrDefault(s => s.StoryId == id);

            if (story == null)
            {
                return NotFound();
            }

            // Tải danh sách bình luận
            var comments = _context.Comments
                .Where(c => c.StoryId == id && c.ParentCommentId == null)
                .OrderByDescending(c => c.CreatedAt)
                .Include(c => c.User)
                .ThenInclude(u => u.AvatarFrame)
                .Include(c => c.User)
                .ThenInclude(u => u.CategoryRank)
                .Include(c => c.InverseParentComment)
                .ThenInclude(r => r.User)
                .ThenInclude(u => u.AvatarFrame)
                .Include(c => c.InverseParentComment)
                .ThenInclude(r => r.User)
                .ThenInclude(u => u.CategoryRank)
                .ToList();

            // --- Thêm logic xếp hạng tiêu xu ---
            var topCoinsByDay = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    CoinsSpent = _context.PurchasedChapters
                        .Where(pc => pc.UserId == u.UserId && pc.PurchasedAt >= DateTime.Today)
                        .Sum(pc => pc.Chapter.Coins ?? 0) +
                        _context.PurchasedAvatarFrames
                        .Where(paf => paf.UserId == u.UserId && paf.PurchasedAt >= DateTime.Today)
                        .Sum(paf => paf.AvatarFrame.Price ?? 0)
                })
                .AsEnumerable()
                .OrderByDescending(u => u.CoinsSpent)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.CoinsSpent })
                .ToList();

            var topCoinsByMonth = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    CoinsSpent = _context.PurchasedChapters
                        .Where(pc => pc.UserId == u.UserId && pc.PurchasedAt >= DateTime.Today.AddMonths(-1))
                        .Sum(pc => pc.Chapter.Coins ?? 0) +
                        _context.PurchasedAvatarFrames
                        .Where(paf => paf.UserId == u.UserId && paf.PurchasedAt >= DateTime.Today.AddMonths(-1))
                        .Sum(paf => paf.AvatarFrame.Price ?? 0)
                })
                .AsEnumerable()
                .OrderByDescending(u => u.CoinsSpent)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.CoinsSpent })
                .ToList();

            var topCoinsByYear = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    CoinsSpent = _context.PurchasedChapters
                        .Where(pc => pc.UserId == u.UserId && pc.PurchasedAt >= DateTime.Today.AddYears(-1))
                        .Sum(pc => pc.Chapter.Coins ?? 0) +
                        _context.PurchasedAvatarFrames
                        .Where(paf => paf.UserId == u.UserId && paf.PurchasedAt >= DateTime.Today.AddYears(-1))
                        .Sum(paf => paf.AvatarFrame.Price ?? 0)
                })
                .AsEnumerable()
                .OrderByDescending(u => u.CoinsSpent)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.CoinsSpent })
                .ToList();

            var topCoinsAllTime = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    CoinsSpent = _context.PurchasedChapters
                        .Where(pc => pc.UserId == u.UserId)
                        .Sum(pc => pc.Chapter.Coins ?? 0) +
                        _context.PurchasedAvatarFrames
                        .Where(paf => paf.UserId == u.UserId)
                        .Sum(paf => paf.AvatarFrame.Price ?? 0)
                })
                .AsEnumerable()
                .OrderByDescending(u => u.CoinsSpent)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.CoinsSpent })
                .ToList();

            // --- Thêm logic xếp hạng EXP ---
            var topExpByDay = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    ExpPoints = _context.ExpHistories
                        .Where(eh => eh.UserId == u.UserId && eh.CreatedAt >= DateTime.Today)
                        .Sum(eh => eh.ExpAmount)
                })
                .AsEnumerable()
                .OrderByDescending(u => u.ExpPoints)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.ExpPoints })
                .ToList();

            var topExpByMonth = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    ExpPoints = _context.ExpHistories
                        .Where(eh => eh.UserId == u.UserId && eh.CreatedAt >= DateTime.Today.AddMonths(-1))
                        .Sum(eh => eh.ExpAmount)
                })
                .AsEnumerable()
                .OrderByDescending(u => u.ExpPoints)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.ExpPoints })
                .ToList();

            var topExpByYear = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    ExpPoints = _context.ExpHistories
                        .Where(eh => eh.UserId == u.UserId && eh.CreatedAt >= DateTime.Today.AddYears(-1))
                        .Sum(eh => eh.ExpAmount)
                })
                .AsEnumerable()
                .OrderByDescending(u => u.ExpPoints)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.ExpPoints })
                .ToList();

            var topExpAllTime = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    u.ExpPoints
                })
                .AsEnumerable()
                .OrderByDescending(u => u.ExpPoints)
                .Take(10)
                .Select((u, index) => new { Rank = index + 1, u.Username, ExpPoints = u.ExpPoints ?? 0 })
                .ToList();

            // Gán dữ liệu vào ViewBag
            ViewBag.Comments = comments;
            ViewBag.ReadingHistories = _context.ReadingHistories
                .Where(r => r.UserId == userId && r.StoryId == id)
                .ToList();
            ViewBag.IsFavorited = userId.HasValue && _context.Favorites.Any(f => f.UserId == userId && f.StoryId == id);
            ViewBag.IsFollowed = userId.HasValue && _context.FollowedStories.Any(f => f.UserId == userId && f.StoryId == id);
            ViewBag.CurrentUserId = userId;

            // Gán dữ liệu xếp hạng vào ViewBag
            ViewBag.TopCoinsByDay = topCoinsByDay;
            ViewBag.TopCoinsByMonth = topCoinsByMonth;
            ViewBag.TopCoinsByYear = topCoinsByYear;
            ViewBag.TopCoinsAllTime = topCoinsAllTime;

            ViewBag.TopExpByDay = topExpByDay;
            ViewBag.TopExpByMonth = topExpByMonth;
            ViewBag.TopExpByYear = topExpByYear;
            ViewBag.TopExpAllTime = topExpAllTime;

            return View(story);
        }

        [HttpGet]
        public IActionResult SearchSuggestions(string query)
        {
            if (string.IsNullOrEmpty(query))
            {
                return Json(new List<object>());
            }

            var suggestions = _context.Stories
                .Where(s => s.Title.Contains(query, StringComparison.OrdinalIgnoreCase))
                .Select(s => new
                {
                    storyId = s.StoryId,
                    title = s.Title
                })
                .Take(10)
                .ToList();

            return Json(suggestions);
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
    }
}