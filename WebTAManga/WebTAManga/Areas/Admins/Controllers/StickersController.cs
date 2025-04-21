using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    [Authorize(Roles = "SuperAdmin, ContentManager")]

    public class StickersController : BaseController
    {
        private readonly WebMangaContext _context;

        public StickersController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Stickers
        public async Task<IActionResult> Index()
        {
            return View(await _context.Stickers.ToListAsync());
        }

        // GET: Admins/Stickers/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sticker = await _context.Stickers
                .FirstOrDefaultAsync(m => m.StickerId == id);
            if (sticker == null)
            {
                return NotFound();
            }

            return View(sticker);
        }

        // GET: Admins/Stickers/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admins/Stickers/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("StickerId,Name,ImagePath")] Sticker sticker)
        {
            if (ModelState.IsValid)
            {
                // Xử lý ảnh, nếu có ảnh mới
                var files = HttpContext.Request.Form.Files;
                if (files.Count() > 0 && files[0].Length > 0)
                {
                    var file = files[0];
                    var fileName = file.FileName;
                    var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "stickers", fileName);

                    using (var stream = new FileStream(path, FileMode.Create))
                    {
                        file.CopyTo(stream);
                        sticker.ImagePath = "images/stickers/" + fileName; // Lưu đường dẫn ảnh
                    }
                }

                _context.Add(sticker);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(sticker);
        }

        // GET: Admins/Stickers/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sticker = await _context.Stickers.FindAsync(id);
            if (sticker == null)
            {
                return NotFound();
            }
            return View(sticker);
        }

        // POST: Admins/Stickers/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("StickerId,Name,ImagePath")] Sticker sticker)
        {
            if (id != sticker.StickerId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    // Xử lý ảnh, nếu có ảnh mới
                    var files = HttpContext.Request.Form.Files;
                    if (files.Count() > 0 && files[0].Length > 0)
                    {
                        var file = files[0];
                        var fileName = file.FileName;
                        var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "stickers", fileName);

                        using (var stream = new FileStream(path, FileMode.Create))
                        {
                            file.CopyTo(stream);
                            sticker.ImagePath = "images/stickers/" + fileName; // Lưu đường dẫn ảnh
                        }
                    }

                    _context.Update(sticker);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!StickerExists(sticker.StickerId))
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
            return View(sticker);
        }

        // GET: Admins/Stickers/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sticker = await _context.Stickers
                .FirstOrDefaultAsync(m => m.StickerId == id);
            if (sticker == null)
            {
                return NotFound();
            }

            return View(sticker);
        }

        // POST: Admins/Stickers/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var sticker = await _context.Stickers.FindAsync(id);
            if (sticker != null)
            {
                _context.Stickers.Remove(sticker);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool StickerExists(int id)
        {
            return _context.Stickers.Any(e => e.StickerId == id);
        }
    }
}
