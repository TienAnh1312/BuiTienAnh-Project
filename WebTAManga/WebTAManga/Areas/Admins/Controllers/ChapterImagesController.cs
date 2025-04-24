using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Areas.Admins.Filters;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    [Authorize(Roles = "SuperAdmin, ContentManager")]

    public class ChapterImagesController : BaseController
    {
        private readonly WebMangaContext _context;

        public ChapterImagesController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/ChapterImages
        [PermissionAuthorize("ChapterImages", "View")]

        public async Task<IActionResult> Index(int? chapterId)
        {
            if (chapterId == null)
            {
                return NotFound();
            }

            var chapterImages = _context.ChapterImages
                .Include(c => c.Chapter)
                .Where(ci => ci.ChapterId == chapterId)
                .OrderBy(ci => ci.PageNumber); // Sắp xếp theo PageNumber tăng dần

            ViewData["ChapterId"] = chapterId;
            return View(await chapterImages.ToListAsync());
        }

        // GET: Admins/ChapterImages/Details/5
        [PermissionAuthorize("ChapterImages", "View")]

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
        [PermissionAuthorize("ChapterImages", "Create")]

        public IActionResult Create(int chapterId)
        {
            var chapter = _context.Chapters.Find(chapterId);
            if (chapter == null)
            {
                return NotFound();
            }

            // Lấy danh sách các số trang hiện có
            var existingPages = _context.ChapterImages
                .Where(ci => ci.ChapterId == chapterId)
                .Select(ci => ci.PageNumber)
                .ToList();

            var maxPageNumber = existingPages.Any() ? existingPages.Max() : 0;

            var chapterImage = new ChapterImage
            {
                ChapterId = chapterId,
                PageNumber = maxPageNumber + 1 // Mặc định là số trang lớn nhất + 1
            };

            ViewData["ChapterTitle"] = chapter.ChapterTitle;
            ViewData["ExistingPages"] = existingPages; // Truyền danh sách số trang hiện có vào view
            return View(chapterImage);
        }

        // POST: Admins/ChapterImages/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        [PermissionAuthorize("ChapterImages", "Create")]

        public async Task<IActionResult> Create(int chapterId, int pageNumber, List<IFormFile> ImageFiles)
        {
            var chapter = await _context.Chapters.Include(c => c.Story).FirstOrDefaultAsync(c => c.ChapterId == chapterId); // Khai báo một lần
            if (chapter == null)
            {
                return NotFound();
            }

            if (ImageFiles == null || ImageFiles.Count == 0)
            {
                ModelState.AddModelError("ImageFiles", "Vui lòng chọn ít nhất một ảnh.");
                ViewData["ChapterTitle"] = chapter.ChapterTitle;
                ViewData["ExistingPages"] = _context.ChapterImages
                    .Where(ci => ci.ChapterId == chapterId)
                    .Select(ci => ci.PageNumber)
                    .ToList();
                return View(new ChapterImage { ChapterId = chapterId, PageNumber = pageNumber });
            }

            // Kiểm tra số trang đã tồn tại
            var existingPage = _context.ChapterImages
                .FirstOrDefault(ci => ci.ChapterId == chapterId && ci.PageNumber == pageNumber);
            if (existingPage != null)
            {
                ModelState.AddModelError("PageNumber", $"Số trang {pageNumber} đã tồn tại trong chương này.");
                ViewData["ChapterTitle"] = chapter.ChapterTitle;
                ViewData["ExistingPages"] = _context.ChapterImages
                    .Where(ci => ci.ChapterId == chapterId)
                    .Select(ci => ci.PageNumber)
                    .ToList();
                return View(new ChapterImage { ChapterId = chapterId, PageNumber = pageNumber });
            }

            var storyFolderName = $"{chapter.Story.Title}({chapter.Story.StoryCode})";
            var chapterFolderName = $"{chapter.ChapterTitle}({chapter.ChapterCode})";
            var chapterFolderPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "stories", storyFolderName, chapterFolderName);
            if (!Directory.Exists(chapterFolderPath))
            {
                Directory.CreateDirectory(chapterFolderPath);
            }

            foreach (var file in ImageFiles)
            {
                if (file.Length > 0)
                {
                    var fileExtension = Path.GetExtension(file.FileName);
                    var uniqueFileName = $"Page_{pageNumber}{fileExtension}";
                    var filePath = Path.Combine(chapterFolderPath, uniqueFileName);

                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await file.CopyToAsync(stream);
                    }

                    var chapterImage = new ChapterImage
                    {
                        ChapterId = chapterId,
                        PageNumber = pageNumber++,
                        ImageUrl = $"images/admins/stories/{storyFolderName}/{chapterFolderName}/{uniqueFileName}"
                    };

                    _context.Add(chapterImage);
                }
            }

            await _context.SaveChangesAsync();
            return RedirectToAction("Index", new { chapterId });
        }

        // GET: Admins/ChapterImages/Edit/5
        [PermissionAuthorize("ChapterImages", "Edit")]

        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chapterImage = await _context.ChapterImages
                .Include(ci => ci.Chapter)
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
        [PermissionAuthorize("ChapterImages", "Edit")]

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

            // Kiểm tra số trang có bị trùng không (trừ ảnh hiện tại)
            if (chapterImage.PageNumber != existingImage.PageNumber) // Chỉ kiểm tra nếu số trang thay đổi
            {
                var existingPage = await _context.ChapterImages
                    .FirstOrDefaultAsync(ci => ci.ChapterId == chapterImage.ChapterId
                        && ci.PageNumber == chapterImage.PageNumber
                        && ci.ImageId != chapterImage.ImageId);

                if (existingPage != null)
                {
                    ModelState.AddModelError("PageNumber", $"Số trang {chapterImage.PageNumber} đã tồn tại trong chương này.");
                }
            }

            // Loại bỏ lỗi xác thực cho ImageUrl nếu không có file được chọn
            if (ImageUrl == null || ImageUrl.Length == 0)
            {
                ModelState.Remove("ImageUrl");
            }

            if (!ModelState.IsValid)
            {
                // Truyền lại danh sách số trang hiện có để hiển thị
                var existingPages = await _context.ChapterImages
                    .Where(ci => ci.ChapterId == chapterImage.ChapterId && ci.ImageId != id)
                    .Select(ci => ci.PageNumber)
                    .ToListAsync();

                ViewData["ExistingPages"] = existingPages;
                ViewData["ChapterId"] = new SelectList(_context.Chapters, "ChapterId", "ChapterTitle", chapterImage.ChapterId);
                return View(chapterImage);
            }

            try
            {
                string newImageUrl = existingImage.ImageUrl; 

                // Nếu có file mới được upload
                if (ImageUrl != null && ImageUrl.Length > 0)
                {
                    var chapterFolder = Path.Combine("images", "admins", "stories", $"chapter_{chapterImage.ChapterId}");
                    var fullFolderPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", chapterFolder);
                    if (!Directory.Exists(fullFolderPath))
                    {
                        Directory.CreateDirectory(fullFolderPath);
                    }

                    var uniqueFileName = $"{Path.GetFileNameWithoutExtension(ImageUrl.FileName)}_{Guid.NewGuid()}{Path.GetExtension(ImageUrl.FileName)}";
                    var filePath = Path.Combine(fullFolderPath, uniqueFileName);

                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await ImageUrl.CopyToAsync(stream);
                    }

                    newImageUrl = Path.Combine(chapterFolder, uniqueFileName).Replace("\\", "/");

                    // Xóa ảnh cũ nếu tồn tại
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
                existingImage.ChapterId = chapterImage.ChapterId;
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
        [PermissionAuthorize("ChapterImages", "Delete")]

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
        [PermissionAuthorize("ChapterImages", "Delete")]

        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var chapterImage = await _context.ChapterImages.FindAsync(id);
            if (chapterImage != null)
            {
                if (!string.IsNullOrEmpty(chapterImage.ImageUrl))
                {
                    var imagePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", chapterImage.ImageUrl);
                    if (System.IO.File.Exists(imagePath))
                    {
                        System.IO.File.Delete(imagePath);
                    }
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
        [PermissionAuthorize("ChapterImages", "Delete")]

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
        // GET: Admins/ChapterImages/CheckPageNumber
        public async Task<IActionResult> CheckPageNumber(int chapterId, int pageNumber, int? imageId = null)
        {
            bool exists;
            if (imageId.HasValue)
            {
                // Trong trường hợp Edit, loại trừ ảnh hiện tại
                exists = await _context.ChapterImages
                    .AnyAsync(ci => ci.ChapterId == chapterId && ci.PageNumber == pageNumber && ci.ImageId != imageId);
            }
            else
            {
                // Trong trường hợp Create
                exists = await _context.ChapterImages
                    .AnyAsync(ci => ci.ChapterId == chapterId && ci.PageNumber == pageNumber);
            }

            return Json(new { exists = exists });
        }
        // GET: Admins/ChapterImages/GetImage/5
        public async Task<IActionResult> GetImage(int imageId)
        {
            var chapterImage = await _context.ChapterImages.FindAsync(imageId);
            if (chapterImage == null || string.IsNullOrEmpty(chapterImage.ImageUrl))
            {
                return NotFound();
            }

            var imagePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", chapterImage.ImageUrl);
            if (!System.IO.File.Exists(imagePath))
            {
                return NotFound();
            }

            var stream = new FileStream(imagePath, FileMode.Open, FileAccess.Read);
            var contentType = "image/jpeg"; 
            return File(stream, contentType);
        }

        private bool ChapterImageExists(int id)
        {
            return _context.ChapterImages.Any(e => e.ImageId == id);
        }
    }
}