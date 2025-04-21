using System;
using System.Collections.Generic;
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

    public class BannersController : BaseController
    {
        private readonly WebMangaContext _context;

        public BannersController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Banners
        [PermissionAuthorize("Banners", "View")]
        public async Task<IActionResult> Index()
        {
            return View(await _context.Banners.ToListAsync());
        }

        // GET: Admins/Banners/Details/5
        [PermissionAuthorize("Banners", "View")]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var banner = await _context.Banners
                .FirstOrDefaultAsync(m => m.Id == id);
            if (banner == null)
            {
                return NotFound();
            }

            return View(banner);
        }

        // GET: Admins/Banners/Create
        [PermissionAuthorize("Banners", "Create")]
        public IActionResult Create()
        {
            // Kiểm tra xem số lượng banner đã đạt 4 chưa
            if (_context.Banners.Count() >= 4)
            {
                TempData["ErrorMessage"] = "Không thể tạo quá 4 banner.";
                return RedirectToAction(nameof(Index));
            }
            return View();
        }

        // POST: Admins/Banners/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        [PermissionAuthorize("Banners", "Create")]
        public async Task<IActionResult> Create([Bind("Id,ImageUrl,Title,Description,LinkUrl,IsActive,DisplayOrder")] Banner banner)
        {
            // Kiểm tra xem số lượng banner đã đạt 4 chưa
            if (_context.Banners.Count() >= 4)
            {
                ModelState.AddModelError("", "Không thể tạo quá 4 banner.");
                return View(banner);
            }

            if (ModelState.IsValid)
            {
                // Xử lý ảnh nếu có ảnh mới
                var files = HttpContext.Request.Form.Files;
                if (files.Count() > 0 && files[0].Length > 0)
                {
                    var file = files[0];
                    var fileName = file.FileName;
                    var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "banner", fileName);

                    using (var stream = new FileStream(path, FileMode.Create))
                    {
                        await file.CopyToAsync(stream);
                        banner.LinkUrl = "images/admins/banner/" + fileName; 
                    }
                }
                _context.Add(banner);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(banner);
        }

        // GET: Admins/Banners/Edit/5
        [PermissionAuthorize("Banners", "Edit")]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var banner = await _context.Banners.FindAsync(id);
            if (banner == null)
            {
                return NotFound();
            }
            return View(banner);
        }

        // POST: Admins/Banners/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [PermissionAuthorize("Banners", "Edit")]
        public async Task<IActionResult> Edit(int id, [Bind("Id,ImageUrl,Title,Description,LinkUrl,IsActive,DisplayOrder")] Banner banner)
        {
            if (id != banner.Id)
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
                        var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "banner", fileName);

                        using (var stream = new FileStream(path, FileMode.Create))
                        {
                            file.CopyTo(stream);
                            banner.LinkUrl = "images/admins/banner/" + fileName; 
                        }
                    }
  
                    _context.Update(banner);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!BannerExists(banner.Id))
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
            return View(banner);
        }

        // GET: Admins/Banners/Delete/5
        [PermissionAuthorize("Banners", "Delete")]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var banner = await _context.Banners
                .FirstOrDefaultAsync(m => m.Id == id);
            if (banner == null)
            {
                return NotFound();
            }

            return View(banner);
        }

        // POST: Admins/Banners/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        [PermissionAuthorize("Banners", "Delete")]  
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var banner = await _context.Banners.FindAsync(id);
            if (banner != null)
            {
                _context.Banners.Remove(banner);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool BannerExists(int id)
        {
            return _context.Banners.Any(e => e.Id == id);
        }
    }
}
