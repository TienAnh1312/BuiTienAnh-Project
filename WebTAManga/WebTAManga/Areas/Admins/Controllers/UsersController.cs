using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    [Authorize(Roles = "SuperAdmin,UserManager")]
    public class UsersController : BaseController
    {
        private readonly WebMangaContext _context;
        private const int PageSize = 7;

        public UsersController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Users
        public async Task<IActionResult> Index(string searchUsername, string searchEmail, int page = 1)
        {
            var users = from u in _context.Users select u;

            if (!string.IsNullOrEmpty(searchUsername))
            {
                users = users.Where(u => u.Username.Contains(searchUsername));
            }

            if (!string.IsNullOrEmpty(searchEmail))
            {
                users = users.Where(u => u.Email.Contains(searchEmail));
            }

            int totalItems = await users.CountAsync();
            int totalPages = (int)Math.Ceiling(totalItems / (double)PageSize);

            var pagedUsers = await users
                .Include(u => u.AvatarFrame) // Bao gồm thông tin khung avatar
                .OrderBy(u => u.UserId)
                .Skip((page - 1) * PageSize)
                .Take(PageSize)
                .ToListAsync();

            var viewModel = new UserIndexView
            {
                Users = pagedUsers,
                CurrentPage = page,
                TotalPages = totalPages,
                SearchUsername = searchUsername,
                SearchEmail = searchEmail
            };

            return View(viewModel);
        }

        // GET: Admins/Users/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.Users
                .Include(u => u.AvatarFrame)
                .FirstOrDefaultAsync(m => m.UserId == id);
            if (user == null)
            {
                return NotFound();
            }

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Details", user);
            }
            return View(user);
        }

        // GET: Admins/Users/Create
        public IActionResult Create()
        {
            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Create");
            }
            return View();
        }

        // POST: Admins/Users/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Username,Email,Password,CreatedAt,AvatarFrameId,Coins,ExpPoints,Avatar")] User user)
        {
            if (ModelState.IsValid)
            {
                // Xử lý file ảnh avatar nếu có
                var files = HttpContext.Request.Form.Files;
                if (files.Any() && files[0].Length > 0)
                {
                    var file = files[0];
                    var fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                    var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "avatars", fileName);

                    using (var stream = new FileStream(path, FileMode.Create))
                    {
                        await file.CopyToAsync(stream);
                        user.Avatar = "images/avatars/" + fileName;
                    }
                }

                user.CreatedAt = DateTime.UtcNow; // Gán thời gian tạo
                _context.Add(user);
                await _context.SaveChangesAsync();

                if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                {
                    return Json(new { success = true });
                }
                TempData["Success"] = "Người dùng đã được tạo thành công.";
                return RedirectToAction(nameof(Index));
            }

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Create", user);
            }
            return View(user);
        }

        // GET: Admins/Users/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            // Cung cấp danh sách khung avatar
            ViewBag.AvatarFrames = await _context.AvatarFrames.ToListAsync();

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Edit", user);
            }
            return View(user);
        }

        // POST: Admins/Users/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("UserId,Username,Email,Password,CreatedAt,AvatarFrameId,Coins,ExpPoints,Avatar")] User user)
        {
            if (id != user.UserId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    var existingUser = await _context.Users.AsNoTracking().FirstOrDefaultAsync(u => u.UserId == id);
                    if (existingUser == null)
                    {
                        return NotFound();
                    }

                    // Xử lý file ảnh avatar nếu có
                    var files = HttpContext.Request.Form.Files;
                    if (files.Any() && files[0].Length > 0)
                    {
                        var file = files[0];
                        var fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                        var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "avatars", fileName);

                        if (!string.IsNullOrEmpty(existingUser.Avatar))
                        {
                            var oldPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", existingUser.Avatar);
                            if (System.IO.File.Exists(oldPath))
                            {
                                System.IO.File.Delete(oldPath);
                            }
                        }

                        using (var stream = new FileStream(path, FileMode.Create))
                        {
                            await file.CopyToAsync(stream);
                            user.Avatar = "images/avatars/" + fileName;
                        }
                    }
                    else
                    {
                        user.Avatar = existingUser.Avatar;
                    }

                    // Xử lý AvatarFrameId
                    if (user.AvatarFrameId == -1) // Nếu chọn "Không có khung"
                    {
                        user.AvatarFrameId = null; // Đặt thành null để biểu thị không có khung
                    }
                    else if (!user.AvatarFrameId.HasValue || user.AvatarFrameId == 0)
                    {
                        user.AvatarFrameId = existingUser.AvatarFrameId; // Giữ khung cũ
                    }
                    // Nếu AvatarFrameId là giá trị hợp lệ (> 0), sử dụng giá trị mới từ form

                    _context.Update(user);
                    await _context.SaveChangesAsync();

                    if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                    {
                        return Json(new { success = true });
                    }
                    TempData["Success"] = "Người dùng đã được cập nhật thành công.";
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!UserExists(user.UserId))
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

            // Cung cấp lại danh sách khung avatar nếu ModelState không hợp lệ
            ViewBag.AvatarFrames = await _context.AvatarFrames.ToListAsync();

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Edit", user);
            }
            return View(user);
        }

        // GET: Admins/Users/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.Users
                .Include(u => u.AvatarFrame)
                .FirstOrDefaultAsync(m => m.UserId == id);
            if (user == null)
            {
                return NotFound();
            }

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Delete", user);
            }
            return View(user);
        }

        // POST: Admins/Users/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user != null)
            {
                if (!string.IsNullOrEmpty(user.Avatar))
                {
                    var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", user.Avatar);
                    if (System.IO.File.Exists(filePath))
                    {
                        System.IO.File.Delete(filePath);
                    }
                }

                _context.Users.Remove(user);
                await _context.SaveChangesAsync();

                if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                {
                    return Json(new { success = true });
                }
                TempData["Success"] = "Người dùng đã được xóa thành công.";
            }
            return RedirectToAction(nameof(Index));
        }

        private bool UserExists(int id)
        {
            return _context.Users.Any(e => e.UserId == id);
        }
    }

    public class UserIndexView
    {
        public List<User> Users { get; set; }
        public int CurrentPage { get; set; }
        public int TotalPages { get; set; }
        public string SearchUsername { get; set; }
        public string SearchEmail { get; set; }
    }
}