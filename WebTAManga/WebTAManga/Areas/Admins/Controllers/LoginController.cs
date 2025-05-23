using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Areas.Admins.Models;
using WebTAManga.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;
using System.Threading.Tasks;
using BCrypt.Net;

namespace WebTAManga.Areas.Admins.Controllers
{
    [Area("Admins")]
    public class LoginController : Controller
    {
        private readonly WebMangaContext _context;

        public LoginController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Login
        public IActionResult Index()
        {
            return View();
        }

        // POST: Admins/Login
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Index(LoginAdmins model)
        {
            if (!ModelState.IsValid)
            {
                TempData["ToastrError"] = "Thông tin đăng nhập không hợp lệ.";
                return View(model);
            }

            if (string.IsNullOrEmpty(model.Email))
            {
                TempData["ToastrError"] = "Email không được để trống.";
                return View(model);
            }

            var dataLogin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(x => x.Email.Equals(model.Email));

            if (dataLogin != null && VerifyPassword(model.Password, dataLogin.Password))
            {
                // Tạo claims cho người dùng
                var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, dataLogin.Email),
                    new Claim(ClaimTypes.NameIdentifier, dataLogin.AdminId.ToString()),
                    new Claim(ClaimTypes.Role, dataLogin.RoleNavigation?.RoleName ?? "Unknown")
                };

                var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                var authProperties = new AuthenticationProperties
                {
                    IsPersistent = false,
                    ExpiresUtc = DateTimeOffset.UtcNow.AddMinutes(30)
                };

                // Đăng nhập người dùng
                await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme,
                    new ClaimsPrincipal(claimsIdentity), authProperties);

                // Lưu thông tin vào session
                HttpContext.Session.SetString("AdminLogin", model.Email);
                HttpContext.Session.SetString("AdminRole", dataLogin.RoleNavigation?.RoleName ?? "Unknown");
                HttpContext.Session.SetInt32("AdminId", dataLogin.AdminId);

                // Ghi log đăng nhập
                var adminLog = new AdminLog
                {
                    AdminId = dataLogin.AdminId,
                    Action = "Login",
                    TargetId = dataLogin.AdminId,
                    TargetTable = "Admins",
                    CreatedAt = DateTime.Now
                };
                _context.AdminLogs.Add(adminLog);
                await _context.SaveChangesAsync();

                TempData["ToastrSuccess"] = "Đăng nhập thành công!";
                return RedirectToAction("Index", "Dashboard");
            }

            TempData["ToastrError"] = "Email hoặc mật khẩu không chính xác.";
            return View(model);
        }

        // GET: Admins/Login/Logout
        [HttpGet]
        public async Task<IActionResult> Logout()
        {
            // Đăng xuất người dùng
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

            // Xóa session
            HttpContext.Session.Remove("AdminLogin");
            HttpContext.Session.Remove("AdminRole");
            HttpContext.Session.Remove("AdminId");

            TempData["ToastrSuccess"] = "Đăng xuất thành công!";
            return RedirectToAction("Index");
        }

        // GET: Admins/Login/AccessDenied
        [HttpGet]
        public IActionResult AccessDenied()
        {
            TempData["ToastrError"] = "Bạn không có quyền truy cập vào trang này.";
            string referrer = HttpContext.Request.Headers["Referer"].ToString();
            if (!string.IsNullOrEmpty(referrer))
            {
                return Redirect(referrer);
            }

            return RedirectToAction("Index");
        }

        // Hàm kiểm tra mật khẩu
        private bool VerifyPassword(string inputPassword, string storedPassword)
        {
            return BCrypt.Net.BCrypt.Verify(inputPassword, storedPassword);
        }
    }
}