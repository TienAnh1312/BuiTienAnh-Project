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
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("AvatarFrameId,Name,ImagePath")] AvatarFrame avatarFrame)
        {
            // Kiểm tra xem Model có hợp lệ không
            if (ModelState.IsValid)
            {
                // Kiểm tra nếu có file được upload
                var files = HttpContext.Request.Form.Files;
                if (files.Count > 0 && files[0].Length > 0)
                {
                    var file = files[0];
                    var fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName); // Tạo tên file duy nhất
                    var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images","admins", "avatarFrames", fileName);

                    // Lưu file vào thư mục server
                    using (var stream = new FileStream(path, FileMode.Create))
                    {
                        await file.CopyToAsync(stream);
                        avatarFrame.ImagePath = "images/admins/avatarFrames/" + fileName; // Lưu đường dẫn file vào trong đối tượng AvatarFrame
                    }
                }

                // Thêm AvatarFrame vào cơ sở dữ liệu
                _context.Add(avatarFrame);
                await _context.SaveChangesAsync();

                // Chuyển hướng đến trang Index sau khi thêm thành công
                return RedirectToAction(nameof(Index));
            }

            // Trả lại view nếu model không hợp lệ
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
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("AvatarFrameId,Name,ImagePath")] AvatarFrame avatarFrame)
        {
            if (id != avatarFrame.AvatarFrameId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
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
                _context.AvatarFrames.Remove(avatarFrame);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool AvatarFrameExists(int id)
        {
            return _context.AvatarFrames.Any(e => e.AvatarFrameId == id);
        }
    }
}
