using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;
using Net.payOS;
using WebTAManga.Areas.Admins.Models;
using WebTAManga.Models;
using static WebTAManga.Controllers.AccountController;

namespace WebTAManga
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            var connectionString = builder.Configuration.GetConnectionString("AppConnection");

            // Thêm DbContext
            builder.Services.AddDbContext<WebMangaContext>(options => options.UseSqlServer(connectionString));

            // Thêm HttpContextAccessor
            builder.Services.AddHttpContextAccessor();

            // Thêm HttpClient
            builder.Services.AddHttpClient();

            // Thêm dịch vụ gửi email
            builder.Services.AddScoped<IEmailSender, EmailSender>();

            // Đọc cấu hình PayOS từ appsettings.json
            var payOsConfig = builder.Configuration.GetSection("PayOS");
            var clientId = payOsConfig["ClientId"];
            var apiKey = payOsConfig["ApiKey"];
            var checksumKey = payOsConfig["ChecksumKey"];

            // Khởi tạo PayOS
            var payOS = new PayOS(clientId, apiKey, checksumKey);
            builder.Services.AddSingleton(payOS);

            // Cấu hình session
            builder.Services.AddDistributedMemoryCache(); // Cần cho session
            builder.Services.AddSession(options =>
            {
                options.IdleTimeout = TimeSpan.FromMinutes(30);
                options.Cookie.HttpOnly = true;
                options.Cookie.IsEssential = true;
                options.Cookie.Name = "TADev";
            });

            // Thêm dịch vụ xác thực
            builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
                .AddCookie(options =>
                {
                    options.LoginPath = "/Admins/Login/Index"; // Trang đăng nhập
                    options.AccessDeniedPath = "/Admins/Login/AccessDenied"; // Trang khi bị từ chối truy cập
                    options.ExpireTimeSpan = TimeSpan.FromMinutes(30); // Thời gian hết hạn cookie
                });

            // Thêm dịch vụ MVC
            builder.Services.AddControllersWithViews();

            var app = builder.Build();

            // Cấu hình pipeline
            if (!app.Environment.IsDevelopment())
            {
                app.UseExceptionHandler("/Home/Error");
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            // Bật xác thực trước phân quyền
            app.UseAuthentication();
            app.UseAuthorization();

            // Bật session
            app.UseSession();

            app.MapControllerRoute(
                name: "areas",
                pattern: "{area:exists}/{controller=Dashboard}/{action=Index}/{id?}");

            app.MapControllerRoute(
                name: "default",
                pattern: "{controller=Home}/{action=Index}/{id?}");

            app.Run();
        }
    }
}