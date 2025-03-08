using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class ChangePasswordController : Controller
    {
        private readonly WebMangaContext _context;
       
        public ChangePasswordController(WebMangaContext context)
        {
            _context = context;        
        }

        [HttpGet]
        public IActionResult ChangePassword()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Index", "Login");
            }
            return View(new ChangePassword());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ChangePassword(ChangePassword model)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Index", "Login");
            }

            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var user = await _context.Users.FirstOrDefaultAsync(u => u.UserId == userId);
            if (user == null)
            {
                return NotFound();
            }

            var passwordHasher = new PasswordHasher<User>();
            var verificationResult = passwordHasher.VerifyHashedPassword(user, user.Password, model.CurrentPassword);
            if (verificationResult != PasswordVerificationResult.Success)
            {
                ModelState.AddModelError("CurrentPassword", "Mật khẩu hiện tại không đúng.");
                return View(model);
            }

            user.Password = passwordHasher.HashPassword(user, model.NewPassword);

            try
            {
                _context.Update(user);
                await _context.SaveChangesAsync();

                // Đăng xuất: Xóa session
                HttpContext.Session.Remove("usersLogin");
                HttpContext.Session.Remove("UsersID");

                TempData["SuccessMessage"] = "Đổi mật khẩu thành công! Vui lòng đăng nhập lại.";
                return RedirectToAction("Index", "Login"); // Chuyển về trang đăng nhập
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", $"Có lỗi xảy ra khi đổi mật khẩu: {ex.Message}");
                return View(model);
            }
        }
    }
}
