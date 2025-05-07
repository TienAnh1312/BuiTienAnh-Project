using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
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

        [PermissionAuthorize("Banners", "View")]
        public async Task<IActionResult> Index()
        {
            return View(await _context.Banners.ToListAsync());
        }

        [PermissionAuthorize("Banners", "View")]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var banner = await _context.Banners.FirstOrDefaultAsync(m => m.Id == id);
            if (banner == null)
            {
                return NotFound();
            }

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Details", banner);
            }
            return View(banner);
        }

        [PermissionAuthorize("Banners", "Create")]
        public IActionResult Create()
        {
            if (_context.Banners.Count() >= 4)
            {
                if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                {
                    return Json(new { success = false, message = "Không thể tạo quá 4 banner." });
                }
                TempData["ErrorMessage"] = "Không thể tạo quá 4 banner.";
                return RedirectToAction(nameof(Index));
            }
            return PartialView("_Create");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [PermissionAuthorize("Banners", "Create")]
        public async Task<IActionResult> Create([Bind("Id,ImageUrl,Title,Description,LinkUrl,IsActive,DisplayOrder")] Banner banner)
        {
            if (_context.Banners.Count() >= 4)
            {
                if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                {
                    return Json(new { success = false, message = "Không thể tạo quá 4 banner." });
                }
                ModelState.AddModelError("", "Không thể tạo quá 4 banner.");
                return PartialView("_Create", banner);
            }

            if (ModelState.IsValid)
            {
                var files = HttpContext.Request.Form.Files;
                if (files.Any() && files[0].Length > 0)
                {
                    var file = files[0];
                    var fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                    var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "banner", fileName);

                    Directory.CreateDirectory(Path.GetDirectoryName(path));
                    using (var stream = new FileStream(path, FileMode.Create))
                    {
                        await file.CopyToAsync(stream);
                    }
                    banner.LinkUrl = "images/admins/banner/" + fileName;
                }
                else
                {
                    ModelState.AddModelError("LinkUrl", "Vui lòng chọn một hình ảnh.");
                    return PartialView("_Create", banner);
                }

                _context.Add(banner);
                await _context.SaveChangesAsync();
                if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                {
                    return Json(new { success = true });
                }
                return RedirectToAction(nameof(Index));
            }
            return PartialView("_Create", banner);
        }

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
            return PartialView("_Edit", banner);
        }

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
                    var existingBanner = await _context.Banners.AsNoTracking().FirstOrDefaultAsync(b => b.Id == id);
                    if (existingBanner == null)
                    {
                        return NotFound();
                    }

                    var files = HttpContext.Request.Form.Files;
                    if (files.Any() && files[0].Length > 0)
                    {
                        var file = files[0];
                        var fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                        var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "banner", fileName);

                        Directory.CreateDirectory(Path.GetDirectoryName(path));
                        using (var stream = new FileStream(path, FileMode.Create))
                        {
                            await file.CopyToAsync(stream);
                        }
                        banner.LinkUrl = "images/admins/banner/" + fileName;
                    }
                    else
                    {
                        banner.LinkUrl = existingBanner.LinkUrl;
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
                    throw;
                }
                if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                {
                    return Json(new { success = true });
                }
                return RedirectToAction(nameof(Index));
            }
            return PartialView("_Edit", banner);
        }

        [PermissionAuthorize("Banners", "Delete")]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var banner = await _context.Banners.FirstOrDefaultAsync(m => m.Id == id);
            if (banner == null)
            {
                return NotFound();
            }

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Delete", banner);
            }
            return View(banner);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        [PermissionAuthorize("Banners", "Delete")]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var banner = await _context.Banners.FindAsync(id);
            if (banner != null)
            {
                _context.Banners.Remove(banner);
                await _context.SaveChangesAsync();
            }
            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return Json(new { success = true });
            }
            return RedirectToAction(nameof(Index));
        }

        private bool BannerExists(int id)
        {
            return _context.Banners.Any(e => e.Id == id);
        }
    }
}