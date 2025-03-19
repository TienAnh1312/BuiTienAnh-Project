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
            string chapterCode = $"{story.StoryCode}_C{chapterNumber}"; // Ví dụ: "CH_C1"

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

            // Xử lý upload hình ảnh 
            if (ImageFiles != null && ImageFiles.Count > 0)
            {
                var chapterFolder = Path.Combine("images", "admins", "stories", $"chapter_{chapter.ChapterId}");
                var fullFolderPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", chapterFolder);
                if (!Directory.Exists(fullFolderPath))
                {
                    Directory.CreateDirectory(fullFolderPath);
                }

                int pageNumber = 1;
                foreach (var file in ImageFiles)
                {
                    if (file.Length > 0)
                    {
                        var fileExtension = Path.GetExtension(file.FileName);
                        var uniqueFileName = $"{chapterNumber}_{pageNumber}_{Guid.NewGuid()}{fileExtension}";
                        var filePath = Path.Combine(fullFolderPath, uniqueFileName);

                        using (var stream = new FileStream(filePath, FileMode.Create))
                        {
                            await file.CopyToAsync(stream);
                        }

                        var chapterImage = new ChapterImage
                        {
                            ChapterId = chapter.ChapterId,
                            PageNumber = pageNumber++,
                            ImageUrl = Path.Combine(chapterFolder, uniqueFileName).Replace("\\", "/")
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

            ViewBag.StoryId = storyId;
            ViewBag.StoryTitle = story.Title;
            return View();
        }

        // POST: Admins/Chapters/BulkCreate
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> BulkCreate(int storyId, int count, int defaultCoins, bool defaultIsLocked)
        {
            if (count < 1 || defaultCoins < 0)
            {
                TempData["Error"] = count < 1 ? "Số lượng phải lớn hơn hoặc bằng 1" : "Số xu không thể âm";
                return RedirectToAction(nameof(Index), new { storyId }); 
            }

            var story = await _context.Stories.FirstOrDefaultAsync(s => s.StoryId == storyId);
            if (story == null)
            {
                return NotFound();
            }

            var existingChapters = await _context.Chapters
                .Where(c => c.StoryId == storyId)
                .Select(c => c.ChapterTitle)
                .ToListAsync();

            int maxChapterNumber = 0;
            foreach (var title in existingChapters)
            {
                if (int.TryParse(title.Replace("Chương ", ""), out int num) && num > maxChapterNumber)
                {
                    maxChapterNumber = num;
                }
            }

            var newChapters = new List<Chapter>();
            for (int i = 1; i <= count; i++)
            {
                var chapterNumber = maxChapterNumber + i;
                var chapterTitle = $"Chương {chapterNumber}";
                var chapterCode = $"{story.StoryCode}_C{chapterNumber}"; // Ví dụ: "CH_C1"

                if (existingChapters.Contains(chapterTitle))
                {
                    continue;
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
                TempData["Success"] = $"Đã tạo thành công {newChapters.Count} Chương mới";
            }
            else
            {
                TempData["Error"] = "Không tạo được Chương mới do số chapter đã tồn tại";
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
                    // Lấy chapter từ context để cập nhật
                    var chapterToUpdate = await _context.Chapters
                        .Include(c => c.Story) // Include Story để lấy StoryCode
                        .FirstOrDefaultAsync(c => c.ChapterId == id);

                    if (chapterToUpdate == null)
                    {
                        return NotFound();
                    }

                    // Cập nhật ChapterTitle và ChapterCode dựa trên chapterNumber mới
                    chapterToUpdate.ChapterTitle = newChapterTitle;
                    chapterToUpdate.ChapterCode = $"{chapterToUpdate.Story.StoryCode}_C{chapterNumber}"; // Tự động cập nhật ChapterCode
                    chapterToUpdate.CreatedAt = chapter.CreatedAt;
                    chapterToUpdate.Coins = chapter.Coins;
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

            // Khi ModelState không hợp lệ, lấy ChapterCode gốc từ database
            var originalChapter = await _context.Chapters
                .Include(c => c.Story)
                .FirstOrDefaultAsync(c => c.ChapterId == id);

            if (originalChapter == null)
            {
                return NotFound();
            }

            // Gán lại ChapterCode để hiển thị trong view
            chapter.ChapterCode = originalChapter.ChapterCode;

            // Tải lại Story để view có đủ dữ liệu
            chapter.Story = await _context.Stories.FirstOrDefaultAsync(s => s.StoryId == chapter.StoryId);
            if (chapter.Story == null)
            {
                return NotFound();
            }
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
