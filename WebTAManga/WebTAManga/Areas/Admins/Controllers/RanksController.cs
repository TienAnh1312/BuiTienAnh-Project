using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    public class RanksController : BaseController
    {
        private readonly WebMangaContext _context;

        public RanksController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Ranks
        public async Task<IActionResult> Index()
        {
            return View(await _context.Ranks.ToListAsync());
        }

        // GET: Admins/Ranks/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null) return NotFound();
            var rank = await _context.Ranks.FirstOrDefaultAsync(m => m.RankId == id);
            if (rank == null) return NotFound();
            return View(rank);
        }

        // GET: Admins/Ranks/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admins/Ranks/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("RankId,Name")] Rank rank)
        {
            if (ModelState.IsValid)
            {
                _context.Add(rank);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(CategoryRanksByRank), new { id = rank.RankId });
            }
            return View(rank);
        }

        // GET: Admins/Ranks/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null) return NotFound();
            var rank = await _context.Ranks.FindAsync(id);
            if (rank == null) return NotFound();
            return View(rank);
        }

        // POST: Admins/Ranks/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("RankId,Name")] Rank rank)
        {
            if (id != rank.RankId) return NotFound();
            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(rank);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!RankExists(rank.RankId)) return NotFound();
                    else throw;
                }
                return RedirectToAction(nameof(Index));
            }
            return View(rank);
        }

        // GET: Admins/Ranks/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null) return NotFound();
            var rank = await _context.Ranks.FirstOrDefaultAsync(m => m.RankId == id);
            if (rank == null) return NotFound();
            return View(rank);
        }

        // POST: Admins/Ranks/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var rank = await _context.Ranks.FindAsync(id);
            if (rank != null) _context.Ranks.Remove(rank);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        // GET: Admins/Ranks/CategoryRanksByRank/5
        public async Task<IActionResult> CategoryRanksByRank(int? id)
        {
            if (id == null) return NotFound();
            var rank = await _context.Ranks
                .Include(r => r.CategoryRanks)
                .ThenInclude(cr => cr.Levels)
                .FirstOrDefaultAsync(m => m.RankId == id);
            if (rank == null) return NotFound();
            return View(rank);
        }

        // GET: Admins/Ranks/CreateCategoryRank/5
        public IActionResult CreateCategoryRank(int? rankId)
        {
            if (rankId == null) return NotFound();
            var rank = _context.Ranks.Find(rankId);
            if (rank == null) return NotFound();

            ViewData["RankId"] = new SelectList(_context.Ranks, "RankId", "Name", rankId);
            var model = new CategoryRank { RankId = rankId.Value, Levels = new List<Level> { new Level() } };
            return View(model);
        }

        // POST: Admins/Ranks/CreateCategoryRank
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateCategoryRank([Bind("CategoryRankId,Name,RankId,Levels")] CategoryRank categoryRank, string[] expRequired)
        {
            if (ModelState.IsValid)
            {
                // Thêm các Level từ expRequired
                categoryRank.Levels = new List<Level>();
                for (int i = 0; i < expRequired.Length; i++)
                {
                    if (!string.IsNullOrEmpty(expRequired[i]) && int.TryParse(expRequired[i], out int exp))
                    {
                        categoryRank.Levels.Add(new Level { ExpRequired = exp });
                    }
                }

                _context.Add(categoryRank);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(CategoryRanksByRank), new { id = categoryRank.RankId });
            }

            ViewData["RankId"] = new SelectList(_context.Ranks, "RankId", "Name", categoryRank.RankId);
            return View(categoryRank);
        }

        // GET: Admins/Ranks/EditCategoryRank/5
        public async Task<IActionResult> EditCategoryRank(int? id)
        {
            if (id == null) return NotFound();
            var categoryRank = await _context.CategoryRanks
                .Include(cr => cr.Levels)
                .FirstOrDefaultAsync(cr => cr.CategoryRankId == id);
            if (categoryRank == null) return NotFound();

            ViewData["RankId"] = new SelectList(_context.Ranks, "RankId", "Name", categoryRank.RankId);
            return View(categoryRank);
        }

        // POST: Admins/Ranks/EditCategoryRank/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditCategoryRank(int id, [Bind("CategoryRankId,Name,RankId")] CategoryRank categoryRank, string[] expRequired)
        {
            if (id != categoryRank.CategoryRankId) return NotFound();

            if (ModelState.IsValid)
            {
                try
                {
                    // Lấy CategoryRank hiện tại từ DB để cập nhật
                    var existingCategoryRank = await _context.CategoryRanks
                        .Include(cr => cr.Levels)
                        .FirstOrDefaultAsync(cr => cr.CategoryRankId == id);

                    if (existingCategoryRank == null) return NotFound();

                    // Cập nhật Name và RankId
                    existingCategoryRank.Name = categoryRank.Name;
                    existingCategoryRank.RankId = categoryRank.RankId;

                    // Xóa các Level cũ
                    _context.Levels.RemoveRange(existingCategoryRank.Levels);
                    existingCategoryRank.Levels.Clear();

                    // Thêm các Level mới từ expRequired
                    for (int i = 0; i < expRequired.Length; i++)
                    {
                        if (!string.IsNullOrEmpty(expRequired[i]) && int.TryParse(expRequired[i], out int exp))
                        {
                            existingCategoryRank.Levels.Add(new Level { ExpRequired = exp });
                        }
                    }

                    _context.Update(existingCategoryRank);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!CategoryRankExists(categoryRank.CategoryRankId)) return NotFound();
                    else throw;
                }
                return RedirectToAction(nameof(CategoryRanksByRank), new { id = categoryRank.RankId });
            }

            ViewData["RankId"] = new SelectList(_context.Ranks, "RankId", "Name", categoryRank.RankId);
            return View(categoryRank);
        }

        private bool RankExists(int id)
        {
            return _context.Ranks.Any(e => e.RankId == id);
        }

        private bool CategoryRankExists(int id)
        {
            return _context.CategoryRanks.Any(e => e.CategoryRankId == id);
        }
    }
}