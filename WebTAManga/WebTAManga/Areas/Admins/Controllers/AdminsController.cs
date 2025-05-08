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

        // GET: Admins/Admins/ManageGroups
        [PermissionAuthorize("GroupManagement", "View")]
        public async Task<IActionResult> ManageGroups()
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var viewModel = new GroupManagement();

            viewModel.Roles = await _context.Roles
                .Select(r => new Role { RoleId = r.RoleId, RoleName = r.RoleName })
                .ToListAsync();

            viewModel.Managers = await _context.Admins
                .Where(a => a.IsDepartmentHead == true)
                .Select(a => new Admin { AdminId = a.AdminId, Username = a.Username, RoleId = a.RoleId, IsDepartmentHead = a.IsDepartmentHead })
                .ToListAsync();

            viewModel.Admins = await _context.Admins
                .Include(a => a.RoleNavigation)
                .Include(a => a.Manager)
                .Select(a => new Admin { AdminId = a.AdminId, Username = a.Username, Email = a.Email, ManagerId = a.ManagerId, RoleId = a.RoleId, RoleNavigation = a.RoleNavigation, IsDepartmentHead = a.IsDepartmentHead })
                .ToListAsync();

            if (currentAdmin.IsDepartmentHead == true)
            {
                viewModel.Roles = viewModel.Roles
                    .Where(r => r.RoleId == currentAdmin.RoleId)
                    .ToList();
                viewModel.Managers = viewModel.Managers
                    .Where(m => m.AdminId == currentAdminId)
                    .ToList();
                viewModel.Admins = viewModel.Admins
                    .Where(a => a.ManagerId == currentAdminId || a.AdminId == currentAdminId)
                    .ToList();
            }

            viewModel.RoleList = new SelectList(viewModel.Roles, "RoleId", "RoleName");
            viewModel.ManagerList = new SelectList(viewModel.Managers, "AdminId", "Username");

            return View(viewModel);
        }

        // GET: Admins/Admins/CreateGroup
        [PermissionAuthorize("GroupManagement", "Create")]
        public async Task<IActionResult> CreateGroup()
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var viewModel = new GroupManagement
            {
                Roles = await _context.Roles.ToListAsync(),
                Admins = await _context.Admins
                    .Where(a => a.IsDepartmentHead != true && a.RoleNavigation.RoleName != "SuperAdmin" && a.RoleNavigation.RoleName != "Admin")
                    .ToListAsync(),
                RoleList = new SelectList(_context.Roles, "RoleId", "RoleName")
            };

            if (currentAdmin.IsDepartmentHead == true)
            {
                viewModel.Roles = viewModel.Roles.Where(r => r.RoleId == currentAdmin.RoleId).ToList();
                viewModel.Admins = viewModel.Admins.Where(a => a.AdminId == currentAdminId).ToList();
            }

            return View(viewModel);
        }

        // POST: Admins/Admins/CreateGroup
        [HttpPost]
        [ValidateAntiForgeryToken]
        [PermissionAuthorize("GroupManagement", "Create")]
        public async Task<IActionResult> CreateGroup(int managerId, int roleId)
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập lại." });
            }

            var manager = await _context.Admins.FindAsync(managerId);
            if (manager == null)
            {
                return Json(new { success = false, message = "Admin không tồn tại." });
            }

            if (currentAdmin.IsDepartmentHead == true && managerId != currentAdminId)
            {
                return Json(new { success = false, message = "Bạn chỉ có thể chỉ định chính mình làm trưởng nhóm." });
            }

            manager.IsDepartmentHead = true;
            manager.RoleId = roleId;
            _context.Update(manager);

            var role = await _context.Roles.FindAsync(roleId);

            await _context.SaveChangesAsync();
            return Json(new { success = true, message = "Tạo nhóm thành công!" });
        }

        // GET: Admins/Admins/AddMemberToGroup
        [PermissionAuthorize("GroupManagement", "Edit")]
        public async Task<IActionResult> AddMemberToGroup(int managerId)
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var manager = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == managerId);

            if (manager == null || manager.IsDepartmentHead != true)
            {
                return NotFound();
            }

            if (currentAdmin.IsDepartmentHead == true && managerId != currentAdminId)
            {
                return Forbid();
            }

            var viewModel = new GroupManagement
            {
                Managers = new List<Admin> { manager },
                Admins = await _context.Admins
                    .Where(a => a.ManagerId == null && a.AdminId != managerId && a.IsDepartmentHead != true)
                    .ToListAsync(),
                ManagerList = new SelectList(new List<Admin> { manager }, "AdminId", "Username")
            };

            return View(viewModel);
        }

        // POST: Admins/Admins/AddMemberToGroup
        [HttpPost]
        [ValidateAntiForgeryToken]
        [PermissionAuthorize("GroupManagement", "Edit")]
        public async Task<IActionResult> AddMemberToGroup(int managerId, int adminId)
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập lại." });
            }

            var manager = await _context.Admins.FirstOrDefaultAsync(a => a.AdminId == managerId);
            if (manager == null || manager.IsDepartmentHead != true)
            {
                return Json(new { success = false, message = "Trưởng nhóm không tồn tại." });
            }

            if (currentAdmin.IsDepartmentHead == true && managerId != currentAdminId)
            {
                return Json(new { success = false, message = "Bạn không có quyền thêm thành viên vào nhóm này." });
            }

            var admin = await _context.Admins.FirstOrDefaultAsync(a => a.AdminId == adminId);
            if (admin == null)
            {
                return Json(new { success = false, message = "Admin không tồn tại." });
            }

            admin.ManagerId = managerId;
            _context.Update(admin);

            await _context.SaveChangesAsync();
            return Json(new { success = true, message = "Thêm thành viên thành công!" });
        }

        // GET: Admins/Admins/GetManagersForRole
        [HttpGet]
        [PermissionAuthorize("GroupManagement", "View")]
        public async Task<IActionResult> GetManagersForRole(int roleId)
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập lại." });
            }

            var managers = await _context.Admins
                .Where(a => a.RoleId == roleId && a.IsDepartmentHead == true)
                .Select(a => new { adminId = a.AdminId, username = a.Username })
                .ToListAsync();

            if (currentAdmin.IsDepartmentHead == true)
            {
                managers = managers.Where(m => m.adminId == currentAdminId).ToList();
            }

            return Json(managers);
        }

        // GET: Admins/Admins/AssignPermissions/5
        [PermissionAuthorize("GroupManagement", "Edit")]
        public async Task<IActionResult> AssignPermissions(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var admin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == id);
            if (admin == null)
            {
                return NotFound();
            }

            if (currentAdmin.IsDepartmentHead == true && admin.ManagerId != currentAdminId)
            {
                return Forbid();
            }

            List<string> modules = new List<string>();
            if (admin.RoleNavigation?.RoleName == "ContentManager")
                modules = PermissionModules.ContentManagerModules;
            else if (admin.RoleNavigation?.RoleName == "UserManager")
                modules = PermissionModules.UserManagerModules;
            else if (admin.RoleNavigation?.RoleName == "FinanceManager")
                modules = PermissionModules.UserManagerModules;
            else if (admin.RoleNavigation?.RoleName == "CommentModerator")
                modules = PermissionModules.CommentModeratorModules;
            else if (admin.RoleNavigation?.RoleName == "ReporterHandler")
                modules = PermissionModules.ReporterHandlerModules;
            else
            {
                return Forbid();
            }

            var permissions = await _context.ManagerPermissions
                .Where(p => p.AdminId == id)
                .ToListAsync();

            ViewData["Admin"] = admin;
            ViewData["Modules"] = modules;
            ViewData["Permissions"] = permissions;

            return View();
        }

        // POST: Admins/Admins/AssignPermissions
        [HttpPost]
        [ValidateAntiForgeryToken]
        [PermissionAuthorize("GroupManagement", "Edit")]
        public async Task<IActionResult> AssignPermissions(int id, [FromForm] IFormCollection form)
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var admin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == id);
            if (admin == null)
            {
                return NotFound();
            }

            if (currentAdmin.IsDepartmentHead == true && admin.ManagerId != currentAdminId)
            {
                return Forbid();
            }

            List<string> modules = new List<string>();
            if (admin.RoleNavigation?.RoleName == "ContentManager")
                modules = PermissionModules.ContentManagerModules;
            else if (admin.RoleNavigation?.RoleName == "UserManager")
                modules = PermissionModules.UserManagerModules;
            else if (admin.RoleNavigation?.RoleName == "FinanceManager")
                modules = PermissionModules.UserManagerModules;
            else if (admin.RoleNavigation?.RoleName == "CommentModerator")
                modules = PermissionModules.CommentModeratorModules;
            else if (admin.RoleNavigation?.RoleName == "ReporterHandler")
                modules = PermissionModules.ReporterHandlerModules;
            else
            {
                return Forbid();
            }

            var existingPermissions = await _context.ManagerPermissions
                .Where(p => p.AdminId == id)
                .ToListAsync();

            var selectedModules = form["selectedModules"].ToList();
            foreach (var permission in existingPermissions)
            {
                if (!selectedModules.Contains(permission.Module))
                {
                    _context.ManagerPermissions.Remove(permission);
                }
            }

            foreach (var module in modules)
            {
                if (selectedModules.Contains(module))
                {
                    var permission = existingPermissions.FirstOrDefault(p => p.Module == module);
                    if (permission == null)
                    {
                        permission = new ManagerPermission
                        {
                            AdminId = id,
                            Module = module,
                            AssignedBy = currentAdminId,
                            AssignedAt = DateTime.Now
                        };
                        _context.ManagerPermissions.Add(permission);
                    }

                    permission.CanView = form[$"permissions[{module}].CanView"].FirstOrDefault()?.ToLower() == "true";
                    permission.CanCreate = form[$"permissions[{module}].CanCreate"].FirstOrDefault()?.ToLower() == "true";
                    permission.CanEdit = form[$"permissions[{module}].CanEdit"].FirstOrDefault()?.ToLower() == "true";
                    permission.CanDelete = form[$"permissions[{module}].CanDelete"].FirstOrDefault()?.ToLower() == "true";
                }
            }


            await _context.SaveChangesAsync();
            TempData["Success"] = "Cập nhật quyền thành công!";
            return RedirectToAction(nameof(ManageGroups));
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