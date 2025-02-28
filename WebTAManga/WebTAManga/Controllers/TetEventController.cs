using Microsoft.AspNetCore.Mvc;
using WebTAManga.Models;
using System;
using System.Linq;

namespace WebTAManga.Controllers
{
    public class TetEventController : Controller
    {
        private readonly WebMangaContext _context;

        public TetEventController(WebMangaContext context)
        {
            _context = context;
        }

        // Trang hiển thị sự kiện Tết
        public IActionResult TetTreeShake()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            if (user == null)
            {
                return NotFound();
            }

            // Truyền thông tin người dùng vào View
            ViewBag.Coins = user.Coins ?? 0;
            ViewBag.ExpPoints = user.ExpPoints ?? 0;
            return View();
        }

        // Xử lý rung cây lì xì
        [HttpPost]
        public IActionResult ShakeTree()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập để tham gia!" });
            }

            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            if (user == null)
            {
                return Json(new { success = false, message = "Không tìm thấy người dùng!" });
            }

            // Kiểm tra giới hạn lượt rung (ví dụ: 3 lượt/ngày)
            var today = DateTime.Today;
            var shakeCount = _context.ExpHistories
                .Count(e => e.UserId == userId && e.CreatedAt >= today && e.Reason == "Rung cây lì xì Tết");

            if (shakeCount >= 3)
            {
                return Json(new { success = false, message = "Bạn đã hết lượt rung hôm nay!" });
            }

            // Tạo số ngẫu nhiên cho xu và EXP
            Random rand = new Random();
            int coinsReward = rand.Next(10, 51); // Nhận 10-50 xu
            int expReward = rand.Next(20, 101);  // Nhận 20-100 EXP

            // Cập nhật thông tin người dùng
            user.Coins = (user.Coins ?? 0) + coinsReward;
            user.ExpPoints = (user.ExpPoints ?? 0) + expReward;

            // Ghi lịch sử EXP
            var expHistory = new ExpHistory
            {
                UserId = user.UserId,
                ExpAmount = expReward,
                Reason = "Rung cây lì xì Tết",
                CreatedAt = DateTime.Now
            };
            _context.ExpHistories.Add(expHistory);

            // Lưu thay đổi
            _context.SaveChanges();

            // Cập nhật level nếu cần
            UpdateUserLevel(user);

            return Json(new
            {
                success = true,
                coins = coinsReward,
                exp = expReward,
                totalCoins = user.Coins,
                totalExp = user.ExpPoints,
                message = $"Bạn nhận được {coinsReward} xu và {expReward} EXP!"
            });
        }

        // Hàm cập nhật level dựa trên EXP
        private void UpdateUserLevel(User user)
        {
            var nextLevel = _context.Levels
                .Where(l => l.ExpRequired <= (user.ExpPoints ?? 0))
                .OrderByDescending(l => l.ExpRequired)
                .FirstOrDefault();

            if (nextLevel != null && user.Level < nextLevel.LevelId)
            {
                user.Level = nextLevel.LevelId;
                user.CategoryRankId = nextLevel.CategoryRankId; // Cập nhật CategoryRank nếu cần
                _context.SaveChanges();
            }
        }
    }
}