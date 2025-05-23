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
    public class RevenueController : BaseController
    {
        private readonly WebMangaContext _context;

        public RevenueController(WebMangaContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var model = new DashboardViewModel
            {
                TotalRevenue = await _context.RechargeHistories
                    .Where(r => r.Status == "Completed")
                    .SumAsync(r => r.Coins) + await _context.Transactions
                    .Where(t => t.TransactionStatus == "Success")
                    .SumAsync(t => t.Coins)
            };
            return View(model);
        }

        [HttpGet]
        public async Task<IActionResult> GetRevenueData(string period = "month")
        {
            var transactions = period == "month"
                ? await _context.Transactions
                    .Where(t => t.TransactionStatus == "Success")
                    .GroupBy(t => new { Year = t.CreatedAt.Year, Month = t.CreatedAt.Month })
                    .Select(g => new { Date = new DateTime(g.Key.Year, g.Key.Month, 1), Coins = (double)g.Sum(t => t.Coins) })
                    .ToListAsync()
                : await _context.Transactions
                    .Where(t => t.TransactionStatus == "Success")
                    .GroupBy(t => t.CreatedAt.Date)
                    .Select(g => new { Date = g.Key, Coins = (double)g.Sum(t => t.Coins) })
                    .ToListAsync();

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
        public async Task<IActionResult> GetTopStoriesByRevenue()
        {
            var data = await _context.PurchasedChapters
                .Include(pc => pc.Chapter)
                .Where(pc => pc.Chapter != null && pc.Chapter.StoryId != null)
                .GroupBy(pc => pc.Chapter!.StoryId)
                .Select(g => new
                {
                    StoryId = g.Key,
                    Revenue = g.Sum(pc => pc.Chapter!.Coins ?? 0),
                    Title = _context.Stories.Where(s => s.StoryId == g.Key).Select(s => s.Title).FirstOrDefault() ?? "Unknown"
                })
                .OrderByDescending(x => x.Revenue)
                .Take(5)
                .ToListAsync();

            return Json(new
            {
                labels = data.Select(x => x.Title),
                values = data.Select(x => x.Revenue)
            });
        }

        [HttpGet]
        public async Task<IActionResult> GetRevenueAndViewsComparison()
        {
            var revenueData = await _context.PurchasedChapters
                .Include(pc => pc.Chapter)
                .Where(pc => pc.Chapter != null && pc.Chapter.StoryId != null)
                .GroupBy(pc => pc.Chapter!.StoryId)
                .Select(g => new
                {
                    StoryId = g.Key,
                    Revenue = g.Sum(pc => pc.Chapter!.Coins ?? 0),
                    Title = _context.Stories.Where(s => s.StoryId == g.Key).Select(s => s.Title).FirstOrDefault() ?? "Unknown"
                })
                .OrderByDescending(x => x.Revenue)
                .Take(5)
                .ToListAsync();

            var viewData = await _context.ReadingHistories
                .Where(rh => rh.StoryId != null)
                .GroupBy(rh => rh.StoryId)
                .Select(g => new
                {
                    StoryId = g.Key,
                    ViewCount = g.Count(),
                    Title = _context.Stories.Where(s => s.StoryId == g.Key).Select(s => s.Title).FirstOrDefault() ?? "Unknown"
                })
                .ToListAsync();

            var combined = revenueData
                .GroupJoin(viewData,
                    revenue => revenue.StoryId,
                    view => view.StoryId,
                    (revenue, views) => new
                    {
                        revenue.Title,
                        Revenue = revenue.Revenue,
                        Views = views.FirstOrDefault()?.ViewCount ?? 0
                    })
                .OrderByDescending(x => x.Revenue)
                .Take(5)
                .ToList();

            return Json(new
            {
                labels = combined.Select(x => x.Title),
                revenueValues = combined.Select(x => x.Revenue),
                viewValues = combined.Select(x => x.Views)
            });
        }
    }
}