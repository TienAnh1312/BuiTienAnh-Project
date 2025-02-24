using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class UsersController : Controller
    {
        private readonly WebMangaContext _context;
        private readonly IWebHostEnvironment _environment;
        private readonly IWebHostEnvironment _hostingEnvironment;


        public UsersController(WebMangaContext context, IWebHostEnvironment environment, IWebHostEnvironment hostingEnvironment)
        {
            _context = context;
            _environment = environment;
            _hostingEnvironment = hostingEnvironment;
        }

        // GET: Users/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Users/Create
        // Đăng ký
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("UserId,Username,Email,Password,CreatedAt")] User user)
        {
            if (!ModelState.IsValid)
            {
                return View(user);
            }

            // Kiểm tra nếu email đã tồn tại trong cơ sở dữ liệu (so sánh không phân biệt hoa/thường)
            var existingEmail = _context.Users
                                        .FirstOrDefault(x => x.Email.ToLower() == user.Email.ToLower());

            if (existingEmail != null)
            {
                ModelState.AddModelError(string.Empty, "Email này đã được đăng ký.");
                return View(user);
            }

            // Kiểm tra nếu tên đăng nhập đã tồn tại trong cơ sở dữ liệu
            var existingUsername = _context.Users
                                           .FirstOrDefault(x => x.Username.ToLower() == user.Username.ToLower());

            if (existingUsername != null)
            {
                ModelState.AddModelError(string.Empty, "Tên đăng nhập này đã có người sử dụng.");
                return View(user);
            }

            // Mã hóa mật khẩu
            var passwordHasher = new PasswordHasher<User>();
            user.Password = passwordHasher.HashPassword(user, user.Password);

            // Lưu thông tin khách hàng mới vào cơ sở dữ liệu
            user.CreatedAt = DateTime.Now;

            _context.Users.Add(user);
            _context.SaveChanges();

            // Sau khi đăng ký thành công, chuyển hướng đến trang đăng nhập
            return RedirectToAction("Index", "Login");
        }

        // GET: Users/Profile
        public IActionResult Profile()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");

            if (userId == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var user = _context.Users
                .Include(u => u.Rank)
                .Include(u => u.AvatarFrame)
                .FirstOrDefault(u => u.UserId == userId);

            if (user == null)
            {
                return NotFound();
            }

            ViewBag.AvatarFrames = _context.AvatarFrames.ToList();
            return View(user);
        }


        // POST: Users/Profile
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Profile([Bind("UserId,Username,Email,Level,Avatar,AvatarFrame,Password,RankId")] User user, IFormFile avatarFile, string newPassword)
        {
            var currentUserId = HttpContext.Session.GetInt32("UsersID");

            if (currentUserId == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var existingUser = await _context.Users.FirstOrDefaultAsync(u => u.UserId == currentUserId);
            if (existingUser == null)
            {
                return NotFound();
            }

            // Cập nhật thông tin cá nhân
            existingUser.Username = user.Username;
            existingUser.Email = user.Email;
            existingUser.Level = user.Level;
            existingUser.AvatarFrame = user.AvatarFrame;
            existingUser.RankId = user.RankId;

            // Cập nhật ảnh đại diện nếu có
            if (avatarFile != null && avatarFile.Length > 0)
            {
                var uploadsFolder = Path.Combine(_environment.WebRootPath, "uploads/avatars");
                if (!Directory.Exists(uploadsFolder))
                {
                    Directory.CreateDirectory(uploadsFolder);
                }

                var fileName = Path.GetFileName(avatarFile.FileName);
                var filePath = Path.Combine(uploadsFolder, fileName);

                // Xóa ảnh cũ nếu có
                if (!string.IsNullOrEmpty(existingUser.Avatar))
                {
                    var oldAvatarPath = Path.Combine(uploadsFolder, existingUser.Avatar);
                    if (System.IO.File.Exists(oldAvatarPath))
                    {
                        System.IO.File.Delete(oldAvatarPath);
                    }
                }

                // Lưu ảnh mới
                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    await avatarFile.CopyToAsync(fileStream);
                }

                existingUser.Avatar = fileName; // Lưu tên ảnh vào database
            }

            // Cập nhật mật khẩu nếu có
            if (!string.IsNullOrEmpty(newPassword))
            {
                var passwordHasher = new PasswordHasher<User>();
                existingUser.Password = passwordHasher.HashPassword(existingUser, newPassword);
            }

            _context.Update(existingUser);
            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = "Your profile has been updated successfully!";
            return RedirectToAction("Profile");
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult UpdateProfile(User model, IFormFile avatarFile, int avatarFrameId, string newPassword)
        {
            if (ModelState.IsValid)
            {
                var user = _context.Users.FirstOrDefault(u => u.UserId == model.UserId);

                if (user != null)
                {
                    // Xử lý avatar
                    if (avatarFile != null && avatarFile.Length > 0)
                    {
                        var filePath = Path.Combine(_hostingEnvironment.WebRootPath, "uploads", "avatars", avatarFile.FileName);
                        using (var stream = new FileStream(filePath, FileMode.Create))
                        {
                            avatarFile.CopyTo(stream);
                        }
                        user.Avatar = avatarFile.FileName;
                    }

                    // Cập nhật khung viền avatar
                    user.AvatarFrameId = avatarFrameId;

                    // Cập nhật mật khẩu nếu có
                    if (!string.IsNullOrEmpty(newPassword))
                    {
                        user.Password = newPassword;  // Cần mã hóa mật khẩu trước khi lưu.
                    }

                    _context.SaveChanges();

                    TempData["SuccessMessage"] = "Profile updated successfully.";
                    return RedirectToAction("Profile");
                }
            }

            return View(model);
        }



        private bool UserExists(int id)
        {
            return _context.Users.Any(e => e.UserId == id);
        }
    }
}
