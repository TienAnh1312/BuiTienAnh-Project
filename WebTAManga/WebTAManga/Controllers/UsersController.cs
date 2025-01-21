using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class UsersController : Controller
    {
        private readonly WebMangaContext _context;

        public UsersController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Users/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Users/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
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


        private bool UserExists(int id)
        {
            return _context.Users.Any(e => e.UserId == id);
        }
    }
}
