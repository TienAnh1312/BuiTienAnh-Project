using System.Diagnostics;
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

        // Constructor duy nhất để nhận cả ILogger và WebMangaContext
        public HomeController(ILogger<HomeController> logger, WebMangaContext context)
        {
            _logger = logger;
            _context = context;
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
            var story = _context.Stories
                        .Include(s => s.StoryGenres)  // Bao gồm thể loại
                        .ThenInclude(sg => sg.Genre)
                        .Include(s => s.Chapters)    // Bao gồm danh sách các chương
                        .FirstOrDefault(s => s.StoryId == id);

            if (story == null)
            {
                return NotFound(); // Nếu không tìm thấy truyện
            }

            return View(story); // Truyền truyện vào view
        }

        public IActionResult ReadChapter(int id)
        {
            var chapter = _context.Chapters
                                  .Include(c => c.ChapterImages) // Bao gồm ảnh chương
                                  .FirstOrDefault(c => c.ChapterId == id);

            if (chapter == null)
            {
                return NotFound();
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

            // Truyền chương hiện tại, chương trước và chương sau vào View
            ViewBag.PreviousChapter = previousChapter;
            ViewBag.NextChapter = nextChapter;

            return View(chapter);
        }


        public IActionResult Privacy()
        {
            return View();
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