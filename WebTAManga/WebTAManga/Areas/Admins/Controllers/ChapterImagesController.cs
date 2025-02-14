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

            var chapterImage = new ChapterImage
            {
                ChapterId = chapterId // Gán chapterId vào model
            };

            ViewData["ChapterTitle"] = chapter.ChapterTitle; // Truyền tên chapter để hiển thị
            return View(chapterImage);
        }


        // POST: Admins/ChapterImages/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(ChapterImage chapterImage)
        {
            if (!ModelState.IsValid)
            {
                return View(chapterImage);
            }

            // Process the image if a new file is uploaded
            var files = HttpContext.Request.Form.Files;
            if (files.Count() > 0 && files[0].Length > 0)
            {
                var file = files[0];
                var fileName = file.FileName;
                var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "stories", fileName);

                using (var stream = new FileStream(path, FileMode.Create))
                {
                    file.CopyTo(stream);
                    chapterImage.ImageUrl = "images/admins/stories/" + fileName; // Save the image path
                }
            }

            _context.Add(chapterImage);
            await _context.SaveChangesAsync();

            return RedirectToAction("Index", new { chapterId = chapterImage.ChapterId });
        }

        // GET: Admins/ChapterImages/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chapterImage = await _context.ChapterImages.FindAsync(id);
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
        public async Task<IActionResult> Edit(int id, ChapterImage chapterImage)
        {
            if (id != chapterImage.ImageId)
            {
                return NotFound();
            }

            if (!ModelState.IsValid)
            {
                return View(chapterImage);
            }

            try
            {
                var existingImage = await _context.ChapterImages.FindAsync(id);
                if (existingImage == null)
                {
                    return NotFound();
                }

                var files = HttpContext.Request.Form.Files;
                if (files.Count > 0 && files[0].Length > 0)
                {
                    // Lưu ảnh mới
                    var file = files[0];
                    var fileName = file.FileName;
                    var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "stories", fileName);

                    using (var stream = new FileStream(path, FileMode.Create))
                    {
                        await file.CopyToAsync(stream);
                    }

                    // Cập nhật đường dẫn ảnh mới
                    existingImage.ImageUrl = "images/admins/stories/" + fileName;
                }

                existingImage.PageNumber = chapterImage.PageNumber; // Cập nhật số trang
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
                _context.ChapterImages.Remove(chapterImage);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ChapterImageExists(int id)
        {
            return _context.ChapterImages.Any(e => e.ImageId == id);
        }
    }
}
