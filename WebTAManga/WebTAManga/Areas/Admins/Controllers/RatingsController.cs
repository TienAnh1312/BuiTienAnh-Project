using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    [Authorize(Roles = "SuperAdmin, ContentManager")]

    public class RatingsController : BaseController
    {
        private readonly WebMangaContext _context;

        public RatingsController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Ratings
        public async Task<IActionResult> Index()
        {
            var webMangaContext = _context.Ratings.Include(r => r.Story).Include(r => r.User);
            return View(await webMangaContext.ToListAsync());
        }

        // GET: Admins/Ratings/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var rating = await _context.Ratings
                .Include(r => r.Story)
                .Include(r => r.User)
                .FirstOrDefaultAsync(m => m.RatingId == id);
            if (rating == null)
            {
                return NotFound();
            }

            return View(rating);
        }

        // GET: Admins/Ratings/Create
        public IActionResult Create()
        {
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId");
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId");
            return View();
        }

        // POST: Admins/Ratings/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("RatingId,UserId,StoryId,Rating1,CreatedAt")] Rating rating)
        {
            if (ModelState.IsValid)
            {
                _context.Add(rating);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId", rating.StoryId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", rating.UserId);
            return View(rating);
        }

        // GET: Admins/Ratings/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var rating = await _context.Ratings.FindAsync(id);
            if (rating == null)
            {
                return NotFound();
            }
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId", rating.StoryId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", rating.UserId);
            return View(rating);
        }

        // POST: Admins/Ratings/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("RatingId,UserId,StoryId,Rating1,CreatedAt")] Rating rating)
        {
            if (id != rating.RatingId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(rating);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!RatingExists(rating.RatingId))
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
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId", rating.StoryId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", rating.UserId);
            return View(rating);
        }

        // GET: Admins/Ratings/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var rating = await _context.Ratings
                .Include(r => r.Story)
                .Include(r => r.User)
                .FirstOrDefaultAsync(m => m.RatingId == id);
            if (rating == null)
            {
                return NotFound();
            }

            return View(rating);
        }

        // POST: Admins/Ratings/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var rating = await _context.Ratings.FindAsync(id);
            if (rating != null)
            {
                _context.Ratings.Remove(rating);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool RatingExists(int id)
        {
            return _context.Ratings.Any(e => e.RatingId == id);
        }
    }
}
