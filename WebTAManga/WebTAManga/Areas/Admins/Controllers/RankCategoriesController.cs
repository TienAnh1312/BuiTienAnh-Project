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
    
    public class RankCategoriesController : BaseController
    {
        private readonly WebMangaContext _context;

        public RankCategoriesController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/RankCategories
        public async Task<IActionResult> Index()
        {
            return View(await _context.RankCategories.ToListAsync());
        }

        // GET: Admins/RankCategories/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var rankCategory = await _context.RankCategories
                .FirstOrDefaultAsync(m => m.CategoryId == id);
            if (rankCategory == null)
            {
                return NotFound();
            }

            return View(rankCategory);
        }

        // GET: Admins/RankCategories/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admins/RankCategories/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("CategoryId,Name")] RankCategory rankCategory)
        {
            if (ModelState.IsValid)
            {
                _context.Add(rankCategory);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(rankCategory);
        }

        // GET: Admins/RankCategories/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var rankCategory = await _context.RankCategories.FindAsync(id);
            if (rankCategory == null)
            {
                return NotFound();
            }
            return View(rankCategory);
        }

        // POST: Admins/RankCategories/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("CategoryId,Name")] RankCategory rankCategory)
        {
            if (id != rankCategory.CategoryId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(rankCategory);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!RankCategoryExists(rankCategory.CategoryId))
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
            return View(rankCategory);
        }

        // GET: Admins/RankCategories/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var rankCategory = await _context.RankCategories
                .FirstOrDefaultAsync(m => m.CategoryId == id);
            if (rankCategory == null)
            {
                return NotFound();
            }

            return View(rankCategory);
        }

        // POST: Admins/RankCategories/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var rankCategory = await _context.RankCategories.FindAsync(id);
            if (rankCategory != null)
            {
                _context.RankCategories.Remove(rankCategory);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool RankCategoryExists(int id)
        {
            return _context.RankCategories.Any(e => e.CategoryId == id);
        }
    }
}
