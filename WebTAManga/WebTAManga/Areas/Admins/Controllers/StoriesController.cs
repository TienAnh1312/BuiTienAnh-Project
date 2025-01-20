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
    
    public class StoriesController : BaseController
    {
        private readonly WebMangaContext _context;

        public StoriesController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Stories
        public async Task<IActionResult> Index()
        {
            return View(await _context.Stories.ToListAsync());
        }

        // GET: Admins/Stories/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var story = await _context.Stories
                .FirstOrDefaultAsync(m => m.StoryId == id);
            if (story == null)
            {
                return NotFound();
            }

            return View(story);
        }

        // GET: Admins/Stories/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admins/Stories/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("StoryId,Title,Author,Description,CoverImage,CreatedAt")] Story story)
        {
            if (ModelState.IsValid)
            {
                // Kiểm tra trùng lặp Code khi sửa
                var existingProductByCode = await _context.Stories
                    .FirstOrDefaultAsync(p => p.Title == story.Title && p.StoryId != story.StoryId);

                if (existingProductByCode != null)
                {
                    ModelState.AddModelError("Code", "Sản phẩm này đã tồn tại.");
                }

                if (!ModelState.IsValid)
                {
                    return View(story);
                }

                // Xử lý ảnh, nếu có ảnh mới
                var files = HttpContext.Request.Form.Files;
                if (files.Count() > 0 && files[0].Length > 0)
                {
                    var file = files[0];
                    var fileName = file.FileName;
                    var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "stories", fileName);

                    // Kiểm tra xem ảnh có tồn tại trong thư mục chưa (nghĩa là bạn không muốn đè ảnh cũ)
                    if (System.IO.File.Exists(path))
                    {
                        ModelState.AddModelError("Image", "Ảnh đã tồn tại trên hệ thống.");
                        return View(story);
                    }

                    using (var stream = new FileStream(path, FileMode.Create))
                    {
                        file.CopyTo(stream);
                        story.CoverImage = "images/admins/stories/" + fileName; // Lưu đường dẫn ảnh
                    }
                }

                // Thiết lập ngày tạo và ngày cập nhật tự động
                story.CreatedAt = DateTime.Now;
               

                // Thêm sản phẩm vào cơ sở dữ liệu
                _context.Add(story);
                await _context.SaveChangesAsync();

                return RedirectToAction(nameof(Index));
            }

            return View(story);
        }

        // GET: Admins/Stories/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var story = await _context.Stories.FindAsync(id);
            if (story == null)
            {
                return NotFound();
            }
            return View(story);
        }

        // POST: Admins/Stories/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("StoryId,Title,Author,Description,CoverImage,CreatedAt")] Story story)
        {
            if (id != story.StoryId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    // Check for duplicate product by Code and Image
                    var existingProductByCode = await _context.Stories
                        .FirstOrDefaultAsync(p => p.Title == story.Title && p.StoryId != story.StoryId);

                    var existingProductByImage = await _context.Stories
                        .FirstOrDefaultAsync(p => p.CoverImage == story.CoverImage && p.StoryId != story.StoryId);

                    if (existingProductByCode != null && existingProductByImage != null)
                    {
                        ModelState.AddModelError(string.Empty, "Sản phẩm với Mã sản phẩm và Ảnh này đã tồn tại.");
                    }
                    else if (existingProductByCode != null)
                    {
                        ModelState.AddModelError("Title", "Mã Sản phẩm này đã tồn tại.");
                    }
                    else if (existingProductByImage != null)
                    {
                        ModelState.AddModelError("CoverImage", "Sản phẩm với Ảnh này đã tồn tại.");
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
                            story.CoverImage = "images/admins/stories/" + fileName; // Save the image path
                        }
                    }

                    // Set the updated date automatically
                    story.CreatedAt = DateTime.Now;

                    _context.Update(story);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!StoryExists(story.StoryId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }

                return RedirectToAction(nameof(Index));
            }
            return View(story);
        }

        // GET: Admins/Stories/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var story = await _context.Stories
                .FirstOrDefaultAsync(m => m.StoryId == id);
            if (story == null)
            {
                return NotFound();
            }

            return View(story);
        }

        // POST: Admins/Stories/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var story = await _context.Stories.FindAsync(id);
            if (story != null)
            {
                _context.Stories.Remove(story);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool StoryExists(int id)
        {
            return _context.Stories.Any(e => e.StoryId == id);
        }
    }
}
