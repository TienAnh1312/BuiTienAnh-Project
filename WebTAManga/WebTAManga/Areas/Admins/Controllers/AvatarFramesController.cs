using System;
using System.Collections.Generic;
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

        public AvatarFramesController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/AvatarFrames
        public async Task<IActionResult> Index()
        {
            return View(await _context.AvatarFrames.ToListAsync());
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

                        // Xóa file cũ nếu tồn tại
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
                        avatarFrame.ImagePath = existingFrame.ImagePath; // Giữ nguyên ảnh cũ nếu không upload ảnh mới
                    }

                    _context.Update(avatarFrame);
                    await _context.SaveChangesAsync();
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
                // Xóa file ảnh nếu tồn tại
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
            }
            return RedirectToAction(nameof(Index));
        }

        private bool AvatarFrameExists(int id)
        {
            return _context.AvatarFrames.Any(e => e.AvatarFrameId == id);
        }
    }
}