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

        // Method gán trực tiếp dữ liệu xếp hạng vào ViewBag
        private void GetRankings()
        {
            // Top Coins
            ViewBag.TopCoinsByDay = _context.Users
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
                .Take(5)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.CoinsSpent })
                .ToList();

            ViewBag.TopCoinsByMonth = _context.Users
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
                .Take(5)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.CoinsSpent })
                .ToList();

            ViewBag.TopCoinsAllTime = _context.Users
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
                .Take(5)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.CoinsSpent })
                .ToList();

            // Top EXP
            ViewBag.TopExpByDay = _context.Users
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
                .Take(5)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.ExpPoints })
                .ToList();

            ViewBag.TopExpByMonth = _context.Users
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
                .Take(5)
                .Select((u, index) => new { Rank = index + 1, u.Username, u.ExpPoints })
                .ToList();

            ViewBag.TopExpAllTime = _context.Users
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    u.ExpPoints
                })
                .AsEnumerable()
                .OrderByDescending(u => u.ExpPoints)
                .Take(5)
                .Select((u, index) => new { Rank = index + 1, u.Username, ExpPoints = u.ExpPoints ?? 0 })
                .ToList();
        }

        public IActionResult Index(int page = 1)
        {
            int pageSize = 24;

            // Gọi GetRankings để gán dữ liệu vào ViewBag
            GetRankings();

            // Lấy danh sách truyện mới (IsNew = true)
            var newStories = _context.Stories
                .Where(s => s.IsNew)
                .Include(s => s.Chapters)
                .Include(s => s.StoryGenres).ThenInclude(sg => sg.Genre)
                .OrderByDescending(s => s.CreatedAt)
                .Take(11)
                .ToList();

            // Lấy danh sách truyện hot (IsHot = true)
            var hotStories = _context.Stories
                .Where(s => s.IsHot)
                .Include(s => s.Chapters)
                .Include(s => s.StoryGenres).ThenInclude(sg => sg.Genre)
                .OrderByDescending(s => s.LastUpdatedAt)
                .Take(5)
                .ToList();

            // Lấy danh sách truyện mới cập nhật với phân trang
            var updatedStoriesQuery = _context.Stories
                .Include(s => s.Chapters)
                .Include(s => s.StoryGenres).ThenInclude(sg => sg.Genre)
                .OrderByDescending(s => s.Chapters.Max(c => c.CreatedAt ?? DateTime.MinValue));

            var totalStories = updatedStoriesQuery.Count();
            var updatedStories = updatedStoriesQuery
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            // Truyền dữ liệu khác vào ViewBag
            ViewBag.NewStories = newStories;
            ViewBag.HotStories = hotStories;
            ViewBag.UpdatedStories = updatedStories;
            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = (int)Math.Ceiling(totalStories / (double)pageSize);

            var stories = _context.Stories.ToList();
            return View(stories);
        }

        public IActionResult Details(int? id, int commentPage = 1)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");

            if (id == null)
            {
                return NotFound();
            }

            // Tải thông tin truyện
            var story = _context.Stories
                .Include(s => s.StoryGenres).ThenInclude(sg => sg.Genre)
                .Include(s => s.Chapters)
                .FirstOrDefault(s => s.StoryId == id);

            if (story == null)
            {
                return NotFound();
            }

            // Tính số đếm
            int favoriteCount = _context.Favorites.Count(f => f.StoryId == id);
            int viewCount = _context.ReadingHistories.Count(r => r.StoryId == id);
            int followerCount = _context.FollowedStories.Count(f => f.StoryId == id);

            // Phân trang bình luận gốc
            int pageSize = 6;
            var rootCommentsQuery = _context.Comments
                .Where(c => c.StoryId == id && c.ParentCommentId == null)
                .OrderByDescending(c => c.CreatedAt)
                .Include(c => c.User).ThenInclude(u => u.AvatarFrame)
                .Include(c => c.User).ThenInclude(u => u.CategoryRank)
                .Include(c => c.InverseParentComment).ThenInclude(r => r.User).ThenInclude(u => u.AvatarFrame)
                .Include(c => c.InverseParentComment).ThenInclude(r => r.User).ThenInclude(u => u.CategoryRank)
                .Include(c => c.Sticker)
                .Include(c => c.InverseParentComment).ThenInclude(r => r.Sticker);

            var totalRootComments = rootCommentsQuery.Count();
            var comments = rootCommentsQuery
                .Skip((commentPage - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            // Tải danh sách nhãn dán
            var stickers = _context.Stickers.ToList();

            // Gọi GetRankings để gán dữ liệu vào ViewBag
            GetRankings();

            // Truyền dữ liệu vào ViewBag
            ViewBag.FavoriteCount = favoriteCount;
            ViewBag.ViewCount = viewCount;
            ViewBag.FollowerCount = followerCount;
            ViewBag.Comments = comments;
            ViewBag.CurrentCommentPage = commentPage;
            ViewBag.TotalCommentPages = (int)Math.Ceiling(totalRootComments / (double)pageSize);
            ViewBag.ReadingHistories = _context.ReadingHistories
                .Where(r => r.UserId == userId && r.StoryId == id)
                .ToList();
            ViewBag.IsFavorited = userId.HasValue && _context.Favorites.Any(f => f.UserId == userId && f.StoryId == id);
            ViewBag.IsFollowed = userId.HasValue && _context.FollowedStories.Any(f => f.UserId == userId && f.StoryId == id);
            ViewBag.CurrentUserId = userId;
            ViewBag.Stickers = stickers;

            return View(story);
        }

        [HttpGet]
        public IActionResult SearchSuggestions(string query)
        {
            try
            {
                if (string.IsNullOrEmpty(query))
                {
                    return Json(new List<object>());
                }

                var searchTerm = query.ToLower();
                var suggestions = _context.Stories
                    .Where(s => !string.IsNullOrEmpty(s.Title) && s.Title.ToLower().Contains(searchTerm))
                    .Select(s => new
                    {
                        storyId = s.StoryId,
                        coverImage = s.CoverImage,
                        title = s.Title
                    })
                    .Take(10)
                    .ToList();

                return Json(suggestions);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in SearchSuggestions for query: {Query}", query);
                return Json(new { error = "Có lỗi xảy ra khi tìm kiếm gợi ý. Vui lòng thử lại sau." });
            }
        }

        [HttpGet]
        public IActionResult Search(string key_word)
        {
            if (string.IsNullOrEmpty(key_word))
            {
                ViewBag.SearchQuery = "";
                return View(new List<Story>());
            }

            var searchTerm = key_word.ToLower();
            var searchResults = _context.Stories
                ?.Where(s => s.Title.ToLower().Contains(searchTerm))
                .Include(s => s.Chapters)
                .Include(s => s.StoryGenres).ThenInclude(sg => sg.Genre)
                .OrderByDescending(s => s.LastUpdatedAt)
                .ToList() ?? new List<Story>();

            ViewBag.SearchQuery = key_word;
            return View(searchResults);
        }

        [HttpGet]
        public IActionResult GetComments(int id, int commentPage = 1)
        {
            int pageSize = 6;
            var rootCommentsQuery = _context.Comments
                .Where(c => c.StoryId == id && c.ParentCommentId == null)
                .OrderByDescending(c => c.CreatedAt)
                .Include(c => c.User).ThenInclude(u => u.AvatarFrame)
                .Include(c => c.User).ThenInclude(u => u.CategoryRank)
                .Include(c => c.InverseParentComment).ThenInclude(r => r.User).ThenInclude(u => u.AvatarFrame)
                .Include(c => c.InverseParentComment).ThenInclude(r => r.User).ThenInclude(u => u.CategoryRank)
                .Include(c => c.Sticker)
                .Include(c => c.InverseParentComment).ThenInclude(r => r.Sticker);

            var totalRootComments = rootCommentsQuery.Count();
            var comments = rootCommentsQuery
                .Skip((commentPage - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.Comments = comments;
            ViewBag.CurrentCommentPage = commentPage;
            ViewBag.TotalCommentPages = (int)Math.Ceiling(totalRootComments / (double)pageSize);
            ViewBag.StoryId = id;
            ViewBag.CurrentUserId = HttpContext.Session.GetInt32("UsersID");
            ViewBag.Stickers = _context.Stickers.ToList();

            return PartialView("_CommentsPartial");
        }

        public IActionResult GetGenres()
        {
            var genres = _context.Genres.ToList();
            return PartialView("_GenreDropdown", genres);
        }

        public IActionResult StoriesByGenre(int genreId)
        {
            var stories = _context.Stories
                .Include(s => s.StoryGenres).ThenInclude(sg => sg.Genre)
                .Where(s => s.StoryGenres.Any(sg => sg.GenreId == genreId))
                .Include(s => s.Chapters)
                .OrderByDescending(s => s.LastUpdatedAt)
                .ToList();

            ViewBag.GenreName = _context.Genres
                .Where(g => g.GenreId == genreId)
                .Select(g => g.Name)
                .FirstOrDefault();

            return View(stories);
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