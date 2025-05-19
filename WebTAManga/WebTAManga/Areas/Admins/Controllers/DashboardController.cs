using AngleSharp.Common;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    [Authorize]
    public class DashboardController : BaseController
    {
        private readonly WebMangaContext _context;

        public DashboardController(WebMangaContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var model = new DashboardViewModel
            {
                TotalStories = await _context.Stories.CountAsync(),
                TotalComments = await _context.Comments.CountAsync(),
                TotalRevenue = await _context.RechargeHistories
                    .Where(r => r.Status == "Completed")
                    .SumAsync(r => r.Coins) + await _context.Transactions
                    .Where(t => t.TransactionStatus == "Success")
                    .SumAsync(t => t.Coins),
                TotalGenres = await _context.StoryGenres.Select(g => g.GenreId).Distinct().CountAsync(),
                TotalUsers = await _context.Users.CountAsync(),

                RecentStories = await _context.Stories
                    .OrderByDescending(s => s.CreatedAt)
                    .Take(5)
                    .Select(s => new StoryViewModel { StoryId = s.StoryId, Title = s.Title, CreatedAt = s.CreatedAt })
                    .ToListAsync(),

                RecentAdminLogs = await _context.AdminLogs
                    .Include(l => l.Admin)
                    .OrderByDescending(l => l.CreatedAt)
                    .Take(5)
                    .Select(l => new AdminLogViewModel
                    {
                        LogId = l.LogId,
                        AdminUsername = l.Admin != null ? l.Admin.Username : "Unknown",
                        Action = l.Action,
                        CreatedAt = l.CreatedAt
                    })
                    .ToListAsync(),

                RecentTransactions = await GetRecentTransactions()
            };

            return View(model);
        }

        private async Task<List<TransactionViewModel>> GetRecentTransactions()
        {
            var transactions = await _context.Transactions
                .Include(t => t.User)
                .Where(t => t.TransactionStatus == "Success")
                .Select(t => new TransactionViewModel
                {
                    TransactionId = t.TransactionId,
                    Username = t.User != null ? t.User.Username : "Unknown",
                    Coins = t.Coins,
                    PaymentMethod = t.VnpayTransactionId != null ? "PayoS" : "MoMo",
                    CreatedAt = t.CreatedAt,
                    Source = "Transaction"
                })
                .ToListAsync();

            var recharges = await _context.RechargeHistories
                .Include(r => r.User)
                .Where(r => r.Status == "Completed")
                .Select(r => new TransactionViewModel
                {
                    TransactionId = r.RechargeId,
                    Username = r.User != null ? r.User.Username : "Unknown",
                    Coins = r.Coins,
                    PaymentMethod = r.PaymentMethod ?? (r.MomoTransactionId != null ? "MoMo" : "PayoS"),
                    CreatedAt = r.CreatedAt ?? DateTime.Now,
                    Source = "Recharge"
                })
                .ToListAsync();

            return transactions.Concat(recharges)
                .OrderByDescending(t => t.CreatedAt)
                .Take(5)
                .ToList();
        }

        [HttpGet]
        public async Task<IActionResult> GetRevenueData(string period = "month")
        {
            // Lấy dữ liệu từ Transactions
            var transactions = period == "month"
                ? await _context.Transactions
                    .Where(t => t.TransactionStatus == "Success")
                    .GroupBy(t => new { Year = t.CreatedAt.Year, Month = t.CreatedAt.Month })
                    .Select(g => new { Date = new DateTime(g.Key.Year, g.Key.Month, 1), Coins = (double)g.Sum(t => t.Coins) }) // Ép kiểu sang double
                    .ToListAsync()
                : await _context.Transactions
                    .Where(t => t.TransactionStatus == "Success")
                    .GroupBy(t => t.CreatedAt.Date)
                    .Select(g => new { Date = g.Key, Coins = (double)g.Sum(t => t.Coins) }) // Ép kiểu sang double
                    .ToListAsync();

            // Lấy dữ liệu từ RechargeHistories
            var recharges = period == "month"
                ? await _context.RechargeHistories
                    .Where(r => r.Status == "Completed" && r.CreatedAt != null)
                    .GroupBy(r => new { Year = r.CreatedAt!.Value.Year, Month = r.CreatedAt!.Value.Month })
                    .Select(g => new { Date = new DateTime(g.Key.Year, g.Key.Month, 1), Coins = g.Sum(r => r.Coins) })
                    .ToListAsync()
                : await _context.RechargeHistories
                    .Where(r => r.Status == "Completed" && r.CreatedAt != null)
                    .GroupBy(r => r.CreatedAt!.Value.Date)
                    .Select(g => new { Date = g.Key, Coins = g.Sum(r => r.Coins) })
                    .ToListAsync();

            // Kết hợp và nhóm dữ liệu
            var combined = transactions
                .Concat(recharges)
                .GroupBy(x => x.Date)
                .Select(g => new { Date = g.Key, Coins = g.Sum(x => x.Coins) })
                .OrderBy(g => g.Date)
                .Take(period == "month" ? 12 : 30)
                .ToList();

            return Json(new
            {
                labels = combined.Select(d => d.Date.ToString(period == "month" ? "MMM yyyy" : "dd MMM")),
                values = combined.Select(d => d.Coins)
            });
        }

        [HttpGet]
        public async Task<IActionResult> GetTopStoriesByViews()
        {
            var data = await _context.Stories
                .OrderByDescending(s => s.View)
                .Take(5)
                .Select(s => new { s.Title, s.View })
                .ToListAsync();

            return Json(new
            {
                labels = data.Select(s => s.Title),
                values = data.Select(s => s.View ?? 0)
            });
        }

        [HttpGet]
        public async Task<IActionResult> GetTopStoriesByComments()
        {
            var data = await _context.Comments
                .GroupBy(c => c.StoryId)
                .Select(g => new { StoryId = g.Key, CommentCount = g.Count() })
                .Join(_context.Stories, g => g.StoryId, s => s.StoryId, (g, s) => new { s.Title, g.CommentCount })
                .OrderByDescending(x => x.CommentCount)
                .Take(5)
                .ToListAsync();

            return Json(new
            {
                labels = data.Select(x => x.Title),
                values = data.Select(x => x.CommentCount)
            });
        }
    }

    public class DashboardViewModel
    {
        public int TotalStories { get; set; }
        public int TotalComments { get; set; }
        public double TotalRevenue { get; set; }
        public int TotalGenres { get; set; }
        public int TotalUsers { get; set; }
        public List<StoryViewModel> RecentStories { get; set; } = new();
        public List<AdminLogViewModel> RecentAdminLogs { get; set; } = new();
        public List<TransactionViewModel> RecentTransactions { get; set; } = new();
    }

    public class StoryViewModel
    {
        public int StoryId { get; set; }
        public string Title { get; set; }
        public DateTime? CreatedAt { get; set; }
    }

    public class AdminLogViewModel
    {
        public int LogId { get; set; }
        public string AdminUsername { get; set; }
        public string Action { get; set; }
        public DateTime? CreatedAt { get; set; }
    }

    public class TransactionViewModel
    {
        public int TransactionId { get; set; }
        public string Username { get; set; }
        public double Coins { get; set; }
        public string PaymentMethod { get; set; }
        public DateTime CreatedAt { get; set; }
        public string Source { get; set; }
    }
}