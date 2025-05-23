using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Areas.Admins.Filters;
using WebTAManga.Areas.Admins.Models;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    [Authorize(Roles = "SuperAdmin,Admin")]
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
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var admins = from a in _context.Admins select a;

            if (currentAdmin.IsDepartmentHead == true)
            {
                admins = admins.Where(a => a.ManagerId == currentAdminId);
            }
            else if (currentAdmin.RoleNavigation?.RoleName == "Admin")
            {
                admins = admins.Where(a => a.RoleNavigation.RoleName != "SuperAdmin" && a.RoleNavigation.RoleName != "Admin");
            }

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
                .Include(a => a.Manager)
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

            ViewBag.CanAssignPermissions = currentAdmin.RoleNavigation?.RoleName == "SuperAdmin" ||
                                          currentAdmin.RoleNavigation?.RoleName == "Admin" ||
                                          currentAdmin.IsDepartmentHead == true;

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
                .Include(a => a.Manager)
                .FirstOrDefaultAsync(m => m.AdminId == id);
            if (admin == null)
            {
                return NotFound();
            }

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Details", admin);
            }
            return View(admin);
        }

        // GET: Admins/Admins/Create
        public async Task<IActionResult> Create()
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            ViewBag.RoleList = new SelectList(_context.Roles, "RoleId", "RoleName");
            ViewBag.ManagerList = new SelectList(_context.Admins.Where(a => a.IsDepartmentHead == true), "AdminId", "Username");

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Create");
            }
            return View();
        }

        // POST: Admins/Admins/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("AdminId,Username,Email,Password,RoleId,CreatedAt,ManagerId,IsDepartmentHead")] Admin admin, List<string> selectedModules)
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            if (ModelState.IsValid)
            {
                admin.Password = BCrypt.Net.BCrypt.HashPassword(admin.Password);
                admin.CreatedAt = DateTime.Now;
                _context.Add(admin);
                await _context.SaveChangesAsync();

                if (selectedModules?.Any() == true)
                {
                    foreach (var module in selectedModules)
                    {
                        var permission = new ManagerPermission
                        {
                            AdminId = admin.AdminId,
                            Module = module,
                            CanView = true,
                            CanEdit = true,
                            CanCreate = true,
                            CanDelete = true,
                            AssignedBy = currentAdminId,
                            AssignedAt = DateTime.Now
                        };
                        _context.ManagerPermissions.Add(permission);
                    }
                    await _context.SaveChangesAsync();
                }

                var role = await _context.Roles.FindAsync(admin.RoleId);
                if (role?.RoleName == "TaskAssigner")
                {
                    var permission = new ManagerPermission
                    {
                        AdminId = admin.AdminId,
                        Module = "TaskAssignment",
                        CanView = true,
                        CanEdit = true,
                        CanCreate = true,
                        CanDelete = true,
                        AssignedBy = currentAdminId,
                        AssignedAt = DateTime.Now
                    };
                    _context.ManagerPermissions.Add(permission);
                    await _context.SaveChangesAsync();
                }

                if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                {
                    return Json(new { success = true, message = "Admin created successfully!" });
                }
                TempData["Success"] = "Admin created successfully!";
                return RedirectToAction(nameof(Index));
            }

            ViewBag.RoleList = new SelectList(_context.Roles, "RoleId", "RoleName");
            ViewBag.ManagerList = new SelectList(_context.Admins.Where(a => a.IsDepartmentHead == true), "AdminId", "Username");
            ViewBag.Modules = PermissionModules.AllModules;

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Create", admin);
            }
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
            ViewBag.ManagerList = new SelectList(_context.Admins.Where(a => a.IsDepartmentHead == true), "AdminId", "Username", admin.ManagerId);

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Edit", admin);
            }
            return View(admin);
        }

        // POST: Admins/Admins/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("AdminId,Username,Email,Password,RoleId,CreatedAt,ManagerId,IsDepartmentHead")] Admin admin)
        {
            if (id != admin.AdminId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    if (!string.IsNullOrEmpty(admin.Password))
                    {
                        admin.Password = BCrypt.Net.BCrypt.HashPassword(admin.Password);
                    }
                    else
                    {
                        var existingAdmin = await _context.Admins.AsNoTracking().FirstOrDefaultAsync(a => a.AdminId == id);
                        admin.Password = existingAdmin?.Password;
                    }

                    _context.Update(admin);
                    await _context.SaveChangesAsync();

                    if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                    {
                        return Json(new { success = true, message = "Admin updated successfully!" });
                    }
                    TempData["Success"] = "Admin updated successfully!";
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
            ViewBag.ManagerList = new SelectList(_context.Admins.Where(a => a.IsDepartmentHead == true), "AdminId", "Username", admin.ManagerId);

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Edit", admin);
            }
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

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Delete", admin);
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
                await _context.SaveChangesAsync();

                if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                {
                    return Json(new { success = true, message = "Admin deleted successfully!" });
                }
                TempData["Success"] = "Admin deleted successfully!";
            }
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