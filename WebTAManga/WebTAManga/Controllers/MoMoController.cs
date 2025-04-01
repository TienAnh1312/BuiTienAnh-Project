using System;
using System.Linq;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class MoMoController : Controller
    {
        private readonly WebMangaContext _context;
        private readonly IHttpClientFactory _httpClientFactory;
        private const string PartnerCode = "MOMO_ATM_DEV";
        private const string AccessKey = "w9gEg8bjA2AM2Cvr";
        private const string SecretKey = "mD9QAVi4cm9N844jh5Y2tqjWaaJoGVFM";
        private const string PaymentEndpoint = "https://test-payment.momo.vn/v2/gateway/api/create";
        private const string RedirectUrl = "https://localhost:7040/MoMo/MoMoCallback";
        private const string IpnUrl = "https://localhost:7040/MoMo/MoMoNotify";

        public MoMoController(WebMangaContext context, IHttpClientFactory httpClientFactory)
        {
            _context = context;
            _httpClientFactory = httpClientFactory;
        }

        [HttpGet]
        public IActionResult Recharge()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                TempData["ErrorMessage"] = "Vui lòng đăng nhập để nạp xu.";
                return RedirectToAction("Login", "Account");
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Recharge(int amount, string paymentMethod = "captureWallet")
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập để nạp xu." });
            }

            // Danh sách mốc nạp hợp lệ (loại bỏ 5000)
            int[] validAmounts = { 10000, 20000, 50000, 100000, 200000, 500000, 1000000, 2000000 };
            if (!validAmounts.Contains(amount))
            {
                return Json(new { success = false, message = "Số tiền nạp không hợp lệ." });
            }

            if (!IsValidPaymentMethod(paymentMethod))
            {
                return Json(new { success = false, message = "Phương thức thanh toán không hợp lệ." });
            }

            var recharge = CreateRechargeRecord(userId.Value, amount, paymentMethod);
            _context.RechargeHistories.Add(recharge);
            await _context.SaveChangesAsync();

            var paymentUrl = await CreateMoMoPayment(recharge.RechargeId, amount, paymentMethod);
            if (string.IsNullOrEmpty(paymentUrl))
            {
                _context.RechargeHistories.Remove(recharge);
                await _context.SaveChangesAsync();
                return Json(new { success = false, message = "Không thể tạo thanh toán MoMo." });
            }

            HttpContext.Session.SetInt32("PendingRechargeId", recharge.RechargeId);
            return Json(new { success = true, redirectUrl = paymentUrl });
        }

        [HttpGet]
        public async Task<IActionResult> CheckFirstRecharge()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return Json(new { isFirstRecharge = false });
            }

            var isFirstRecharge = !await _context.RechargeHistories
                .AnyAsync(r => r.UserId == userId && r.Status == "Completed");

            return Json(new { isFirstRecharge });
        }

        private async Task<string> CreateMoMoPayment(int rechargeId, int amount, string paymentMethod)
        {
            var orderId = $"MM{rechargeId}";
            var requestId = Guid.NewGuid().ToString();
            var orderInfo = $"Nạp {amount / 10} xu";
            var amountStr = amount.ToString();

            var rawData = $"accessKey={AccessKey}&amount={amountStr}&extraData=&ipnUrl={IpnUrl}&orderId={orderId}&orderInfo={orderInfo}&partnerCode={PartnerCode}&redirectUrl={RedirectUrl}&requestId={requestId}&requestType={paymentMethod}";
            var signature = ComputeHmacSha256(SecretKey, rawData);

            var requestData = new
            {
                partnerCode = PartnerCode,
                requestId,
                amount = long.Parse(amountStr),
                orderId,
                orderInfo,
                redirectUrl = RedirectUrl,
                ipnUrl = IpnUrl,
                requestType = paymentMethod,
                extraData = "",
                signature
            };

            using var client = _httpClientFactory.CreateClient();
            var json = JsonConvert.SerializeObject(requestData);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            try
            {
                var response = await client.PostAsync(PaymentEndpoint, content);
                var responseBody = await response.Content.ReadAsStringAsync();

                if (!response.IsSuccessStatusCode)
                {
                    TempData["ErrorMessage"] = $"Yêu cầu MoMo thất bại. Mã lỗi: {response.StatusCode}";
                    return null;
                }

                var responseData = JsonConvert.DeserializeObject<dynamic>(responseBody);
                var payUrl = responseData.payUrl?.ToString();

                if (string.IsNullOrEmpty(payUrl))
                {
                    TempData["ErrorMessage"] = "Không nhận được URL thanh toán từ MoMo.";
                    return null;
                }

                await UpdateTransactionId(rechargeId, orderId);
                return payUrl;
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi kết nối MoMo: {ex.Message}";
                return null;
            }
        }

        [HttpGet]
        public async Task<IActionResult> MoMoCallback(string orderId, string resultCode, string message)
        {
            if (!int.TryParse(orderId.StartsWith("MM") ? orderId.Substring(2) : orderId, out int rechargeId))
            {
                TempData["ErrorMessage"] = "Mã giao dịch không hợp lệ.";
                return RedirectToAction("Recharge");
            }

            var recharge = await GetRechargeRecord(rechargeId);
            if (recharge == null)
            {
                TempData["ErrorMessage"] = "Không tìm thấy giao dịch.";
                return RedirectToAction("Recharge");
            }

            if (recharge.Status != "Pending")
            {
                TempData["ErrorMessage"] = "Giao dịch đã được xử lý.";
                return RedirectToAction("Index", "Home");
            }

            if (resultCode == "0")
            {
                await ProcessSuccessfulPayment(recharge);
                TempData["SuccessMessage"] = "Nạp xu thành công!";
                return RedirectToAction("Index", "Home");
            }

            recharge.Status = "Failed";
            await _context.SaveChangesAsync();
            TempData["ErrorMessage"] = $"Nạp xu thất bại: {message}";
            return RedirectToAction("Recharge");
        }

        [HttpPost]
        public async Task<IActionResult> MoMoNotify([FromBody] MoMoNotifyModel notifyData)
        {
            if (notifyData == null || string.IsNullOrEmpty(notifyData.orderId))
                return BadRequest("Dữ liệu thông báo không hợp lệ.");

            if (!int.TryParse(notifyData.orderId.StartsWith("MM") ? notifyData.orderId.Substring(2) : notifyData.orderId, out int rechargeId))
                return BadRequest("Mã giao dịch không hợp lệ.");

            var recharge = await GetRechargeRecord(rechargeId);
            if (recharge == null)
                return NotFound("Không tìm thấy giao dịch.");

            if (!IsValidSignature(notifyData))
                return BadRequest("Chữ ký không hợp lệ.");

            if (recharge.Status != "Pending")
                return Ok();

            if (notifyData.resultCode == 0)
                await ProcessSuccessfulPayment(recharge);
            else
                recharge.Status = "Failed";

            await _context.SaveChangesAsync();
            return Ok();
        }

        private RechargeHistory CreateRechargeRecord(int userId, int amount, string paymentMethod)
        {
            bool isFirstRecharge = !_context.RechargeHistories
                .Any(r => r.UserId == userId && r.Status == "Completed");
            double baseCoins = amount / 10.0;
            double totalCoins = isFirstRecharge ? baseCoins + 1500 : baseCoins;

            return new RechargeHistory
            {
                UserId = userId,
                Amount = amount,
                Coins = totalCoins,
                Status = "Pending",
                CreatedAt = DateTime.Now,
                PaymentMethod = paymentMethod
            };
        }

        private async Task<RechargeHistory> GetRechargeRecord(int rechargeId)
        {
            return await _context.RechargeHistories
                .Include(r => r.User)
                .FirstOrDefaultAsync(r => r.RechargeId == rechargeId);
        }

        private async Task ProcessSuccessfulPayment(RechargeHistory recharge)
        {
            recharge.Status = "Completed";
            recharge.CompletedAt = DateTime.Now;
            recharge.User.Coins = (recharge.User.Coins ?? 0) + recharge.Coins;
            recharge.User.TotalRechargedCoins += recharge.Coins;

            _context.RechargeHistories.Update(recharge);
            _context.Users.Update(recharge.User);
            await _context.SaveChangesAsync();
        }

        private async Task UpdateTransactionId(int rechargeId, string orderId)
        {
            var recharge = await _context.RechargeHistories.FindAsync(rechargeId);
            if (recharge != null)
            {
                recharge.MomoTransactionId = orderId;
                _context.RechargeHistories.Update(recharge);
                await _context.SaveChangesAsync();
            }
        }

        private bool IsValidPaymentMethod(string paymentMethod)
        {
            return new[] { "captureWallet", "payWithATM" }.Contains(paymentMethod);
        }

        private bool IsValidSignature(MoMoNotifyModel notifyData)
        {
            var rawData = $"accessKey={notifyData.accessKey}&amount={notifyData.amount}&extraData={notifyData.extraData}&message={notifyData.message}&orderId={notifyData.orderId}&orderInfo={notifyData.orderInfo}&orderType={notifyData.orderType}&partnerCode={notifyData.partnerCode}&payType={notifyData.payType}&requestId={notifyData.requestId}&responseTime={notifyData.responseTime}&resultCode={notifyData.resultCode}&transId={notifyData.transId}";
            var signature = ComputeHmacSha256(SecretKey, rawData);
            return signature == notifyData.signature;
        }

        private string ComputeHmacSha256(string key, string data)
        {
            using var hmac = new HMACSHA256(Encoding.UTF8.GetBytes(key));
            var hash = hmac.ComputeHash(Encoding.UTF8.GetBytes(data));
            return BitConverter.ToString(hash).Replace("-", "").ToLower();
        }
    }

    public class MoMoNotifyModel
    {
        public string partnerCode { get; set; }
        public string orderId { get; set; }
        public string requestId { get; set; }
        public long amount { get; set; }
        public string orderInfo { get; set; }
        public string orderType { get; set; }
        public long transId { get; set; }
        public int resultCode { get; set; }
        public string message { get; set; }
        public string payType { get; set; }
        public long responseTime { get; set; }
        public string extraData { get; set; }
        public string signature { get; set; }
        public string accessKey { get; set; }
    }
}