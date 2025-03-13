using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
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
                .Where(c => c.StoryId == storyId)
                .ToListAsync();

            var story = await _context.Stories.FirstOrDefaultAsync(s => s.StoryId == storyId);
            if (story == null)
            {
                return NotFound();
            }

            ViewBag.StoryId = storyId;
            ViewBag.StoryTitle = story.Title; // Truyền tiêu đề để hiển thị trong view
            return View(chapters);
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
            if (!ModelState.IsValid)
            {
                ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "Title", StoryId);
                return View(new Chapter { StoryId = StoryId });
            }

            var chapter = new Chapter
            {
                StoryId = StoryId,
                ChapterTitle = $"Chương {chapterNumber}",
                CreatedAt = DateTime.Now,
                Coins = Coins // Thêm số xu mở khóa
            };

            _context.Add(chapter);
            await _context.SaveChangesAsync();

            // Xử lý upload hình ảnh nếu có
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

        // GET: Admins/Chapters/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chapter = await _context.Chapters
                .Include(c => c.Story) // Load story của chapter đó
                .FirstOrDefaultAsync(m => m.ChapterId == id);

            if (chapter == null)
            {
                return NotFound();
            }

            // Chỉ load story của chapter này
            ViewData["StoryId"] = new SelectList(new List<Story> { chapter.Story }, "StoryId", "Title");

            return View(chapter);
        }

        // POST: Admins/Chapters/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ChapterId,StoryId,ChapterTitle,Content,CreatedAt,Coins,IsLocked")] Chapter chapter)
        {
            if (id != chapter.ChapterId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(chapter);
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

                // Chuyển hướng về danh sách chapters 
                return RedirectToAction(nameof(Index), new { storyId = chapter.StoryId });
            }
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "Title", chapter.StoryId);
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
                .Include(c => c.ChapterImages) // Load danh sách ảnh liên quan
                .FirstOrDefaultAsync(c => c.ChapterId == id);

            if (chapter == null)
            {
                return NotFound();
            }

            // Xử lý bản ghi trong followed_stories (nếu có từ lỗi trước)
            var followedStories = await _context.FollowedStories
                .Where(fs => fs.LastReadChapterId == chapter.ChapterId)
                .ToListAsync();
            if (followedStories.Any())
            {
                _context.FollowedStories.RemoveRange(followedStories); // Xóa các bản ghi liên quan
            }

            // Xử lý bản ghi trong reading_history
            var readingHistories = await _context.ReadingHistories
                .Where(rh => rh.ChapterId == chapter.ChapterId)
                .ToListAsync();
            if (readingHistories.Any())
            {
                _context.ReadingHistories.RemoveRange(readingHistories); // Xóa các bản ghi liên quan
            }

            // Xóa các file ảnh trong thư mục wwwroot
            if (chapter.ChapterImages != null && chapter.ChapterImages.Any())
            {
                foreach (var chapterImage in chapter.ChapterImages)
                {
                    if (!string.IsNullOrEmpty(chapterImage.ImageUrl))
                    {
                        var imagePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", chapterImage.ImageUrl);
                        if (System.IO.File.Exists(imagePath))
                        {
                            System.IO.File.Delete(imagePath);
                        }
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
