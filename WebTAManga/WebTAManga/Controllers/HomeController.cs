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
                .ThenInclude(u => u.AvatarFrame)    // Tải AvatarFrame từ User
                .Include(s => s.Comments)           // Tải riêng Comments để thêm CategoryRank
                .ThenInclude(c => c.User)
                .ThenInclude(u => u.CategoryRank)   // Tải CategoryRank từ User
                .FirstOrDefault(s => s.StoryId == id);

            if (story == null)
            {
                return NotFound();
            }

            // Tải danh sách bình luận với thông tin người dùng đầy đủ
            var comments = _context.Comments
                .Where(c => c.StoryId == id && c.ParentCommentId == null)
                .OrderByDescending(c => c.CreatedAt)
                .Include(c => c.User)
                .ThenInclude(u => u.AvatarFrame)    // Tải AvatarFrame cho User
                .Include(c => c.User)
                .ThenInclude(u => u.CategoryRank)   // Tải CategoryRank cho User
                .Include(c => c.InverseParentComment)
                .ThenInclude(r => r.User)
                .ThenInclude(u => u.AvatarFrame)    // Tải AvatarFrame cho reply
                .Include(c => c.InverseParentComment)
                .ThenInclude(r => r.User)
                .ThenInclude(u => u.CategoryRank)   // Tải CategoryRank cho reply
                .ToList();

            // Gán dữ liệu vào ViewBag
            ViewBag.Comments = comments;
            ViewBag.ReadingHistories = _context.ReadingHistories
                .Where(r => r.UserId == userId && r.StoryId == id)
                .ToList();
            ViewBag.IsFavorited = userId.HasValue && _context.Favorites.Any(f => f.UserId == userId && f.StoryId == id);
            ViewBag.IsFollowed = userId.HasValue && _context.FollowedStories.Any(f => f.UserId == userId && f.StoryId == id);
            ViewBag.CurrentUserId = userId;

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