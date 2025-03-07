using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Net.payOS.Types;
using Net.payOS;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class PayOsController : Controller
    {
        private readonly WebMangaContext _context;

        // Constructor duy nhất để nhận cả ILogger và WebMangaContext
        public PayOsController( WebMangaContext context)
        {
            
            _context = context;
        }
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> RechargeCoins(double amount)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return Json(new { success = false, redirect = Url.Action("Index", "Login") });
            }

            var payOS = HttpContext.RequestServices.GetService<PayOS>();
            var domain = "https://localhost:7040"; 
            long orderCode = DateTimeOffset.Now.ToUnixTimeSeconds(); // Mã đơn hàng duy nhất
            long expirationTime = DateTimeOffset.UtcNow.AddMinutes(30).ToUnixTimeSeconds();

            // Tạo yêu cầu thanh toán
            var paymentData = new PaymentData(
                orderCode: orderCode,
                amount: Convert.ToInt32(amount), // Số tiền nạp (VNĐ)
                description: $"Nạp {amount} xu cho user {userId}",
                items: [new ItemData($"Nạp {amount} xu", 1, Convert.ToInt32(amount))],
                returnUrl: domain + "/PayOs/RechargeSuccess",
                cancelUrl: domain + "/PayOs/RechargeCancel",
                expiredAt: expirationTime
            );

            try
            {
                var response = await payOS.createPaymentLink(paymentData);
                HttpContext.Session.SetInt32("PendingOrderCode", (int)orderCode); // Lưu tạm mã đơn để xác nhận sau
                HttpContext.Session.SetString("PendingAmount", amount.ToString());

                return Json(new { success = true, checkoutUrl = response.checkoutUrl });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Có lỗi xảy ra: " + ex.Message });
            }
        }

        [HttpGet]
        public IActionResult RechargeSuccess()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            var orderCode = HttpContext.Session.GetInt32("PendingOrderCode");
            var amountStr = HttpContext.Session.GetString("PendingAmount");

            if (userId == null || orderCode == null || string.IsNullOrEmpty(amountStr))
            {
                return RedirectToAction("Index", "Login");
            }

            var amount = double.Parse(amountStr);
            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            if (user != null)
            {
                // Kiểm tra xem đây có phải lần nạp đầu tiên không
                bool isFirstRecharge = !_context.Transactions.Any(t => t.UserId == userId && t.TransactionStatus == "Success");
                double finalCoins = amount; // Số xu cuối cùng sẽ cộng

                if (isFirstRecharge)
                {
                    finalCoins = amount * 2; // Nhân đôi số xu nếu là lần nạp đầu
                }

                // Cộng xu vào tài khoản người dùng
                user.Coins = (user.Coins ?? 0) + finalCoins;

                // Cập nhật tổng xu đã nạp (chỉ tính số tiền thực tế, không tính bonus)
                user.TotalRechargedCoins += amount;

                // Tính toán cấp VIP mới dựa trên số tiền thực tế nạp
                user.VipLevel = VipLevelConfig.CalculateVipLevel(user.TotalRechargedCoins);

                // Ghi lại lịch sử giao dịch
                _context.Transactions.Add(new WebTAManga.Models.Transaction
                {
                    UserId = userId.Value,
                    Amount = (int)amount,        // Số tiền thực tế nạp
                    Coins = (int)finalCoins,     // Số xu thực nhận (bao gồm bonus nếu có)
                    TransactionStatus = "Success",
                    VnpayTransactionId = orderCode.ToString(),
                    CreatedAt = DateTime.Now
                });

                _context.SaveChanges();

                // Xóa dữ liệu tạm trong session
                HttpContext.Session.Remove("PendingOrderCode");
                HttpContext.Session.Remove("PendingAmount");

                // Thông báo tùy theo trường hợp
                if (isFirstRecharge)
                {
                    TempData["SuccessMessage"] = $"Nạp lần đầu thành công! Bạn nhận được {finalCoins} xu (x2 bonus) với {amount} VNĐ!";
                }
                else
                {
                    TempData["SuccessMessage"] = $"Nạp {amount} xu thành công! Cấp VIP hiện tại: {user.VipLevel}";
                }
            }

            return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public IActionResult RechargeCancel()
        {
            HttpContext.Session.Remove("PendingOrderCode");
            HttpContext.Session.Remove("PendingAmount");
            TempData["ErrorMessage"] = "Giao dịch nạp xu đã bị hủy.";
            return RedirectToAction("Index", "Home");
        }

    }
}
