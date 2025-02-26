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
    public class LevelsController : Controller
    {
        private readonly WebMangaContext _context;

        public LevelsController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Levels
        public async Task<IActionResult> Index()
        {
            var webMangaContext = _context.Levels.Include(l => l.CategoryRank);
            return View(await webMangaContext.ToListAsync());
        }

        // GET: Admins/Levels/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var level = await _context.Levels
                .Include(l => l.CategoryRank)
                .FirstOrDefaultAsync(m => m.LevelId == id);
            if (level == null)
            {
                return NotFound();
            }

            return View(level);
        }

        // GET: Admins/Levels/Create
        public IActionResult Create()
        {
            ViewData["CategoryRankId"] = new SelectList(_context.CategoryRanks, "CategoryRankId", "CategoryRankId");
            return View();
        }

        // POST: Admins/Levels/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("LevelId,ExpRequired,CategoryRankId")] Level level)
        {
            if (ModelState.IsValid)
            {
                _context.Add(level);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["CategoryRankId"] = new SelectList(_context.CategoryRanks, "CategoryRankId", "CategoryRankId", level.CategoryRankId);
            return View(level);
        }

        // GET: Admins/Levels/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var level = await _context.Levels.FindAsync(id);
            if (level == null)
            {
                return NotFound();
            }
            ViewData["CategoryRankId"] = new SelectList(_context.CategoryRanks, "CategoryRankId", "CategoryRankId", level.CategoryRankId);
            return View(level);
        }

        // POST: Admins/Levels/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("LevelId,ExpRequired,CategoryRankId")] Level level)
        {
            if (id != level.LevelId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(level);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!LevelExists(level.LevelId))
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
            ViewData["CategoryRankId"] = new SelectList(_context.CategoryRanks, "CategoryRankId", "CategoryRankId", level.CategoryRankId);
            return View(level);
        }

        // GET: Admins/Levels/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var level = await _context.Levels
                .Include(l => l.CategoryRank)
                .FirstOrDefaultAsync(m => m.LevelId == id);
            if (level == null)
            {
                return NotFound();
            }

            return View(level);
        }

        // POST: Admins/Levels/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var level = await _context.Levels.FindAsync(id);
            if (level != null)
            {
                _context.Levels.Remove(level);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool LevelExists(int id)
        {
            return _context.Levels.Any(e => e.LevelId == id);
        }
    }
}
