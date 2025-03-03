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
    
    public class ChaptersController : BaseController
    {
        private readonly WebMangaContext _context;

        public ChaptersController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Chapters
        public async Task<IActionResult> Index(int? storyId)
        {
            if (storyId == null)
            {
                return NotFound();
            }

            var chapters = await _context.Chapters
                .Include(c => c.Story)
                .Where(c => c.StoryId == storyId)
                .ToListAsync();

            var story = await _context.Stories.FirstOrDefaultAsync(s => s.StoryId == storyId);
            if (story == null)
            {
                return NotFound();
            }

            ViewBag.StoryId = storyId;
            ViewBag.StoryTitle = story.Title; // Truyền tiêu đề để hiển thị trong view
            return View(chapters);
        }

        // GET: Admins/Chapters/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chapter = await _context.Chapters
                .Include(c => c.Story)
                .FirstOrDefaultAsync(m => m.ChapterId == id);
            if (chapter == null)
            {
                return NotFound();
            }

            return View(chapter);
        }

        // GET: Admins/Chapters/Create
        public IActionResult Create()
        {
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "Title");
            return View();  
        }

        // POST: Admins/Chapters/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ChapterId,StoryId,ChapterTitle,Content,CreatedAt,Coins,IsLocked")] Chapter chapter)
        {
            if (ModelState.IsValid)
            {
                chapter.CreatedAt = DateTime.Now; // Tự động đặt CreatedAt
                _context.Add(chapter);
                await _context.SaveChangesAsync();

                // Chuyển hướng về action Edit của StoriesController với StoryId
                return RedirectToAction("Edit", "Stories", new { id = chapter.StoryId, area = "Admins" });
            }
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "Title", chapter.StoryId);
            return View(chapter);
        }

        // GET: Admins/Chapters/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chapter = await _context.Chapters
                .Include(c => c.Story) // Load story của chapter đó
                .FirstOrDefaultAsync(m => m.ChapterId == id);

            if (chapter == null)
            {
                return NotFound();
            }

            // Chỉ load story của chapter này
            ViewData["StoryId"] = new SelectList(new List<Story> { chapter.Story }, "StoryId", "Title");

            return View(chapter);
        }


        // POST: Admins/Chapters/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ChapterId,StoryId,ChapterTitle,Content,CreatedAt,Coins,IsLocked")] Chapter chapter)
        {
            if (id != chapter.ChapterId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(chapter);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ChapterExists(chapter.ChapterId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }

                // Chuyển hướng về action Edit của StoriesController với StoryId
                return RedirectToAction("Edit", "Stories", new { id = chapter.StoryId, area = "Admins" });
            }
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "Title", chapter.StoryId);
            return View(chapter);
        }

        // GET: Admins/Chapters/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var chapter = await _context.Chapters
                .Include(c => c.Story)
                .FirstOrDefaultAsync(m => m.ChapterId == id);
            if (chapter == null)
            {
                return NotFound();
            }

            return View(chapter);
        }

        // POST: Admins/Chapters/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var chapter = await _context.Chapters.FindAsync(id);
            if (chapter != null)
            {
                _context.Chapters.Remove(chapter);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ChapterExists(int id)
        {
            return _context.Chapters.Any(e => e.ChapterId == id);
        }
    }
}
