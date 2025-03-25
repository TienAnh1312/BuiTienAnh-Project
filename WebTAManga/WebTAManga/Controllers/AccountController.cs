using MailKit.Security;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MimeKit;
using WebTAManga.Models;
using MailKit.Net.Smtp;
using Microsoft.VisualStudio.Web.CodeGenerators.Mvc.Templates.BlazorIdentity.Pages;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;

namespace WebTAManga.Controllers
{
    public class AccountController : Controller
    {
        private readonly WebMangaContext _context;
        private readonly PasswordHasher<User> _passwordHasher;
        private readonly IEmailSender _emailSender;
        private readonly IWebHostEnvironment _hostingEnvironment;

        public AccountController(WebMangaContext context, IWebHostEnvironment hostingEnvironment, IEmailSender emailSender)
        {
            _context = context;
            _passwordHasher = new PasswordHasher<User>();
            _hostingEnvironment = hostingEnvironment;
            _emailSender = emailSender;
        }

        public IActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Login(LoginCustomers model)
        {
            if (!ModelState.IsValid)
            {
                ModelState.AddModelError(string.Empty, "Thông tin đăng nhập không hợp lệ.");
                return View(model);
            }

            var user = _context.Users.FirstOrDefault(x => x.Email.ToLower() == model.Email.ToLower());
            if (user == null)
            {
                ModelState.AddModelError(string.Empty, "Thông tin đăng nhập không chính xác.");
                return View(model);
            }


            var verificationResult = _passwordHasher.VerifyHashedPassword(user, user.Password, model.Password);
            if (verificationResult == PasswordVerificationResult.Success)
            {
                HttpContext.Session.SetString("usersLogin", model.Email);
                HttpContext.Session.SetInt32("UsersID", (int)user.UserId);
                HttpContext.Session.SetString("Username", user.Username);
                HttpContext.Session.SetString("Email", user.Email);
                return RedirectToAction("Index", "Home", new { UsersID = user.UserId });
            }

            ModelState.AddModelError(string.Empty, "Thông tin đăng nhập không chính xác.");
            return View(model);
        }

        public IActionResult Logout()
        {
            var username = HttpContext.Session.GetString("usersLogin");
            HttpContext.Session.Remove("usersLogin");
            HttpContext.Session.Remove("UsersId");
            HttpContext.Session.Remove("Username");
            HttpContext.Session.Remove("Email");
            TempData["SuccessMessage"] = $"Đăng xuất thành công{(username != null ? " khỏi tài khoản " + username : "")}";
            return RedirectToAction("Index", "Home");
        }

        // GET: Users/Create
        public IActionResult Register()
        {
            return View();
        }

        // POST: Users/Create - Lưu user trực tiếp mà không gửi email xác nhận
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Register([Bind("Username,Email,Password,ConfirmPassword")] User user)
        {
            if (!ModelState.IsValid)
            {
                return View(user);
            }

            // Kiểm tra Password và ConfirmPassword có khớp nhau không
            if (user.Password != user.ConfirmPassword)
            {
                ModelState.AddModelError("ConfirmPassword", "Mật khẩu xác nhận không khớp với mật khẩu.");
                return View(user);
            }

            // Kiểm tra email đã tồn tại trong bảng Users
            if (await _context.Users.AnyAsync(x => x.Email.ToLower() == user.Email.ToLower()))
            {
                ModelState.AddModelError("Email", "Email này đã được đăng ký.");
                return View(user);
            }

            // Kiểm tra email có trong danh sách admin không
            if (await _context.Admins.AnyAsync(a => a.Email.ToLower() == user.Email.ToLower()))
            {
                ModelState.AddModelError("Email", "Email này không được phép đăng ký tài khoản người dùng.");
                return View(user);
            }

            // Kiểm tra username
            if (await _context.Users.AnyAsync(x => x.Username.ToLower() == user.Username.ToLower()))
            {
                ModelState.AddModelError("Username", "Tên đăng nhập này đã có người sử dụng.");
                return View(user);
            }

            try
            {
                // Hash mật khẩu
                var passwordHasher = new PasswordHasher<User>();
                user.Password = passwordHasher.HashPassword(user, user.Password);

                user.CreatedAt = DateTime.Now;

                // Lưu user trực tiếp vào cơ sở dữ liệu
                _context.Users.Add(user);
                await _context.SaveChangesAsync();

                TempData["SuccessMessage"] = "Đăng ký tài khoản thành công! Vui lòng đăng nhập.";
                return RedirectToAction("Login", "Account");
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", $"Có lỗi xảy ra khi đăng ký: {ex.Message}");
                return View(user);
            }
        }   

        // Interface IEmailSender
        public interface IEmailSender
        {
            Task SendEmailAsync(string email, string subject, string htmlMessage);
        }

        // Implementation EmailSender sử dụng MailKit
        public class EmailSender : IEmailSender
        {
            private readonly IConfiguration _configuration;

            public EmailSender(IConfiguration configuration)
            {
                _configuration = configuration;
            }

            public async Task SendEmailAsync(string email, string subject, string htmlMessage)
            {
                try
                {
                    var message = new MimeMessage();
                    message.From.Add(new MailboxAddress("WebTAManga", _configuration["EmailSettings:SenderEmail"]));
                    message.To.Add(new MailboxAddress("", email));
                    message.Subject = subject;
                    message.Body = new TextPart("html") { Text = htmlMessage };

                    using var client = new SmtpClient();
                    await client.ConnectAsync(_configuration["EmailSettings:SmtpServer"],
                        int.Parse(_configuration["EmailSettings:Port"]),
                        SecureSocketOptions.StartTls);

                    await client.AuthenticateAsync(_configuration["EmailSettings:Username"],
                        _configuration["EmailSettings:Password"]);

                    await client.SendAsync(message);
                    await client.DisconnectAsync(true);
                }
                catch (Exception ex)
                {
                    throw new Exception($"Lỗi khi gửi email: {ex.Message}", ex);
                }
            }
        }
        // Quên mật khẩu - Nhập email
        [HttpGet]
        public IActionResult ForgotPassword()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> ForgotPassword(Account model)
        {
            if (!ModelState.IsValid) return View(model);

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == model.Email);
            if (user == null)
            {
                TempData["ErrorMessage"] = "Email không tồn tại!";
                return View(model);
            }

            var resetCode = new Random().Next(100000, 999999).ToString();
            user.VerificationCode = resetCode;
            user.VerificationCodeExpires = DateTime.Now.AddMinutes(15);
            await _context.SaveChangesAsync();

            await _emailSender.SendEmailAsync(user.Email, "Mã xác nhận đặt lại mật khẩu",
                $"Mã xác nhận của bạn là: <strong>{resetCode}</strong>");

            TempData["Message"] = "Mã xác nhận đã được gửi đến email!";
            return RedirectToAction("EnterResetCode", new { email = user.Email });
        }

        // Nhập mã xác nhận
        [HttpGet]
        public IActionResult EnterResetCode(string email)
        {
            return View(new EnterResetCode { Email = email });
        }

        [HttpPost]
        public async Task<IActionResult> EnterResetCode(EnterResetCode model)
        {
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == model.Email);
            if (user == null || user.VerificationCode != model.Code || user.VerificationCodeExpires < DateTime.Now)
            {
                TempData["ErrorMessage"] = "Mã xác nhận không hợp lệ!";
                return View(model);
            }

            return RedirectToAction("ResetPassword", new { email = user.Email });
        }

        // Đặt lại mật khẩu
        [HttpGet]
        public IActionResult ResetPassword(string email)
        {
            return View(new Models.ResetPassword { Email = email });
        }

        [HttpPost]
        public async Task<IActionResult> ResetPassword(Models.ResetPassword model)
        {
            if (!ModelState.IsValid) return View(model);

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == model.Email);
            if (user == null)
            {
                TempData["ErrorMessage"] = "Email không tồn tại!";
                return View(model);
            }

            var passwordHasher = new PasswordHasher<User>();
            user.Password = passwordHasher.HashPassword(user, model.NewPassword);
            user.VerificationCode = null;
            user.VerificationCodeExpires = null;
            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = "Mật khẩu đã được đặt lại thành công!";
            return RedirectToAction("Login", "Account");
        }

        [HttpGet]
        public IActionResult ChangePassword()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Index", "Account");
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
                return RedirectToAction("Index", "Account");
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
                return RedirectToAction("Login", "Account");
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", $"Có lỗi xảy ra khi đổi mật khẩu: {ex.Message}");
                return View(model);
            }
        }
    }
}