using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    [Authorize(Roles = "SuperAdmin, ContentManager")]
    public class AvatarFramesController : BaseController
    {
        private readonly WebMangaContext _context;
        private const int PageSize = 7;

        public AvatarFramesController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/AvatarFrames
        public async Task<IActionResult> Index(string searchName, string searchPriceRange, int page = 1)
        {
            var avatarFrames = from af in _context.AvatarFrames select af;

            // Apply search filters
            if (!string.IsNullOrEmpty(searchName))
            {
                avatarFrames = avatarFrames.Where(af => af.Name.Contains(searchName));
            }
            if (!string.IsNullOrEmpty(searchPriceRange))
            {
                switch (searchPriceRange)
                {
                    case "0-100":
                        avatarFrames = avatarFrames.Where(af => af.Price >= 0 && af.Price <= 100);
                        break;
                    case "101-500":
                        avatarFrames = avatarFrames.Where(af => af.Price >= 101 && af.Price <= 500);
                        break;
                    case "501+":
                        avatarFrames = avatarFrames.Where(af => af.Price >= 501);
                        break;
                }
            }

            // Pagination
            int totalItems = await avatarFrames.CountAsync();
            int totalPages = (int)Math.Ceiling(totalItems / (double)PageSize);
            var pagedAvatarFrames = await avatarFrames
                .OrderBy(af => af.Name)
                .Skip((page - 1) * PageSize)
                .Take(PageSize)
                .ToListAsync();

            var viewModel = new AvatarFrameIndexView
            {
                AvatarFrames = pagedAvatarFrames,
                CurrentPage = page,
                TotalPages = totalPages,
                SearchName = searchName,
                SearchPriceRange = searchPriceRange
            };

            return View(viewModel);
        }

        // GET: Admins/AvatarFrames/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var avatarFrame = await _context.AvatarFrames
                .FirstOrDefaultAsync(m => m.AvatarFrameId == id);
            if (avatarFrame == null)
            {
                return NotFound();
            }

            return View(avatarFrame);
        }

        // GET: Admins/AvatarFrames/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admins/AvatarFrames/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Name,Price")] AvatarFrame avatarFrame)
        {
            if (ModelState.IsValid)
            {
                var files = HttpContext.Request.Form.Files;
                if (files.Count > 0 && files[0].Length > 0)
                {
                    var file = files[0];
                    var fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                    var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "avatarFrames", fileName);

                    using (var stream = new FileStream(path, FileMode.Create))
                    {
                        await file.CopyToAsync(stream);
                        avatarFrame.ImagePath = "images/admins/avatarFrames/" + fileName;
                    }
                }

                _context.Add(avatarFrame);
                await _context.SaveChangesAsync();
                TempData["Success"] = "Khung avatar đã được tạo thành công.";
                return RedirectToAction(nameof(Index));
            }
            return View(avatarFrame);
        }

        // GET: Admins/AvatarFrames/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var avatarFrame = await _context.AvatarFrames.FindAsync(id);
            if (avatarFrame == null)
            {
                return NotFound();
            }
            return View(avatarFrame);
        }

        // POST: Admins/AvatarFrames/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("AvatarFrameId,Name,ImagePath,Price")] AvatarFrame avatarFrame)
        {
            if (id != avatarFrame.AvatarFrameId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    var existingFrame = await _context.AvatarFrames.AsNoTracking().FirstOrDefaultAsync(f => f.AvatarFrameId == id);
                    if (existingFrame == null)
                    {
                        return NotFound();
                    }

                    var files = HttpContext.Request.Form.Files;
                    if (files.Count > 0 && files[0].Length > 0)
                    {
                        var file = files[0];
                        var fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                        var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "avatarFrames", fileName);

                        // Delete old file if it exists
                        if (!string.IsNullOrEmpty(existingFrame.ImagePath))
                        {
                            var oldPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", existingFrame.ImagePath);
                            if (System.IO.File.Exists(oldPath))
                            {
                                System.IO.File.Delete(oldPath);
                            }
                        }

                        using (var stream = new FileStream(path, FileMode.Create))
                        {
                            await file.CopyToAsync(stream);
                            avatarFrame.ImagePath = "images/admins/avatarFrames/" + fileName;
                        }
                    }
                    else
                    {
                        avatarFrame.ImagePath = existingFrame.ImagePath; // Keep old image if no new upload
                    }

                    _context.Update(avatarFrame);
                    await _context.SaveChangesAsync();
                    TempData["Success"] = "Khung avatar đã được cập nhật thành công.";
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!AvatarFrameExists(avatarFrame.AvatarFrameId))
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
            return View(avatarFrame);
        }

        // GET: Admins/AvatarFrames/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var avatarFrame = await _context.AvatarFrames
                .FirstOrDefaultAsync(m => m.AvatarFrameId == id);
            if (avatarFrame == null)
            {
                return NotFound();
            }

            return View(avatarFrame);
        }

        // POST: Admins/AvatarFrames/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var avatarFrame = await _context.AvatarFrames.FindAsync(id);
            if (avatarFrame != null)
            {
                // Delete image file if it exists
                if (!string.IsNullOrEmpty(avatarFrame.ImagePath))
                {
                    var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", avatarFrame.ImagePath);
                    if (System.IO.File.Exists(filePath))
                    {
                        System.IO.File.Delete(filePath);
                    }
                }

                _context.AvatarFrames.Remove(avatarFrame);
                await _context.SaveChangesAsync();
                TempData["Success"] = "Khung avatar đã được xóa thành công.";
            }
            return RedirectToAction(nameof(Index));
        }

        private bool AvatarFrameExists(int id)
        {
            return _context.AvatarFrames.Any(e => e.AvatarFrameId == id);
        }
    }

    public class AvatarFrameIndexView
    {
        public List<AvatarFrame> AvatarFrames { get; set; }
        public int CurrentPage { get; set; }
        public int TotalPages { get; set; }
        public string SearchName { get; set; }
        public string SearchPriceRange { get; set; }
    }
}