using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Areas.Admins.Models;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    public class ChaptersController : BaseController
    {
        private readonly WebMangaContext _context;

        public ChaptersController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Chapters
        public async Task<IActionResult> Index(int? storyId)
        {
            if (storyId == null)
            {
                return NotFound();
            }

            var chapters = await _context.Chapters
                .Include(c => c.Story)
                .Include(c => c.ChapterImages) 
                .Where(c => c.StoryId == storyId)
                .ToListAsync();

            var sortedChapters = chapters
                .OrderByDescending(c => int.TryParse(c.ChapterTitle?.Replace("Chương ", ""), out int num) ? num : 0)
                .ToList();

            var story = await _context.Stories.FirstOrDefaultAsync(s => s.StoryId == storyId);
            if (story == null)
            {
                return NotFound();
            }

            ViewBag.StoryId = storyId;
            ViewBag.StoryTitle = story.Title;
            return View(sortedChapters);
        }

        // GET: Admins/Chapters/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chapter = await _context.Chapters
                .Include(c => c.Story)
                .FirstOrDefaultAsync(m => m.ChapterId == id);
            if (chapter == null)
            {
                return NotFound();
            }

            return View(chapter);
        }

        // GET: Admins/Chapters/Create
        public IActionResult Create(int? storyId)
        {
            if (storyId == null)
            {
                return NotFound();
            }

            // Lấy danh sách ChapterTitle và tìm số lớn nhất
            var chapterTitles = _context.Chapters
                .Where(c => c.StoryId == storyId)
                .Select(c => c.ChapterTitle)
                .Where(t => t.StartsWith("Chương "))
                .ToList();

            int maxChapterNumber = 0;
            foreach (var title in chapterTitles)
            {
                if (int.TryParse(title.Replace("Chương ", ""), out int num))
                {
                    if (num > maxChapterNumber)
                    {
                        maxChapterNumber = num;
                    }
                }
            }

            var nextChapterNumber = maxChapterNumber + 1;

            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "Title", storyId);
            return View(new Chapter { StoryId = storyId.Value, ChapterTitle = $"Chương {nextChapterNumber}" });
        }

        // POST: Admins/Chapters/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(int StoryId, int chapterNumber, int Coins, List<IFormFile> ImageFiles)
        {
            var story = await _context.Stories.FirstOrDefaultAsync(s => s.StoryId == StoryId);
            if (story == null)
            {
                return NotFound();
            }

            string chapterTitle = $"Chương {chapterNumber}";
            string chapterCode = $"{story.StoryCode}_C{chapterNumber}";

            var existingChapter = await _context.Chapters
                .FirstOrDefaultAsync(c => c.StoryId == StoryId && c.ChapterTitle == chapterTitle);

            if (existingChapter != null)
            {
                ModelState.AddModelError("chapterNumber", $"Chương {chapterNumber} đã tồn tại cho Truyện này.");
            }

            if (!ModelState.IsValid)
            {
                ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "Title", StoryId);
                return View(new Chapter { StoryId = StoryId });
            }

            var chapter = new Chapter
            {
                StoryId = StoryId,
                ChapterTitle = chapterTitle,
                ChapterCode = chapterCode,
                CreatedAt = DateTime.Now,
                Coins = Coins
            };

            _context.Add(chapter);
            await _context.SaveChangesAsync();

            // Tạo thư mục cho Chapter với tên "ChapterTitle(ChapterCode)"
            var storyFolderName = $"{story.Title}({story.StoryCode})";
            var chapterFolderName = $"{chapterTitle}({chapterCode})";
            var chapterFolderPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "stories", storyFolderName, chapterFolderName);
            if (!Directory.Exists(chapterFolderPath))
            {
                Directory.CreateDirectory(chapterFolderPath);
            }

            // Xử lý upload hình ảnh
            if (ImageFiles != null && ImageFiles.Count > 0)
            {
                int pageNumber = 1;
                foreach (var file in ImageFiles)
                {
                    if (file.Length > 0)
                    {
                        var fileExtension = Path.GetExtension(file.FileName);
                        var uniqueFileName = $"Page_{pageNumber}{fileExtension}"; // Tên ảnh theo PageNumber
                        var filePath = Path.Combine(chapterFolderPath, uniqueFileName);

                        using (var stream = new FileStream(filePath, FileMode.Create))
                        {
                            await file.CopyToAsync(stream);
                        }

                        var chapterImage = new ChapterImage
                        {
                            ChapterId = chapter.ChapterId,
                            PageNumber = pageNumber++,
                            ImageUrl = $"images/admins/stories/{storyFolderName}/{chapterFolderName}/{uniqueFileName}"
                        };
                        _context.ChapterImages.Add(chapterImage);
                    }
                }
                await _context.SaveChangesAsync();
            }

            return RedirectToAction(nameof(Index), new { storyId = chapter.StoryId });
        }

        // GET: Admins/Chapters/BulkCreate
        //Thêm mới nhiều Chương truyện
        public async Task<IActionResult> BulkCreate(int? storyId)
        {
            if (storyId == null)
            {
                return NotFound();
            }

            var story = await _context.Stories.FirstOrDefaultAsync(s => s.StoryId == storyId);
            if (story == null)
            {
                return NotFound();
            }

            // Lấy danh sách các chapter
            var existingChapters = await _context.Chapters
                .Where(c => c.StoryId == storyId)
                .Select(c => c.ChapterTitle)
                .ToListAsync();

            ViewBag.StoryId = storyId;
            ViewBag.StoryTitle = story.Title;
            ViewBag.ExistingChapters = existingChapters; // Truyền danh sách chapter hiện có
            return View();
        }

        // POST: Admins/Chapters/BulkCreate
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> BulkCreate(int storyId, int startChapter, int endChapter, int defaultCoins, bool defaultIsLocked)
        {
            if (startChapter < 1 || endChapter < startChapter || defaultCoins < 0)
            {
                TempData["Error"] = "Vùng chapter không hợp lệ hoặc số xu không thể âm.";
                return RedirectToAction(nameof(Index), new { storyId });
            }

            var story = await _context.Stories.FirstOrDefaultAsync(s => s.StoryId == storyId);
            if (story == null)
            {
                return NotFound();
            }

            // Lấy danh sách chapter hiện có
            var existingChapters = await _context.Chapters
                .Where(c => c.StoryId == storyId)
                .Select(c => c.ChapterTitle)
                .ToListAsync();

            var newChapters = new List<Chapter>();
            for (int i = startChapter; i <= endChapter; i++)
            {
                var chapterTitle = $"Chương {i}";
                var chapterCode = $"{story.StoryCode}_C{i}";

                // Kiểm tra xem chapter đã tồn tại chưa
                if (existingChapters.Contains(chapterTitle))
                {
                    continue; // Bỏ qua chapter đã tồn tại
                }

                newChapters.Add(new Chapter
                {
                    StoryId = storyId,
                    ChapterTitle = chapterTitle,
                    ChapterCode = chapterCode,
                    CreatedAt = DateTime.Now,
                    Coins = defaultCoins,
                    IsLocked = defaultIsLocked
                });
            }

            if (newChapters.Any())
            {
                _context.Chapters.AddRange(newChapters);
                await _context.SaveChangesAsync();
                TempData["Success"] = $"Đã tạo thành công {newChapters.Count} chapter mới.";
            }
            else
            {
                TempData["Error"] = "Không tạo được chapter mới do tất cả chapter trong khoảng đã tồn tại.";
            }

            return RedirectToAction(nameof(Index), new { storyId });
        }

        // GET: Admins/Chapters/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chapter = await _context.Chapters
                .Include(c => c.Story) // Tải thông tin Story
                .FirstOrDefaultAsync(m => m.ChapterId == id);

            if (chapter == null || chapter.Story == null) // Kiểm tra cả chapter và Story
            {
                return NotFound();
            }

            ViewData["StoryId"] = new SelectList(new List<Story> { chapter.Story }, "StoryId", "Title");
            return View(chapter);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, int chapterNumber, [Bind("ChapterId,StoryId,Content,CreatedAt,Coins,IsLocked")] Chapter chapter)
        {
            if (id != chapter.ChapterId)
            {
                return NotFound();
            }

            string newChapterTitle = $"Chương {chapterNumber}";
            var existingChapter = await _context.Chapters
                .FirstOrDefaultAsync(c => c.StoryId == chapter.StoryId
                    && c.ChapterTitle == newChapterTitle
                    && c.ChapterId != chapter.ChapterId);

            if (existingChapter != null)
            {
                ModelState.AddModelError("chapterNumber", $"Chương {chapterNumber} đã tồn tại cho Truyện này.");
            }

            if (ModelState.IsValid)
            {
                try
                {
                    var chapterToUpdate = await _context.Chapters
                        .Include(c => c.Story)
                        .FirstOrDefaultAsync(c => c.ChapterId == id);

                    if (chapterToUpdate == null)
                    {
                        return NotFound();
                    }

                    // Cập nhật thông tin
                    chapterToUpdate.ChapterTitle = newChapterTitle;
                    chapterToUpdate.ChapterCode = $"{chapterToUpdate.Story.StoryCode}_C{chapterNumber}";
                    chapterToUpdate.CreatedAt = chapter.CreatedAt;
                    chapterToUpdate.Coins = (bool)chapter.IsLocked ? chapter.Coins : 0; // Nếu mở khóa, đặt Coins về 0
                    chapterToUpdate.IsLocked = chapter.IsLocked;

                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ChapterExists(chapter.ChapterId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index), new { storyId = chapter.StoryId });
            }

            // Xử lý khi ModelState không hợp lệ
            var originalChapter = await _context.Chapters
                .Include(c => c.Story)
                .FirstOrDefaultAsync(c => c.ChapterId == id);

            if (originalChapter == null)
            {
                return NotFound();
            }

            chapter.ChapterCode = originalChapter.ChapterCode;
            chapter.Story = await _context.Stories.FirstOrDefaultAsync(s => s.StoryId == chapter.StoryId);
            ViewData["StoryId"] = new SelectList(new List<Story> { chapter.Story }, "StoryId", "Title");
            return View(chapter);
        }

        // GET: Admins/Chapters/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chapter = await _context.Chapters
                .Include(c => c.Story)
                .FirstOrDefaultAsync(m => m.ChapterId == id);
            if (chapter == null)
            {
                return NotFound();
            }

            return View(chapter);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var chapter = await _context.Chapters
                .Include(c => c.ChapterImages)
                .FirstOrDefaultAsync(c => c.ChapterId == id);

            if (chapter == null)
            {
                return NotFound();
            }

            // Lưu ChapterCode để sử dụng sau này
            var chapterCode = chapter.ChapterCode;

            // Xóa các liên kết khác nhưng không xóa PurchasedChapter
            var followedStories = await _context.FollowedStories
                .Where(fs => fs.LastReadChapterId == chapter.ChapterId)
                .ToListAsync();
            if (followedStories.Any())
            {
                _context.FollowedStories.RemoveRange(followedStories);
            }

            var readingHistories = await _context.ReadingHistories
                .Where(rh => rh.ChapterId == chapter.ChapterId)
                .ToListAsync();
            if (readingHistories.Any())
            {
                _context.ReadingHistories.RemoveRange(readingHistories);
            }

            // Xóa ảnh
            if (chapter.ChapterImages != null && chapter.ChapterImages.Any())
            {
                foreach (var chapterImage in chapter.ChapterImages)
                {
                    var imagePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", chapterImage.ImageUrl);
                    if (System.IO.File.Exists(imagePath))
                    {
                        System.IO.File.Delete(imagePath);
                    }
                }
                _context.ChapterImages.RemoveRange(chapter.ChapterImages);
            }

            // Xóa chapter
            _context.Chapters.Remove(chapter);
            await _context.SaveChangesAsync();

            return RedirectToAction(nameof(Index), new { storyId = chapter.StoryId });
        }

        private bool ChapterExists(int id)
        {
            return _context.Chapters.Any(e => e.ChapterId == id);
        }
    }
}
