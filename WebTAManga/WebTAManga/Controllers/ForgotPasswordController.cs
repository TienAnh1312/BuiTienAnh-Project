using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using WebTAManga.Models;

using MailKit.Net.Smtp;
using MailKit.Security;
using MimeKit;
using Microsoft.EntityFrameworkCore;
using static WebTAManga.Controllers.RegisterController;


namespace WebTAManga.Controllers
{
    public class ForgotPasswordController : Controller
    {
        private readonly WebMangaContext _context;
        private readonly IEmailSender _emailSender;

        public ForgotPasswordController(WebMangaContext context, IEmailSender emailSender)
        {
            _context = context;
            _emailSender = emailSender;
        }

        // Quên mật khẩu - Nhập email
        [HttpGet]
        public IActionResult ForgotPassword()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> ForgotPassword(ForgotPassword model)
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
            return View(new ResetPassword { Email = email });
        }

        [HttpPost]
        public async Task<IActionResult> ResetPassword(ResetPassword model)
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
            return RedirectToAction("Index", "Login");
        }
    }
}
