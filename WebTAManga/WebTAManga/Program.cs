using Microsoft.EntityFrameworkCore;
using Net.payOS;
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

            builder.Services.AddDbContext<WebMangaContext>(options => options.UseSqlServer(connectionString));

            builder.Services.AddHttpContextAccessor();

            builder.Services.AddHttpClient();

            builder.Services.AddScoped<IEmailSender, EmailSender>();

            // Đọc cấu hình PayOS từ appsettings.json
            var payOsConfig = builder.Configuration.GetSection("PayOS");
            var clientId = payOsConfig["ClientId"];
            var apiKey = payOsConfig["ApiKey"];
            var checksumKey = payOsConfig["ChecksumKey"];

            // Khởi tạo PayOS
            var payOS = new PayOS(clientId, apiKey, checksumKey);
            builder.Services.AddSingleton(payOS);

            // C?u hình s? d?ng session
            builder.Services.AddSession(options =>
            {
                options.IdleTimeout = TimeSpan.FromMinutes(30);
                options.Cookie.HttpOnly = true;
                options.Cookie.IsEssential = true;
                options.Cookie.Name = "TADev";
            });

            // Add services to the container.
            builder.Services.AddControllersWithViews();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (!app.Environment.IsDevelopment())
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseSession();

            app.UseAuthorization();

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
