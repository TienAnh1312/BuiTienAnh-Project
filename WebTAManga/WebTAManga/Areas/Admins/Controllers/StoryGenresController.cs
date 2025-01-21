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
    public class StoryGenresController : BaseController
    {
        private readonly WebMangaContext _context;

        public StoryGenresController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/StoryGenres
        public async Task<IActionResult> Index()
        {
            var webMangaContext = _context.StoryGenres.Include(s => s.Genre).Include(s => s.Story);
            return View(await webMangaContext.ToListAsync());
        }

        // GET: Admins/StoryGenres/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var storyGenre = await _context.StoryGenres
                .Include(s => s.Genre)
                .Include(s => s.Story)
                .FirstOrDefaultAsync(m => m.StoryGenreId == id);
            if (storyGenre == null)
            {
                return NotFound();
            }

            return View(storyGenre);
        }

        // GET: Admins/StoryGenres/Create
        public IActionResult Create()
        {
            ViewData["GenreId"] = new SelectList(_context.Genres, "GenreId", "Name");
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "Title");
            return View();
        }

        // POST: Admins/StoryGenres/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("StoryGenreId,StoryId,GenreId")] StoryGenre storyGenre)
        {
            if (ModelState.IsValid)
            {
                _context.Add(storyGenre);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["GenreId"] = new SelectList(_context.Genres, "GenreId", "Name", storyGenre.GenreId);
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "Title", storyGenre.StoryId);
            return View(storyGenre);
        }

        // GET: Admins/StoryGenres/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var storyGenre = await _context.StoryGenres.FindAsync(id);
            if (storyGenre == null)
            {
                return NotFound();
            }
            ViewData["GenreId"] = new SelectList(_context.Genres, "GenreId", "Name", storyGenre.GenreId);
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "Title", storyGenre.StoryId);
            return View(storyGenre);
        }

        // POST: Admins/StoryGenres/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("StoryGenreId,StoryId,GenreId")] StoryGenre storyGenre)
        {
            if (id != storyGenre.StoryGenreId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(storyGenre);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!StoryGenreExists(storyGenre.StoryGenreId))
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
            ViewData["GenreId"] = new SelectList(_context.Genres, "GenreId", "Name", storyGenre.GenreId);
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "Title", storyGenre.StoryId);
            return View(storyGenre);
        }

        // GET: Admins/StoryGenres/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var storyGenre = await _context.StoryGenres
                .Include(s => s.Genre)
                .Include(s => s.Story)
                .FirstOrDefaultAsync(m => m.StoryGenreId == id);
            if (storyGenre == null)
            {
                return NotFound();
            }

            return View(storyGenre);
        }

        // POST: Admins/StoryGenres/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var storyGenre = await _context.StoryGenres.FindAsync(id);
            if (storyGenre != null)
            {
                _context.StoryGenres.Remove(storyGenre);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool StoryGenreExists(int id)
        {
            return _context.StoryGenres.Any(e => e.StoryGenreId == id);
        }
    }
}
