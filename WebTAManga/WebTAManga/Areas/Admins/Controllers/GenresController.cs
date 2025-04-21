using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    [Authorize(Roles = "SuperAdmin, ContentManager")]

    public class GenresController : BaseController
    {
        private readonly WebMangaContext _context;
        private const int PageSize = 7;

        public GenresController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Genres
        public async Task<IActionResult> Index(string searchName, int page = 1)
        {
            var genres = from g in _context.Genres
                         select g;

            // Apply search filter
            if (!string.IsNullOrEmpty(searchName))
            {
                genres = genres.Where(g => g.Name.Contains(searchName));
            }

            // Get total items for pagination
            int totalItems = await genres.CountAsync();
            int totalPages = (int)Math.Ceiling(totalItems / (double)PageSize);

            // Apply pagination
            var pagedGenres = await genres
                .OrderBy(g => g.GenreId)
                .Skip((page - 1) * PageSize)
                .Take(PageSize)
                .ToListAsync();

            // Create view model
            var viewModel = new GenreIndexView
            {
                Genres = pagedGenres,
                CurrentPage = page,
                TotalPages = totalPages,
                SearchName = searchName
            };

            return View(viewModel);
        }

        // GET: Admins/Genres/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var genre = await _context.Genres
                .FirstOrDefaultAsync(m => m.GenreId == id);
            if (genre == null)
            {
                return NotFound();
            }

            return View(genre);
        }

        // GET: Admins/Genres/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admins/Genres/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("GenreId,Name,Title")] Genre genre)
        {
            if (ModelState.IsValid)
            {
                _context.Add(genre);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(genre);
        }

        // GET: Admins/Genres/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var genre = await _context.Genres.FindAsync(id);
            if (genre == null)
            {
                return NotFound();
            }
            return View(genre);
        }

        // POST: Admins/Genres/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("GenreId,Name,Title")] Genre genre)
        {
            if (id != genre.GenreId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(genre);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!GenreExists(genre.GenreId))
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
            return View(genre);
        }

        // GET: Admins/Genres/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var genre = await _context.Genres
                .FirstOrDefaultAsync(m => m.GenreId == id);
            if (genre == null)
            {
                return NotFound();
            }

            return View(genre);
        }

        // POST: Admins/Genres/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var genre = await _context.Genres.FindAsync(id);
            if (genre != null)
            {
                _context.Genres.Remove(genre);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool GenreExists(int id)
        {
            return _context.Genres.Any(e => e.GenreId == id);
        }
    }

    // View model for pagination and search
    public class GenreIndexView
    {
        public List<Genre> Genres { get; set; }
        public int CurrentPage { get; set; }
        public int TotalPages { get; set; }
        public string SearchName { get; set; }
    }
}