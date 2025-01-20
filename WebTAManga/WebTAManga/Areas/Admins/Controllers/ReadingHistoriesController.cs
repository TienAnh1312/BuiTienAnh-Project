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
    
    public class ReadingHistoriesController : BaseController
    {
        private readonly WebMangaContext _context;

        public ReadingHistoriesController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/ReadingHistories
        public async Task<IActionResult> Index()
        {
            var webMangaContext = _context.ReadingHistories.Include(r => r.Chapter).Include(r => r.Story).Include(r => r.User);
            return View(await webMangaContext.ToListAsync());
        }

        // GET: Admins/ReadingHistories/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var readingHistory = await _context.ReadingHistories
                .Include(r => r.Chapter)
                .Include(r => r.Story)
                .Include(r => r.User)
                .FirstOrDefaultAsync(m => m.HistoryId == id);
            if (readingHistory == null)
            {
                return NotFound();
            }

            return View(readingHistory);
        }

        // GET: Admins/ReadingHistories/Create
        public IActionResult Create()
        {
            ViewData["ChapterId"] = new SelectList(_context.Chapters, "ChapterId", "ChapterId");
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId");
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId");
            return View();
        }

        // POST: Admins/ReadingHistories/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("HistoryId,UserId,StoryId,ChapterId,LastReadAt")] ReadingHistory readingHistory)
        {
            if (ModelState.IsValid)
            {
                _context.Add(readingHistory);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["ChapterId"] = new SelectList(_context.Chapters, "ChapterId", "ChapterId", readingHistory.ChapterId);
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId", readingHistory.StoryId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", readingHistory.UserId);
            return View(readingHistory);
        }

        // GET: Admins/ReadingHistories/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var readingHistory = await _context.ReadingHistories.FindAsync(id);
            if (readingHistory == null)
            {
                return NotFound();
            }
            ViewData["ChapterId"] = new SelectList(_context.Chapters, "ChapterId", "ChapterId", readingHistory.ChapterId);
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId", readingHistory.StoryId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", readingHistory.UserId);
            return View(readingHistory);
        }

        // POST: Admins/ReadingHistories/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("HistoryId,UserId,StoryId,ChapterId,LastReadAt")] ReadingHistory readingHistory)
        {
            if (id != readingHistory.HistoryId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(readingHistory);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ReadingHistoryExists(readingHistory.HistoryId))
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
            ViewData["ChapterId"] = new SelectList(_context.Chapters, "ChapterId", "ChapterId", readingHistory.ChapterId);
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId", readingHistory.StoryId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", readingHistory.UserId);
            return View(readingHistory);
        }

        // GET: Admins/ReadingHistories/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var readingHistory = await _context.ReadingHistories
                .Include(r => r.Chapter)
                .Include(r => r.Story)
                .Include(r => r.User)
                .FirstOrDefaultAsync(m => m.HistoryId == id);
            if (readingHistory == null)
            {
                return NotFound();
            }

            return View(readingHistory);
        }

        // POST: Admins/ReadingHistories/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var readingHistory = await _context.ReadingHistories.FindAsync(id);
            if (readingHistory != null)
            {
                _context.ReadingHistories.Remove(readingHistory);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ReadingHistoryExists(int id)
        {
            return _context.ReadingHistories.Any(e => e.HistoryId == id);
        }
    }
}
