﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

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
            if (chapter == null)
            {
                return NotFound();
            }

            // Lấy số PageNumber lớn nhất hiện có trong chapter này
            var maxPageNumber = _context.ChapterImages
                                .Where(ci => ci.ChapterId == chapterId)
                                .Max(ci => (int?)ci.PageNumber) ?? 0;

            var chapterImage = new ChapterImage
            {
                ChapterId = chapterId,
                PageNumber = maxPageNumber + 1 // Tự động gán số trang tiếp theo
            };

            ViewData["ChapterTitle"] = chapter.ChapterTitle;
            return View(chapterImage);
        }

        // POST: Admins/ChapterImages/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(int chapterId, List<IFormFile> ImageFiles)
        {
            if (ImageFiles == null || ImageFiles.Count == 0)
            {
                ModelState.AddModelError("ImageFiles", "Vui lòng chọn ít nhất một ảnh.");
                var chapter = await _context.Chapters.FindAsync(chapterId);
                ViewData["ChapterTitle"] = chapter?.ChapterTitle;
                return View(new ChapterImage { ChapterId = chapterId });
            }

            // Lấy số PageNumber lớn nhất hiện có trong chapter này
            var maxPageNumber = _context.ChapterImages
                                .Where(ci => ci.ChapterId == chapterId)
                                .Max(ci => (int?)ci.PageNumber) ?? 0;

            // Tạo thư mục riêng cho chapter nếu chưa tồn tại
            var chapterFolder = Path.Combine("images", "admins", "stories", $"chapter_{chapterId}");
            var fullFolderPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", chapterFolder);
            if (!Directory.Exists(fullFolderPath))
            {
                Directory.CreateDirectory(fullFolderPath);
            }

            foreach (var file in ImageFiles)
            {
                if (file.Length > 0)
                {
                    // Tạo tên file duy nhất bằng cách thêm GUID hoặc timestamp
                    var fileExtension = Path.GetExtension(file.FileName);
                    var uniqueFileName = $"{Path.GetFileNameWithoutExtension(file.FileName)}_{Guid.NewGuid()}{fileExtension}";
                    var filePath = Path.Combine(fullFolderPath, uniqueFileName);

                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await file.CopyToAsync(stream);
                    }

                    // Tạo mới ChapterImage với số trang tự động tăng
                    var chapterImage = new ChapterImage
                    {
                        ChapterId = chapterId,
                        PageNumber = ++maxPageNumber, // Tự động tăng số trang
                        ImageUrl = Path.Combine(chapterFolder, uniqueFileName).Replace("\\", "/") // Lưu đường dẫn tương đối
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
            if (id == null)
            {
                return NotFound();
            }

            var chapterImage = await _context.ChapterImages
                .Include(ci => ci.Chapter) // thông tin chapter để lấy ChapterId
                .FirstOrDefaultAsync(ci => ci.ImageId == id);

            if (chapterImage == null)
            {
                return NotFound();
            }

            ViewData["ChapterId"] = new SelectList(_context.Chapters, "ChapterId", "ChapterTitle", chapterImage.ChapterId);
            return View(chapterImage);
        }

        // POST: Admins/ChapterImages/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ImageId,ChapterId,PageNumber")] ChapterImage chapterImage, IFormFile ImageUrl)
        {
            if (id != chapterImage.ImageId)
            {
                return NotFound();
            }

            var existingImage = await _context.ChapterImages.FindAsync(id);
            if (existingImage == null)
            {
                return NotFound();
            }

            var existingPage = await _context.ChapterImages
                .FirstOrDefaultAsync(ci => ci.ChapterId == chapterImage.ChapterId
                    && ci.PageNumber == chapterImage.PageNumber
                    && ci.ImageId != chapterImage.ImageId);

            if (existingPage != null)
            {
                ModelState.AddModelError("PageNumber", $"Số trang {chapterImage.PageNumber} đã tồn tại trong chapter này.");
            }

            // Loại bỏ lỗi xác thực cho ImageUrl nếu không có file được chọn
            if (ImageUrl == null || ImageUrl.Length == 0)
            {
                ModelState.Remove("ImageUrl");
            }

            if (!ModelState.IsValid)
            {
                // Bảo toàn ImageUrl hiện tại trong ViewData để hiển thị hình ảnh cũ
                ViewData["ImageUrl"] = existingImage.ImageUrl;
                ViewData["ChapterId"] = new SelectList(_context.Chapters, "ChapterId", "ChapterTitle", chapterImage.ChapterId);
                return View(chapterImage); // Trả về view với dữ liệu hiện tại, giữ nguyên ảnh cũ
            }

            try
            {
                string newImageUrl = existingImage.ImageUrl; // Giữ nguyên URL cũ mặc định

                // Nếu có file mới được upload
                if (ImageUrl != null && ImageUrl.Length > 0)
                {
                    // Lưu file mới trước
                    var chapterFolder = Path.Combine("images", "admins", "stories", $"chapter_{chapterImage.ChapterId}");
                    var fullFolderPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", chapterFolder);
                    if (!Directory.Exists(fullFolderPath))
                    {
                        Directory.CreateDirectory(fullFolderPath);
                    }

                    var fileExtension = Path.GetExtension(ImageUrl.FileName);
                    var uniqueFileName = $"{Path.GetFileNameWithoutExtension(ImageUrl.FileName)}_{Guid.NewGuid()}{fileExtension}";
                    var filePath = Path.Combine(fullFolderPath, uniqueFileName);

                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await ImageUrl.CopyToAsync(stream);
                    }

                    newImageUrl = Path.Combine(chapterFolder, uniqueFileName).Replace("\\", "/");

                    // Xóa ảnh cũ sau khi lưu thành công file mới
                    if (!string.IsNullOrEmpty(existingImage.ImageUrl))
                    {
                        var oldImagePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", existingImage.ImageUrl);
                        if (System.IO.File.Exists(oldImagePath))
                        {
                            System.IO.File.Delete(oldImagePath);
                        }
                    }
                }

                // Cập nhật thông tin
                existingImage.PageNumber = chapterImage.PageNumber;
                existingImage.ImageUrl = newImageUrl;
                _context.Update(existingImage);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ChapterImageExists(chapterImage.ImageId))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
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
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var chapterImage = await _context.ChapterImages.FindAsync(id);
            if (chapterImage != null)
            {
                // Xóa file ảnh trong thư mục wwwroot nếu tồn tại
                if (!string.IsNullOrEmpty(chapterImage.ImageUrl))
                {
                    var imagePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", chapterImage.ImageUrl);
                    if (System.IO.File.Exists(imagePath))
                    {
                        System.IO.File.Delete(imagePath);
                    }
                }

                // Xóa dữ liệu trong database
                _context.ChapterImages.Remove(chapterImage);
                await _context.SaveChangesAsync();

                return RedirectToAction("Index", new { chapterId = chapterImage.ChapterId });
            }

            return NotFound();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> BulkDelete(int chapterId, List<int> selectedIds)
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
                // Xóa tệp ảnh khỏi wwwroot nếu tồn tại
                if (!string.IsNullOrEmpty(image.ImageUrl))
                {
                    var imagePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", image.ImageUrl);
                    if (System.IO.File.Exists(imagePath))
                    {
                        System.IO.File.Delete(imagePath);
                    }
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