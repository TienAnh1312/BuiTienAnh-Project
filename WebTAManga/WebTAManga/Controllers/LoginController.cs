using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Identity; // Thêm namespace này cho PasswordHasher
using WebTAManga.Login.Models;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class LoginController : Controller
    {
        private readonly WebMangaContext _context;
        private readonly PasswordHasher<User> _passwordHasher; // Thêm PasswordHasher

        public LoginController(WebMangaContext context)
        {
            _context = context;
            _passwordHasher = new PasswordHasher<User>(); // Khởi tạo PasswordHasher
        }

        public IActionResult Index()
        {
            return View();  
        }

        [HttpPost]
        public IActionResult Index(LoginCustomers model)
        {
            if (!ModelState.IsValid)
            {
                ModelState.AddModelError(string.Empty, "Thông tin đăng nhập không hợp lệ.");
                return View(model);
            }

            // Tìm user theo email
            var user = _context.Users.FirstOrDefault(x => x.Email.ToLower() == model.Email.ToLower());
            if (user != null)
            {
                // Kiểm tra mật khẩu đã mã hóa
                var verificationResult = _passwordHasher.VerifyHashedPassword(user, user.Password, model.Password);
                if (verificationResult == PasswordVerificationResult.Success)
                {
                    HttpContext.Session.SetString("usersLogin", model.Email);
                    HttpContext.Session.SetInt32("UsersID", (int)user.UserId);

                    return RedirectToAction("Index", "Home", new { UsersID = user.UserId });
                }
            }

            ModelState.AddModelError(string.Empty, "Thông tin đăng nhập không chính xác.");
            return View(model);
        }

        [HttpGet]
        public IActionResult Logout()
        {
            HttpContext.Session.Remove("usersLogin");
            return RedirectToAction("Index");
        }
    }
}