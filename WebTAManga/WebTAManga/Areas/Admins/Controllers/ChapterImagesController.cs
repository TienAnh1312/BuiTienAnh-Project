using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Areas.Admins.Services;
using WebTAManga.Models;
using Google.Apis.Drive.v3;

namespace WebTAManga.Areas.Admins.Controllers
{

    public class ChapterImagesController : BaseController
    {
        private readonly WebMangaContext _context;

        public ChapterImagesController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/ChapterImages
        public async Task<IActionResult> Index(int? chapterId)
        {
            if (chapterId == null)
            {
                return NotFound();
            }

            var chapterImages = _context.ChapterImages
                .Include(c => c.Chapter)
                .Where(ci => ci.ChapterId == chapterId); // Chỉ lấy ảnh của chapterId

            ViewData["ChapterId"] = chapterId; // Để sử dụng khi cần thêm ảnh mới

            return View(await chapterImages.ToListAsync());
        }


        // GET: Admins/ChapterImages/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chapterImage = await _context.ChapterImages
                .Include(c => c.Chapter)
                .FirstOrDefaultAsync(m => m.ImageId == id);
            if (chapterImage == null)
            {
                return NotFound();
            }

            return View(chapterImage);
        }

        // GET: Admins/ChapterImages/Create
        public IActionResult Create(int chapterId)
        {
            var chapter = _context.Chapters.Find(chapterId);
            if (chapter == null) return NotFound();

            var maxPageNumber = _context.ChapterImages
                                .Where(ci => ci.ChapterId == chapterId)
                                .Max(ci => (int?)ci.PageNumber) ?? 0;

            var chapterImage = new ChapterImage
            {
                ChapterId = chapterId,
                PageNumber = maxPageNumber + 1
            };

            ViewData["ChapterTitle"] = chapter.ChapterTitle;
            return View(chapterImage);
        }

        // POST: Admins/ChapterImages/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(int chapterId, List<IFormFile> ImageFiles, [FromServices] GoogleDriveService googleDriveService)
        {
            if (ImageFiles == null || ImageFiles.Count == 0)
            {
                ModelState.AddModelError("ImageFiles", "Vui lòng chọn ít nhất một ảnh.");
                var chapter = await _context.Chapters.FindAsync(chapterId);
                ViewData["ChapterTitle"] = chapter?.ChapterTitle;
                return View(new ChapterImage { ChapterId = chapterId });
            }

            var maxPageNumber = _context.ChapterImages
                                .Where(ci => ci.ChapterId == chapterId)
                                .Max(ci => (int?)ci.PageNumber) ?? 0;

            foreach (var file in ImageFiles)
            {
                if (file.Length > 0)
                {
                    var uniqueFileName = $"{Path.GetFileNameWithoutExtension(file.FileName)}_{Guid.NewGuid()}{Path.GetExtension(file.FileName)}";
                    var (fileId, webViewLink) = await googleDriveService.UploadFileAsync(file, uniqueFileName);

                    var chapterImage = new ChapterImage
                    {
                        ChapterId = chapterId,
                        PageNumber = ++maxPageNumber,
                        ImageUrl = webViewLink,
                        FileId = fileId
                    };

                    _context.Add(chapterImage);
                }
            }

            await _context.SaveChangesAsync();
            return RedirectToAction("Index", new { chapterId });
        }

        // GET: Admins/ChapterImages/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null) return NotFound();

            var chapterImage = await _context.ChapterImages
                .Include(ci => ci.Chapter)
                .FirstOrDefaultAsync(ci => ci.ImageId == id);

            if (chapterImage == null) return NotFound();

            ViewData["ChapterId"] = new SelectList(_context.Chapters, "ChapterId", "ChapterTitle", chapterImage.ChapterId);
            return View(chapterImage);
        }

        // POST: Admins/ChapterImages/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ImageId,ChapterId,PageNumber,FileId")] ChapterImage chapterImage, IFormFile ImageUrl, [FromServices] GoogleDriveService googleDriveService)
        {
            if (id != chapterImage.ImageId) return NotFound();

            var existingImage = await _context.ChapterImages.FindAsync(id);
            if (existingImage == null) return NotFound();

            var existingPage = await _context.ChapterImages
                .FirstOrDefaultAsync(ci => ci.ChapterId == chapterImage.ChapterId
                    && ci.PageNumber == chapterImage.PageNumber
                    && ci.ImageId != chapterImage.ImageId);

            if (existingPage != null)
            {
                ModelState.AddModelError("PageNumber", $"Số trang {chapterImage.PageNumber} đã tồn tại trong chapter này.");
            }

            if (ImageUrl == null || ImageUrl.Length == 0)
            {
                ModelState.Remove("ImageUrl");
            }

            if (!ModelState.IsValid)
            {
                ViewData["ImageUrl"] = existingImage.ImageUrl;
                ViewData["ChapterId"] = new SelectList(_context.Chapters, "ChapterId", "ChapterTitle", chapterImage.ChapterId);
                return View(chapterImage);
            }

            try
            {
                if (ImageUrl != null && ImageUrl.Length > 0)
                {
                    var uniqueFileName = $"{Path.GetFileNameWithoutExtension(ImageUrl.FileName)}_{Guid.NewGuid()}{Path.GetExtension(ImageUrl.FileName)}";
                    var (newFileId, newWebViewLink) = await googleDriveService.UploadFileAsync(ImageUrl, uniqueFileName);

                    // Xóa ảnh cũ nếu tồn tại, không dừng lại nếu lỗi NotFound
                    if (!string.IsNullOrEmpty(existingImage.FileId))
                    {
                        await googleDriveService.DeleteFileAsync(existingImage.FileId);
                    }

                    existingImage.ImageUrl = newWebViewLink;
                    existingImage.FileId = newFileId;
                }

                existingImage.PageNumber = chapterImage.PageNumber;
                _context.Update(existingImage);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ChapterImageExists(chapterImage.ImageId)) return NotFound();
                else throw;
            }

            return RedirectToAction("Index", new { chapterId = chapterImage.ChapterId });
        }

        // GET: Admins/ChapterImages/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chapterImage = await _context.ChapterImages
                .Include(c => c.Chapter)
                .FirstOrDefaultAsync(m => m.ImageId == id);
            if (chapterImage == null)
            {
                return NotFound();
            }

            return View(chapterImage);
        }

        // POST: Admins/ChapterImages/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id, [FromServices] GoogleDriveService googleDriveService)
        {
            var chapterImage = await _context.ChapterImages.FindAsync(id);
            if (chapterImage != null)
            {
                if (!string.IsNullOrEmpty(chapterImage.FileId))
                {
                    await googleDriveService.DeleteFileAsync(chapterImage.FileId);
                }

                _context.ChapterImages.Remove(chapterImage);
                await _context.SaveChangesAsync();
                return RedirectToAction("Index", new { chapterId = chapterImage.ChapterId });
            }
            return NotFound();
        }

        // POST: Admins/ChapterImages/BulkDelete
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> BulkDelete(int chapterId, List<int> selectedIds, [FromServices] GoogleDriveService googleDriveService)
        {
            if (selectedIds == null || !selectedIds.Any())
            {
                ModelState.AddModelError("", "Vui lòng chọn ít nhất một ảnh để xóa.");
                return RedirectToAction("Index", new { chapterId });
            }

            var chapterImages = await _context.ChapterImages
                                              .Where(ci => selectedIds.Contains(ci.ImageId))
                                              .ToListAsync();

            foreach (var image in chapterImages)
            {
                if (!string.IsNullOrEmpty(image.FileId))
                {
                    await googleDriveService.DeleteFileAsync(image.FileId);
                }
            }

            _context.ChapterImages.RemoveRange(chapterImages);
            await _context.SaveChangesAsync();

            return RedirectToAction("Index", new { chapterId });
        }

        private bool ChapterImageExists(int id)
        {
            return _context.ChapterImages.Any(e => e.ImageId == id);
        }
    }
}