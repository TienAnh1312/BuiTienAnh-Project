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
                return Json(new { success = false, redirect = Url.Action("Login", "Account") });
            }

            var validAmounts = new[] { 5000, 10000, 20000, 50000, 100000, 200000, 500000, 1000000, 2000000 };
            if (!validAmounts.Contains((int)amount))
            {
                return Json(new { success = false, message = "Gói nạp không hợp lệ. Vui lòng chọn lại." });
            }

            var payOS = HttpContext.RequestServices.GetService<PayOS>();
            var domain = "https://localhost:7040";
            long orderCode = DateTimeOffset.Now.ToUnixTimeSeconds();
            long expirationTime = DateTimeOffset.UtcNow.AddMinutes(30).ToUnixTimeSeconds();

            // Tính số xu cơ bản (baseCoins) từ amount
            double baseCoins = amount switch
            {
                5000 => 500,
                10000 => 1000,
                20000 => 2000,
                50000 => 5000,
                100000 => 10000,
                200000 => 20000,
                500000 => 50000,
                1000000 => 100000,
                2000000 => 200000,
                _ => amount // Trường hợp không khớp (không xảy ra do kiểm tra validAmounts)
            };

            // Kiểm tra lần nạp đầu để tính số xu cuối cùng
            bool isFirstRecharge = !_context.Transactions.Any(t => t.UserId == userId && t.TransactionStatus == "Success");
            double finalCoins = isFirstRecharge ? baseCoins + 1500 : baseCoins;

            // Tạo PaymentData 
            var paymentData = new PaymentData(
                orderCode: orderCode,
                amount: Convert.ToInt32(amount),
                description: $"Nạp {finalCoins} xu", 
                items: [new ItemData($"Nạp {finalCoins} xu", 1, Convert.ToInt32(amount))],
                returnUrl: domain + "/PayOs/RechargeSuccess",
                cancelUrl: domain + "/PayOs/RechargeCancel",
                expiredAt: expirationTime
            );

            try
            {
                var response = await payOS.createPaymentLink(paymentData);
                HttpContext.Session.SetInt32("PendingOrderCode", (int)orderCode);
                HttpContext.Session.SetString("PendingAmount", amount.ToString());

                return Json(new
                {
                    success = true,
                    checkoutUrl = response.checkoutUrl,
                    isFirstRecharge = isFirstRecharge
                });
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
                return RedirectToAction("Login", "Account");
            }

            var amount = double.Parse(amountStr);
            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            if (user != null)
            {
                // Ánh xạ số tiền VND sang số xu cơ bản
                double baseCoins = amount switch
                {
                    5000 => 500,
                    10000 => 1000,
                    20000 => 2000,
                    50000 => 5000,
                    100000 => 10000,
                    200000 => 20000,
                    500000 => 50000,
                    1000000 => 100000,
                    2000000 => 200000,
                    _ => amount
                };

                bool isFirstRecharge = !_context.Transactions.Any(t => t.UserId == userId && t.TransactionStatus == "Success");
                double finalCoins = isFirstRecharge ? baseCoins + 1500 : baseCoins; // Cộng 1500 xu nếu là lần đầu

                // Cộng xu vào tài khoản người dùng
                user.Coins = (user.Coins ?? 0) + finalCoins;
                user.TotalRechargedCoins += baseCoins; 
                user.VipLevel = VipLevelConfig.CalculateVipLevel(user.TotalRechargedCoins);

                // Ghi lại lịch sử giao dịch
                _context.Transactions.Add(new Models.Transaction
                {
                    UserId = userId.Value,
                    Amount = (int)amount,
                    Coins = (int)finalCoins,
                    TransactionStatus = "Success",
                    VnpayTransactionId = orderCode.ToString(),
                    CreatedAt = DateTime.Now
                });

                _context.SaveChanges();

                HttpContext.Session.Remove("PendingOrderCode");
                HttpContext.Session.Remove("PendingAmount");

                if (isFirstRecharge)
                {
                    TempData["SuccessMessage"] = $"Nạp lần đầu thành công! Bạn nhận được {finalCoins} xu (gồm 1500 xu bonus) với {amount} VNĐ!";
                }
                else
                {
                    TempData["SuccessMessage"] = $"Nạp {baseCoins} xu thành công! Cấp VIP hiện tại: {user.VipLevel}";
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
