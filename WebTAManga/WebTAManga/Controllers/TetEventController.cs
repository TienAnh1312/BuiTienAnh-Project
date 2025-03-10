using Microsoft.AspNetCore.Mvc;
using WebTAManga.Models;
using System;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace WebTAManga.Controllers
{
    public class TetEventController : Controller
    {
        private readonly WebMangaContext _context;

        public TetEventController(WebMangaContext context)
        {
            _context = context;
        }

        // Trang rung cây và hiển thị nhiệm vụ
        public IActionResult TetTreeShake()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Login", "Account");
            }

            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            if (user == null)
            {
                return NotFound();
            }

            // Lấy ngày hiện tại
            var today = DateOnly.FromDateTime(DateTime.Today);
            var dailyTasks = _context.UserDailyTasks
                .Where(udt => udt.UserId == userId && udt.TaskDate == today)
                .Include(udt => udt.Task)
                .ToList();

            // Nếu không có nhiệm vụ hôm nay hoặc ngày đã thay đổi, làm mới nhiệm vụ
            if (!dailyTasks.Any())
            {
                // Xóa nhiệm vụ cũ của người dùng (nếu cần)
                var oldTasks = _context.UserDailyTasks.Where(udt => udt.UserId == userId && udt.TaskDate < today);
                _context.UserDailyTasks.RemoveRange(oldTasks);

                // Lấy danh sách nhiệm vụ cố định từ DailyTasks
                var availableTasks = _context.DailyTasks.ToList();
                foreach (var task in availableTasks)
                {
                    _context.UserDailyTasks.Add(new UserDailyTask
                    {
                        UserId = userId.Value,
                        TaskId = task.TaskId,
                        IsCompleted = false,
                        TaskDate = today
                    });
                }
                _context.SaveChanges();

                // Lấy lại danh sách nhiệm vụ mới
                dailyTasks = _context.UserDailyTasks
                    .Where(udt => udt.UserId == userId && udt.TaskDate == today)
                    .Include(udt => udt.Task)
                    .ToList();
            }

            ViewBag.User = user;
            ViewBag.DailyTasks = dailyTasks;
            return View();
        }

        // Xử lý rung cây
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

            if ((user.ShakeCount ?? 0) <= 0)
            {
                return Json(new { success = false, message = "Bạn đã hết lượt rung! Hoàn thành nhiệm vụ để nhận thêm lượt." });
            }

            user.ShakeCount -= 1;
            Random rand = new Random();
            int coinsReward = rand.Next(10, 51);
            int expReward = rand.Next(20, 101);

            user.Coins = (user.Coins ?? 0) + coinsReward;
            user.ExpPoints = (user.ExpPoints ?? 0) + expReward;

            var expHistory = new ExpHistory
            {
                UserId = user.UserId,
                ExpAmount = expReward,
                Reason = "Rung cây lì xì Tết",
                CreatedAt = DateTime.Now
            };
            _context.ExpHistories.Add(expHistory);
            _context.SaveChanges();

            UpdateUserLevel(user);

            return Json(new
            {
                success = true,
                coins = coinsReward,
                exp = expReward,
                totalCoins = user.Coins,
                totalExp = user.ExpPoints,
                shakeCount = user.ShakeCount,
                message = $"Bạn nhận được {coinsReward} xu và {expReward} EXP!"
            });
        }

        // Xử lý hoàn thành nhiệm vụ
        [HttpPost]
        public IActionResult CompleteDailyTask(int userTaskId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập!" });
            }

            var userTask = _context.UserDailyTasks
                .Include(udt => udt.Task)
                .FirstOrDefault(udt => udt.UserTaskId == userTaskId && udt.UserId == userId);

            if (userTask == null)
            {
                return Json(new { success = false, message = "Nhiệm vụ không tồn tại!" });
            }

            if (userTask.IsCompleted)
            {
                return Json(new { success = false, message = "Nhiệm vụ đã được hoàn thành trước đó!" });
            }

            bool canComplete = CheckTaskCompletion(userTask, userId.Value);
            if (!canComplete)
            {
                return Json(new { success = false, message = "Bạn chưa đáp ứng điều kiện để hoàn thành nhiệm vụ này!" });
            }

            // Hoàn thành nhiệm vụ
            userTask.IsCompleted = true;
            userTask.CompletedAt = DateTime.Now;

            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            user.Coins = (user.Coins ?? 0) + userTask.Task.CoinReward;
            user.ExpPoints = (user.ExpPoints ?? 0) + userTask.Task.ExpReward;
            user.ShakeCount = (user.ShakeCount ?? 0) + userTask.Task.ShakeReward;

            var expHistory = new ExpHistory
            {
                UserId = user.UserId,
                ExpAmount = userTask.Task.ExpReward,
                Reason = $"Hoàn thành nhiệm vụ: {userTask.Task.TaskName}",
                CreatedAt = DateTime.Now
            };
            _context.ExpHistories.Add(expHistory);

            _context.SaveChanges();
            UpdateUserLevel(user);

            return Json(new
            {
                success = true,
                shakeCount = user.ShakeCount,
                message = $"Nhiệm vụ hoàn thành! Bạn nhận được {userTask.Task.CoinReward} xu, {userTask.Task.ExpReward} EXP và {userTask.Task.ShakeReward} lượt rung!"
            });
        }

        // Kiểm tra điều kiện hoàn thành nhiệm vụ (ví dụ)
        private bool CheckTaskCompletion(UserDailyTask userTask, int userId)
        {
            var today = DateTime.Today;
            switch (userTask.Task.TaskName)
            {
                case "Đăng nhập hàng ngày":
                    // Kiểm tra xem người dùng đã đăng nhập hôm nay chưa
                    // Giả sử đăng nhập được ghi nhận khi session được thiết lập
                    return HttpContext.Session.GetInt32("UsersID") == userId;

                case "Đọc 1 chương truyện":
                    return _context.ReadingHistories
                        .Any(rh => rh.UserId == userId && rh.LastReadAt >= today);

                case "Bình luận 1 lần":
                    return _context.Comments
                        .Any(c => c.UserId == userId && c.CreatedAt >= today);

                default:
                    return false; // Nếu không khớp nhiệm vụ nào, trả về false
            }
        }

        private void UpdateUserLevel(User user)
        {
            var nextLevel = _context.Levels
                .Where(l => l.ExpRequired <= (user.ExpPoints ?? 0))
                .OrderByDescending(l => l.ExpRequired)
                .FirstOrDefault();

            if (nextLevel != null && user.Level < nextLevel.LevelId)
            {
                user.Level = nextLevel.LevelId;
                user.CategoryRankId = nextLevel.CategoryRankId;
                _context.SaveChanges();
            }
        }
    }
}