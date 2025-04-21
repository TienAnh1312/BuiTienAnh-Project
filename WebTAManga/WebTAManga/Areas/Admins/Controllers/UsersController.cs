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
    [Authorize(Roles = "SuperAdmin,UserManager")]

    public class UsersController : BaseController
    {
        private readonly WebMangaContext _context;
        private const int PageSize = 7; // Kích thước trang là 10

        public UsersController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Users
        public async Task<IActionResult> Index(string searchUsername, string searchEmail, int page = 1)
        {
            var users = from u in _context.Users
                        select u;

            // Áp dụng bộ lọc tìm kiếm
            if (!string.IsNullOrEmpty(searchUsername))
            {
                users = users.Where(u => u.Username.Contains(searchUsername));
            }

            if (!string.IsNullOrEmpty(searchEmail))
            {
                users = users.Where(u => u.Email.Contains(searchEmail));
            }

            // Lấy tổng số mục để phân trang
            int totalItems = await users.CountAsync();
            int totalPages = (int)Math.Ceiling(totalItems / (double)PageSize);

            // Áp dụng phân trang
            var pagedUsers = await users
                .OrderBy(u => u.UserId)
                .Skip((page - 1) * PageSize)
                .Take(PageSize)
                .ToListAsync();

            // Tạo view model
            var viewModel = new UserIndexView
            {
                Users = pagedUsers,
                CurrentPage = page,
                TotalPages = totalPages,
                SearchUsername = searchUsername,
                SearchEmail = searchEmail
            };

            return View(viewModel);
        }

        // GET: Admins/Users/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.Users
                .FirstOrDefaultAsync(m => m.UserId == id);
            if (user == null)
            {
                return NotFound();
            }

            return View(user);
        }

        // GET: Admins/Users/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admins/Users/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("UserId,Username,Email,Password,CreatedAt")] User user)
        {
            if (ModelState.IsValid)
            {
                _context.Add(user);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(user);
        }

        // GET: Admins/Users/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }
            return View(user);
        }

        // POST: Admins/Users/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("UserId,Username,Email,Password,CreatedAt,Coins,ExpPoints")] User user)

        {
            if (id != user.UserId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(user);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!UserExists(user.UserId))
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
            return View(user);
        }

        // GET: Admins/Users/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.Users
                .FirstOrDefaultAsync(m => m.UserId == id);
            if (user == null)
            {
                return NotFound();
            }

            return View(user);
        }

        // POST: Admins/Users/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user != null)
            {
                _context.Users.Remove(user);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool UserExists(int id)
        {
            return _context.Users.Any(e => e.UserId == id);
        }
    }
    public class UserIndexView
    {
        public List<User> Users { get; set; }
        public int CurrentPage { get; set; }
        public int TotalPages { get; set; }
        public string SearchUsername { get; set; }
        public string SearchEmail { get; set; }
    }
}
