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
    [Area("Admins")]
    public class CategoryRanksController : Controller
    {
        private readonly WebMangaContext _context;

        public CategoryRanksController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/CategoryRanks
        public async Task<IActionResult> Index()
        {
            var webMangaContext = _context.CategoryRanks.Include(c => c.Rank);
            return View(await webMangaContext.ToListAsync());
        }

        // GET: Admins/CategoryRanks/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var categoryRank = await _context.CategoryRanks
                .Include(c => c.Rank)
                .FirstOrDefaultAsync(m => m.CategoryRankId == id);
            if (categoryRank == null)
            {
                return NotFound();
            }

            return View(categoryRank);
        }

        // GET: Admins/CategoryRanks/Create
        public IActionResult Create()
        {
            ViewData["RankId"] = new SelectList(_context.Ranks, "RankId", "RankId");
            return View();
        }

        // POST: Admins/CategoryRanks/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("CategoryRankId,Name,RankId")] CategoryRank categoryRank)
        {
            if (ModelState.IsValid)
            {
                _context.Add(categoryRank);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["RankId"] = new SelectList(_context.Ranks, "RankId", "RankId", categoryRank.RankId);
            return View(categoryRank);
        }

        // GET: Admins/CategoryRanks/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var categoryRank = await _context.CategoryRanks.FindAsync(id);
            if (categoryRank == null)
            {
                return NotFound();
            }
            ViewData["RankId"] = new SelectList(_context.Ranks, "RankId", "RankId", categoryRank.RankId);
            return View(categoryRank);
        }

        // POST: Admins/CategoryRanks/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("CategoryRankId,Name,RankId")] CategoryRank categoryRank)
        {
            if (id != categoryRank.CategoryRankId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(categoryRank);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!CategoryRankExists(categoryRank.CategoryRankId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["RankId"] = new SelectList(_context.Ranks, "RankId", "RankId", categoryRank.RankId);
            return View(categoryRank);
        }

        // GET: Admins/CategoryRanks/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var categoryRank = await _context.CategoryRanks
                .Include(c => c.Rank)
                .FirstOrDefaultAsync(m => m.CategoryRankId == id);
            if (categoryRank == null)
            {
                return NotFound();
            }

            return View(categoryRank);
        }

        // POST: Admins/CategoryRanks/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var categoryRank = await _context.CategoryRanks.FindAsync(id);
            if (categoryRank != null)
            {
                _context.CategoryRanks.Remove(categoryRank);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool CategoryRankExists(int id)
        {
            return _context.CategoryRanks.Any(e => e.CategoryRankId == id);
        }
    }
}
