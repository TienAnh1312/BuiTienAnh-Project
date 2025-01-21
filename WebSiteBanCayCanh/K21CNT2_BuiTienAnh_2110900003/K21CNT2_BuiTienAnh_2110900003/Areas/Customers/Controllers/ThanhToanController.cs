using K21CNT2_BuiTienAnh_2110900003.Areas.Customers.Controllers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace YourNamespace.Controllers
{
    public class ThanhToanController : BaseController
    {
        private readonly IConfiguration _configuration;

        public ThanhToanController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        // Phương thức gửi yêu cầu thanh toán đến VNPay
        public IActionResult CreateVnPayRequest(int orderId, decimal amount)
        {
            var vnpayUrl = _configuration["VNPAY:Url"];
            var tmnCode = _configuration["VNPAY:TmnCode"];
            var hashSecret = _configuration["VNPAY:HashSecret"];
            var returnUrl = _configuration["VNPAY:ReturnUrl"];

            // Tạo dữ liệu cho VNPay
            var vnp_Params = new Dictionary<string, string>
            {
                { "vnp_Version", "2" },
                { "vnp_TmnCode", tmnCode },
                { "vnp_Amount", (amount * 100).ToString() }, // Chuyển đổi giá trị tiền thành đơn vị nhỏ nhất
                { "vnp_CurrCode", "VND" },
                { "vnp_TxnRef", orderId.ToString() },  // Mã đơn hàng của bạn
                { "vnp_OrderInfo", "Thanh toan cho don hang" },
                { "vnp_Locale", "vn" },  // Ngôn ngữ
                { "vnp_ReturnUrl", returnUrl },
                { "vnp_IpAddr", Request.HttpContext.Connection.RemoteIpAddress.ToString() },
                { "vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss") }
            };

            // Tạo chuỗi hash
            var querystring = string.Join("&", vnp_Params.Select(p => $"{p.Key}={p.Value}"));
            var hashData = querystring + "&" + "vnp_HashSecret=" + hashSecret;
            var hmac = new HMACSHA512(Encoding.UTF8.GetBytes(hashSecret));
            var hash = BitConverter.ToString(hmac.ComputeHash(Encoding.UTF8.GetBytes(hashData))).Replace("-", "").ToUpper();

            vnp_Params.Add("vnp_SecureHash", hash);

            // Tạo URL yêu cầu
            var url = vnpayUrl + "?" + string.Join("&", vnp_Params.Select(p => $"{p.Key}={p.Value}"));
            return Redirect(url);
        }

        // Phương thức xử lý kết quả trả về từ VNPay
        public IActionResult Return()
        {
            var vnp_Params = Request.QueryString.Value;
            var vnp_SecureHash = Request.Query["vnp_SecureHash"].ToString();
            var hashSecret = _configuration["VNPAY:HashSecret"];

            var hashData = vnp_Params + "&" + "vnp_HashSecret=" + hashSecret;
            var hmac = new HMACSHA512(Encoding.UTF8.GetBytes(hashSecret));
            var hash = BitConverter.ToString(hmac.ComputeHash(Encoding.UTF8.GetBytes(hashData))).Replace("-", "").ToUpper();

            if (vnp_SecureHash == hash)
            {
                // Kiểm tra các thông tin như mã đơn hàng, số tiền, trạng thái giao dịch, ...
                var vnp_ResponseCode = Request.Query["vnp_ResponseCode"];
                if (vnp_ResponseCode == "00")
                {
                    // Thanh toán thành công
                    // Xử lý thành công thanh toán (ví dụ: thay đổi trạng thái đơn hàng, thông báo cho khách hàng, v.v.)
                }
                else
                {
                    // Thanh toán không thành công
                }
            }

            return View();  // Hiển thị trang kết quả thanh toán
        }
    }
}
