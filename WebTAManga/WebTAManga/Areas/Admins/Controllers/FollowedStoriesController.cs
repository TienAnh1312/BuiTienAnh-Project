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
    
    public class FollowedStoriesController : BaseController
    {
        private readonly WebMangaContext _context;

        public FollowedStoriesController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/FollowedStories
        public async Task<IActionResult> Index()
        {
            var webMangaContext = _context.FollowedStories.Include(f => f.Story).Include(f => f.User);
            return View(await webMangaContext.ToListAsync());
        }

        // GET: Admins/FollowedStories/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var followedStory = await _context.FollowedStories
                .Include(f => f.Story)
                .Include(f => f.User)
                .FirstOrDefaultAsync(m => m.FollowId == id);
            if (followedStory == null)
            {
                return NotFound();
            }

            return View(followedStory);
        }

        // GET: Admins/FollowedStories/Create
        public IActionResult Create()
        {
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId");
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId");
            return View();
        }

        // POST: Admins/FollowedStories/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("FollowId,UserId,StoryId,FollowedAt")] FollowedStory followedStory)
        {
            if (ModelState.IsValid)
            {
                _context.Add(followedStory);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId", followedStory.StoryId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", followedStory.UserId);
            return View(followedStory);
        }

        // GET: Admins/FollowedStories/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var followedStory = await _context.FollowedStories.FindAsync(id);
            if (followedStory == null)
            {
                return NotFound();
            }
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId", followedStory.StoryId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", followedStory.UserId);
            return View(followedStory);
        }

        // POST: Admins/FollowedStories/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("FollowId,UserId,StoryId,FollowedAt")] FollowedStory followedStory)
        {
            if (id != followedStory.FollowId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(followedStory);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!FollowedStoryExists(followedStory.FollowId))
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
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId", followedStory.StoryId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", followedStory.UserId);
            return View(followedStory);
        }

        // GET: Admins/FollowedStories/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var followedStory = await _context.FollowedStories
                .Include(f => f.Story)
                .Include(f => f.User)
                .FirstOrDefaultAsync(m => m.FollowId == id);
            if (followedStory == null)
            {
                return NotFound();
            }

            return View(followedStory);
        }

        // POST: Admins/FollowedStories/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var followedStory = await _context.FollowedStories.FindAsync(id);
            if (followedStory != null)
            {
                _context.FollowedStories.Remove(followedStory);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool FollowedStoryExists(int id)
        {
            return _context.FollowedStories.Any(e => e.FollowId == id);
        }
    }
}
