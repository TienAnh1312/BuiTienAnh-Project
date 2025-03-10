using Microsoft.AspNetCore.Mvc;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class NotificationController : Controller
    {
        private readonly WebMangaContext _context;

        public NotificationController(WebMangaContext context)
        {
            _context = context;
        }

        // Hiển thị danh sách thông báo của người dùng
        public IActionResult Index()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null) return RedirectToAction("Login", "Account");

            var notifications = _context.Notifications
                .Where(n => n.UserId == userId)
                .OrderByDescending(n => n.CreatedAt)
                .ToList();

            return View(notifications);
        }

        // Đánh dấu thông báo là đã đọc
        [HttpPost]
        public IActionResult MarkAsRead(int notificationId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null) return Unauthorized();

            var notification = _context.Notifications
                .FirstOrDefault(n => n.NotificationId == notificationId && n.UserId == userId);
            if (notification != null)
            {
                notification.IsRead = true;
                _context.SaveChanges();
            }

            return Json(new { success = true });
        }
    }
}
