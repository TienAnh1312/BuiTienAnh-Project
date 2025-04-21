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
    [Authorize(Roles = "SuperAdmin")]
    public class AdminsController : BaseController
    {
        private readonly WebMangaContext _context;
        private const int PageSize = 7;

        public AdminsController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Admins
        public async Task<IActionResult> Index(string searchUsername, string searchEmail, int page = 1)
        {
            var admins = from a in _context.Admins
                         select a;

            if (!string.IsNullOrEmpty(searchUsername))
            {
                admins = admins.Where(a => a.Username.Contains(searchUsername));
            }

            if (!string.IsNullOrEmpty(searchEmail))
            {
                admins = admins.Where(a => a.Email.Contains(searchEmail));
            }

            int totalItems = await admins.CountAsync();
            int totalPages = (int)Math.Ceiling(totalItems / (double)PageSize);

            var pagedAdmins = await admins
                .Include(a => a.RoleNavigation) 
                .OrderBy(a => a.AdminId)
                .Skip((page - 1) * PageSize)
                .Take(PageSize)
                .ToListAsync();

            var viewModel = new AdminIndexView
            {
                Admins = pagedAdmins,
                CurrentPage = page,
                TotalPages = totalPages,
                SearchUsername = searchUsername,
                SearchEmail = searchEmail
            };

            return View(viewModel);
        }

        // GET: Admins/Admins/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var admin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(m => m.AdminId == id);
            if (admin == null)
            {
                return NotFound();
            }

            return View(admin);
        }

        // GET: Admins/Admins/Create
        public IActionResult Create()
        {
            ViewBag.RoleList = new SelectList(_context.Roles, "RoleId", "RoleName");
            return View();
        }

        // POST: Admins/Admins/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("AdminId,Username,Email,Password,RoleId,CreatedAt")] Admin admin)
        {
            if (ModelState.IsValid)
            {
                admin.CreatedAt = DateTime.Now; 
                _context.Add(admin);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewBag.RoleList = new SelectList(_context.Roles, "RoleId", "RoleName");
            return View(admin);
        }

        // GET: Admins/Admins/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var admin = await _context.Admins.FindAsync(id);
            if (admin == null)
            {
                return NotFound();
            }
            ViewBag.RoleList = new SelectList(_context.Roles, "RoleId", "RoleName", admin.RoleId);
            return View(admin);
        }

        // POST: Admins/Admins/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("AdminId,Username,Email,Password,RoleId,CreatedAt")] Admin admin)
        {
            if (id != admin.AdminId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(admin);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!AdminExists(admin.AdminId))
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
            ViewBag.RoleList = new SelectList(_context.Roles, "RoleId", "RoleName", admin.RoleId);
            return View(admin);
        }

        // GET: Admins/Admins/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var admin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(m => m.AdminId == id);
            if (admin == null)
            {
                return NotFound();
            }

            return View(admin);
        }

        // POST: Admins/Admins/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var admin = await _context.Admins.FindAsync(id);
            if (admin != null)
            {
                _context.Admins.Remove(admin);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool AdminExists(int id)
        {
            return _context.Admins.Any(e => e.AdminId == id);
        }
    }

    public class AdminIndexView
    {
        public List<Admin> Admins { get; set; }
        public int CurrentPage { get; set; }
        public int TotalPages { get; set; }
        public string SearchUsername { get; set; }
        public string SearchEmail { get; set; }
    }
}