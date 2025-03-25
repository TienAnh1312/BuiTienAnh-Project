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
                .Where(ci => ci.ChapterId == chapterId);

            ViewData["ChapterId"] = chapterId;
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

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(int chapterId, List<IFormFile> ImageFiles, [FromServices] GoogleDriveService googleDriveService)
        {
            // Kiểm tra chapter có tồn tại không
            var chapter = await _context.Chapters.FindAsync(chapterId);
            if (chapter == null)
            {
                TempData["Error"] = "Chapter không tồn tại.";
                return RedirectToAction("Index", new { chapterId });
            }

            // Kiểm tra danh sách file ảnh
            if (ImageFiles == null || ImageFiles.Count == 0 || ImageFiles.All(f => f == null || f.Length == 0))
            {
                TempData["Error"] = "Vui lòng chọn ít nhất một ảnh hợp lệ.";
                return View(new ChapterImage { ChapterId = chapterId });
            }

            // Lấy số trang lớn nhất hiện tại
            var maxPageNumber = _context.ChapterImages
                .Where(ci => ci.ChapterId == chapterId)
                .Max(ci => (int?)ci.PageNumber) ?? 0;

            var chapterImagesToAdd = new List<ChapterImage>();

            // Xử lý từng file ảnh
            foreach (var file in ImageFiles)
            {
                if (file == null || file.Length == 0) continue;

                try
                {
                    // Tạo tên file duy nhất
                    var uniqueFileName = $"{Path.GetFileNameWithoutExtension(file.FileName)}_{Guid.NewGuid()}{Path.GetExtension(file.FileName)}";

                    // Tải file lên Google Drive và nhận đường link
                    var (fileId, webViewLink) = await googleDriveService.UploadFileAsync(file, uniqueFileName);

                    // Tạo đối tượng ChapterImage với đường link
                    var chapterImage = new ChapterImage
                    {
                        ChapterId = chapterId,
                        PageNumber = ++maxPageNumber,
                        ImageUrl = webViewLink, // Lưu đường link vào đây
                        FileId = fileId,        // Lưu ID file để quản lý
                        StoryId = chapter.StoryId
                    };

                    chapterImagesToAdd.Add(chapterImage);
                }
                catch (Exception ex)
                {
                    TempData["Error"] = $"Lỗi khi tải lên tệp {file.FileName}: {ex.Message}";
                    return View(new ChapterImage { ChapterId = chapterId });
                }
            }

            // Lưu vào cơ sở dữ liệu
            if (chapterImagesToAdd.Any())
            {
                try
                {
                    _context.ChapterImages.AddRange(chapterImagesToAdd);
                    await _context.SaveChangesAsync();
                    TempData["Success"] = $"Thêm {chapterImagesToAdd.Count} ảnh thành công! Đường link đã được lưu vào cơ sở dữ liệu.";
                }
                catch (Exception ex)
                {
                    TempData["Error"] = $"Lỗi khi lưu vào cơ sở dữ liệu: {ex.Message}";
                    return View(new ChapterImage { ChapterId = chapterId });
                }
            }

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
        public async Task<IActionResult> GetImage(int imageId)
        {
            var chapterImage = await _context.ChapterImages.FindAsync(imageId);
            if (chapterImage == null || string.IsNullOrEmpty(chapterImage.ImageUrl))
            {
                return NotFound();
            }

            try
            {
                using var client = new HttpClient();
                var response = await client.GetAsync(chapterImage.ImageUrl);
                if (!response.IsSuccessStatusCode)
                {
                    return NotFound();
                }

                var stream = await response.Content.ReadAsStreamAsync();
                var contentType = response.Content.Headers.ContentType?.MediaType ?? "image/jpeg";
                return File(stream, contentType);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Lỗi khi tải hình ảnh: {ex.Message}");
                return NotFound();
            }
        }
        private bool ChapterImageExists(int id)
        {
            return _context.ChapterImages.Any(e => e.ImageId == id);
        }
    }
}