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
            var webMangaContext = _context.Ranks.Include(r => r.Category);
            return View(await webMangaContext.ToListAsync());
        }

        // GET: Admins/Ranks/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var rank = await _context.Ranks
                .Include(r => r.Category)
                .FirstOrDefaultAsync(m => m.RankId == id);
            if (rank == null)
            {
                return NotFound();
            }

            return View(rank);
        }

        // GET: Admins/Ranks/Create
        public IActionResult Create()
        {
            ViewData["CategoryId"] = new SelectList(_context.RankCategories, "CategoryId", "CategoryId");
            return View();
        }

        // POST: Admins/Ranks/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("RankId,Name,MinExp,CategoryId")] Rank rank)
        {
            if (ModelState.IsValid)
            {
                _context.Add(rank);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["CategoryId"] = new SelectList(_context.RankCategories, "CategoryId", "CategoryId", rank.CategoryId);
            return View(rank);
        }

        // GET: Admins/Ranks/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var rank = await _context.Ranks.FindAsync(id);
            if (rank == null)
            {
                return NotFound();
            }
            ViewData["CategoryId"] = new SelectList(_context.RankCategories, "CategoryId", "CategoryId", rank.CategoryId);
            return View(rank);
        }

        // POST: Admins/Ranks/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("RankId,Name,MinExp,CategoryId")] Rank rank)
        {
            if (id != rank.RankId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(rank);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!RankExists(rank.RankId))
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
            ViewData["CategoryId"] = new SelectList(_context.RankCategories, "CategoryId", "CategoryId", rank.CategoryId);
            return View(rank);
        }

        // GET: Admins/Ranks/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var rank = await _context.Ranks
                .Include(r => r.Category)
                .FirstOrDefaultAsync(m => m.RankId == id);
            if (rank == null)
            {
                return NotFound();
            }

            return View(rank);
        }

        // POST: Admins/Ranks/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var rank = await _context.Ranks.FindAsync(id);
            if (rank != null)
            {
                _context.Ranks.Remove(rank);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool RankExists(int id)
        {
            return _context.Ranks.Any(e => e.RankId == id);
        }
    }
}
