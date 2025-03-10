using MailKit.Security;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MimeKit;
using WebTAManga.Models;
using MailKit.Net.Smtp;
using Microsoft.VisualStudio.Web.CodeGenerators.Mvc.Templates.BlazorIdentity.Pages;

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

            if (!user.IsEmailVerified)
            {
                ModelState.AddModelError(string.Empty, "Tài khoản chưa được xác nhận. Vui lòng kiểm tra email.");
                return View(model);
            }

            var verificationResult = _passwordHasher.VerifyHashedPassword(user, user.Password, model.Password);
            if (verificationResult == PasswordVerificationResult.Success)
            {
                HttpContext.Session.SetString("usersLogin", model.Email);
                HttpContext.Session.SetInt32("UsersID", (int)user.UserId);
                return RedirectToAction("Index", "Home", new { UsersID = user.UserId });
            }

            ModelState.AddModelError(string.Empty, "Thông tin đăng nhập không chính xác.");
            return View(model);
        }

        public IActionResult Logout()
        {
            // Lưu thông tin user trước khi xóa (nếu cần)
            var username = HttpContext.Session.GetString("usersLogin");

            // Xóa session
            HttpContext.Session.Remove("usersLogin");
            HttpContext.Session.Remove("UsersId");

            // Thêm thông báo thành công
            TempData["SuccessMessage"] = $"Đăng xuất thành công{(username != null ? " khỏi tài khoản " + username : "")}";

            // Chuyển hướng về trang chủ
            return RedirectToAction("Index", "Home");
        }

        // GET: Users/Create
        public IActionResult Register()
        {
            return View();
        }

        // POST: Users/Create - Gửi email xác nhận mà không lưu user ngay
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Register([Bind("Username,Email,Password")] User user)
        {
            if (!ModelState.IsValid)
            {
                return View(user);
            }

            // Kiểm tra email đã tồn tại trong bảng Users
            if (await _context.Users.AnyAsync(x => x.Email.ToLower() == user.Email.ToLower()))
            {
                ModelState.AddModelError("Email", "Email này đã được đăng ký.");
                return View(user);
            }

            // Kiểm tra email có trong danh sách admin không (giả sử có bảng Admins)
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
                // Tạo mã xác nhận ngẫu nhiên
                var verificationCode = Guid.NewGuid().ToString("N").Substring(0, 6);

                // Hash mật khẩu
                var passwordHasher = new PasswordHasher<User>();
                user.Password = passwordHasher.HashPassword(user, user.Password);

                // Lưu thông tin tạm thời vào TempData hoặc session để sử dụng sau khi xác nhận
                TempData["PendingUser"] = System.Text.Json.JsonSerializer.Serialize(new
                {
                    Username = user.Username,
                    Email = user.Email,
                    Password = user.Password,
                    VerificationCode = verificationCode
                });

                // Gửi email xác nhận
                var emailContent = $@"
                <h2>Xác nhận email đăng ký</h2>
                <p>Mã xác nhận của bạn là: <strong>{verificationCode}</strong></p>
                <p>Vui lòng nhập mã này để hoàn tất đăng ký.</p>
                <p>Mã này sẽ hết hạn sau 24 giờ.</p>";

                await _emailSender.SendEmailAsync(user.Email, "Xác nhận đăng ký tài khoản", emailContent);

                TempData["Message"] = "Vui lòng kiểm tra email để lấy mã xác nhận!";
                return RedirectToAction("EnterVerificationCode", new { email = user.Email });
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", $"Có lỗi xảy ra khi gửi mã xác nhận: {ex.Message}");
                return View(user);
            }
        }

        // GET: Users/EnterVerificationCode - Trang nhập mã xác nhận
        public IActionResult EnterVerificationCode(string email)
        {
            ViewBag.Email = email;
            return View();
        }

        // GET: Users/VerificationPending - Trang chờ xác nhận email
        public IActionResult VerificationPending(string email = null)
        {
            ViewBag.Email = email;
            return View();
        }

        // POST: Users/EnterVerificationCode - Xử lý mã xác nhận
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EnterVerificationCode(string email, string code)
        {
            if (string.IsNullOrEmpty(code))
            {
                TempData["ErrorMessage"] = "Vui lòng nhập mã xác nhận.";
                return View(new { Email = email });
            }

            var pendingUserJson = TempData["PendingUser"]?.ToString();
            if (string.IsNullOrEmpty(pendingUserJson))
            {
                TempData["ErrorMessage"] = "Phiên đăng ký đã hết hạn. Vui lòng thử lại.";
                return RedirectToAction("Register");
            }

            var pendingUser = System.Text.Json.JsonSerializer.Deserialize<dynamic>(pendingUserJson);
            string storedCode = pendingUser.GetProperty("VerificationCode").GetString();

            if (storedCode != code)
            {
                TempData["ErrorMessage"] = "Mã xác nhận không đúng.";
                return View(new { Email = email });
            }

            try
            {
                var user = new User
                {
                    Username = pendingUser.GetProperty("Username").GetString(),
                    Email = pendingUser.GetProperty("Email").GetString(),
                    Password = pendingUser.GetProperty("Password").GetString(),
                    CreatedAt = DateTime.Now,
                    IsEmailVerified = true // Đã xác nhận nên set true
                };

                _context.Users.Add(user);
                await _context.SaveChangesAsync();

                TempData["SuccessMessage"] = "Đăng ký tài khoản thành công! Vui lòng đăng nhập.";
                return RedirectToAction("Login", "Account");
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Có lỗi xảy ra khi hoàn tất đăng ký: {ex.Message}";
                return View(new { Email = email });
            }
        }

        // GET: Users/VerifyEmail - Xử lý xác nhận email
        [HttpGet]
        public async Task<IActionResult> VerifyEmail(int userId, string code)
        {
            var user = await _context.Users.FirstOrDefaultAsync(u => u.UserId == userId);
            if (user == null)
            {
                return View("Error", new ErrorViewModel { Message = "Người dùng không tồn tại" });
            }

            if (user.IsEmailVerified)
            {
                TempData["SuccessMessage"] = "Tài khoản đã được xác nhận trước đó. Vui lòng đăng nhập.";
                return RedirectToAction("Login", "Account");
            }

            if (user.VerificationCode != code || user.VerificationCodeExpires < DateTime.Now)
            {
                return View("Error", new ErrorViewModel { Message = "Mã xác nhận không hợp lệ hoặc đã hết hạn" });
            }

            // Xác nhận thành công
            user.IsEmailVerified = true;
            user.VerificationCode = null;
            user.VerificationCodeExpires = null;

            await _context.SaveChangesAsync();

            TempData["SuccessMessage"] = "Xác nhận email thành công! Vui lòng đăng nhập.";
            return RedirectToAction("Login", "Account");
        }

        // GET: Users/ResendVerification - Gửi lại email xác nhận
        [HttpGet]
        public async Task<IActionResult> ResendVerification(string email)
        {
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email.ToLower() == email.ToLower());
            if (user == null || user.IsEmailVerified)
            {
                TempData["ErrorMessage"] = "Email không tồn tại hoặc đã được xác nhận.";
                return RedirectToAction("Index", "Home");
            }

            try
            {
                var verificationCode = Guid.NewGuid().ToString("N").Substring(0, 6);
                user.VerificationCode = verificationCode;
                user.VerificationCodeExpires = DateTime.Now.AddHours(24);

                var callbackUrl = Url.Action("VerifyEmail", "Users",
                    new { userId = user.UserId, code = verificationCode },
                    protocol: Request.Scheme);

                var emailContent = $@"
                    <h2>Xác nhận email đăng ký</h2>
                    <p>Vui lòng xác nhận email bằng cách nhấn vào liên kết sau:</p>
                    <a href='{callbackUrl}'>Xác nhận email</a>
                    <p>Mã xác nhận: <strong>{verificationCode}</strong></p>
                    <p>Mã này sẽ hết hạn sau 24 giờ.</p>";

                await _emailSender.SendEmailAsync(user.Email, "Xác nhận đăng ký tài khoản", emailContent);
                await _context.SaveChangesAsync();

                TempData["Message"] = "Email xác nhận đã được gửi lại!";
                return RedirectToAction("VerificationPending", new { email = user.Email });
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi gửi lại email: {ex.Message}";
                return RedirectToAction("VerificationPending", new { email = user.Email });
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
    }
}
