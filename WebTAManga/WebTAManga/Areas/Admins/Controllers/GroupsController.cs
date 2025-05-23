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
    [Authorize]
    public class GroupsController : BaseController
    {
        private readonly WebMangaContext _context;

        public GroupsController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Groups/ManageGroups
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

            var isSuperAdminOrAdmin = currentAdmin.RoleNavigation?.RoleName is "SuperAdmin" or "Admin";
            var isDepartmentHead = currentAdmin.IsDepartmentHead == true && currentAdmin.ManagerId == null; // Chỉ trưởng nhóm
            var isGroupMember = currentAdmin.ManagerId != null; // Là thành viên trong nhóm

            if (!isSuperAdminOrAdmin && !isDepartmentHead && !isGroupMember)
            {
                return Json(new { success = false, message = "Bạn không có quyền xem danh sách nhóm." });
            }

            var viewModel = new GroupManagement
            {
                Roles = await _context.Roles
                    .Where(r => r.RoleName != "SuperAdmin")
                    .Select(r => new Role { RoleId = r.RoleId, RoleName = r.RoleName })
                    .ToListAsync(),
                Managers = await _context.Admins
                    .Include(a => a.RoleNavigation)
                    .Where(a => a.IsDepartmentHead == true && a.RoleNavigation.RoleName != "SuperAdmin")
                    .Select(a => new Admin { AdminId = a.AdminId, Username = a.Username, RoleId = a.RoleId, IsDepartmentHead = a.IsDepartmentHead })
                    .ToListAsync(),
                Admins = await _context.Admins
                    .Include(a => a.RoleNavigation)
                    .Include(a => a.Manager)
                    .Where(a => a.RoleNavigation.RoleName != "SuperAdmin")
                    .Select(a => new Admin { AdminId = a.AdminId, Username = a.Username, Email = a.Email, ManagerId = a.ManagerId, RoleId = a.RoleId, RoleNavigation = a.RoleNavigation, IsDepartmentHead = a.IsDepartmentHead })
                    .ToListAsync(),
                RoleList = new SelectList(
                    await _context.Roles
                        .Where(r => r.RoleName != "SuperAdmin")
                        .ToListAsync(),
                    "RoleId",
                    "RoleName"
                ),
                ManagerList = new SelectList(
                    await _context.Admins
                        .Include(a => a.RoleNavigation)
                        .Where(a => a.ManagerId == null && a.IsDepartmentHead != true && a.RoleNavigation.RoleName != "SuperAdmin")
                        .ToListAsync(),
                    "AdminId",
                    "Username"
                )
            };

            if (isDepartmentHead)
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
                viewModel.RoleList = new SelectList(
                    viewModel.Roles,
                    "RoleId",
                    "RoleName",
                    currentAdmin.RoleId
                );
                viewModel.ManagerList = new SelectList(
                    viewModel.Managers,
                    "AdminId",
                    "Username"
                );
            }
            else if (isGroupMember)
            {
                var managerId = currentAdmin.ManagerId.Value;
                var manager = await _context.Admins
                    .Include(a => a.RoleNavigation)
                    .FirstOrDefaultAsync(a => a.AdminId == managerId);

                if (manager == null)
                {
                    return Json(new { success = false, message = "Nhóm của bạn không tồn tại." });
                }

                viewModel.Roles = viewModel.Roles
                    .Where(r => r.RoleId == manager.RoleId)
                    .ToList();
                viewModel.Managers = viewModel.Managers
                    .Where(m => m.AdminId == managerId)
                    .ToList();
                viewModel.Admins = viewModel.Admins
                    .Where(a => a.ManagerId == managerId || a.AdminId == currentAdminId)
                    .ToList();
                viewModel.RoleList = new SelectList(
                    viewModel.Roles,
                    "RoleId",
                    "RoleName",
                    manager.RoleId
                );
                viewModel.ManagerList = new SelectList(
                    viewModel.Managers,
                    "AdminId",
                    "Username"
                );
            }

            return View(viewModel);
        }

        // GET: Admins/Groups/ViewGroupsByRole
        public async Task<IActionResult> ViewGroupsByRole(int roleId)
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var isSuperAdminOrAdmin = currentAdmin.RoleNavigation?.RoleName is "SuperAdmin" or "Admin";
            var isDepartmentHead = currentAdmin.IsDepartmentHead == true && currentAdmin.ManagerId == null;
            var isGroupMember = currentAdmin.ManagerId != null;

            if (!isSuperAdminOrAdmin && !isDepartmentHead && !isGroupMember)
            {
                return Json(new { success = false, message = "Bạn không có quyền xem nhóm theo vai trò." });
            }

            var role = await _context.Roles
                .FirstOrDefaultAsync(r => r.RoleId == roleId && r.RoleName != "SuperAdmin");

            if (role == null)
            {
                return Json(new { success = false, message = "Vai trò không tồn tại hoặc không hợp lệ." });
            }

            var managers = await _context.Admins
                .Where(a => a.RoleId == roleId && a.IsDepartmentHead == true && a.RoleNavigation.RoleName != "SuperAdmin")
                .Select(a => new Admin { AdminId = a.AdminId, Username = a.Username, RoleId = a.RoleId, IsDepartmentHead = a.IsDepartmentHead })
                .ToListAsync();

            var viewModel = new GroupManagement
            {
                Roles = new List<Role> { new Role { RoleId = role.RoleId, RoleName = role.RoleName } },
                Managers = managers,
                Admins = await _context.Admins
                    .Include(a => a.RoleNavigation)
                    .Include(a => a.Manager)
                    .Where(a => a.ManagerId != null && a.RoleNavigation.RoleName != "SuperAdmin")
                    .Select(a => new Admin { AdminId = a.AdminId, Username = a.Username, Email = a.Email, ManagerId = a.ManagerId, RoleId = a.RoleId, RoleNavigation = a.RoleNavigation, IsDepartmentHead = a.IsDepartmentHead })
                    .ToListAsync(),
                RoleList = new SelectList(
                    new List<Role> { new Role { RoleId = role.RoleId, RoleName = role.RoleName } },
                    "RoleId",
                    "RoleName"
                ),
                ManagerList = new SelectList(
                    managers,
                    "AdminId",
                    "Username"
                )
            };

            if (isDepartmentHead)
            {
                viewModel.Managers = viewModel.Managers
                    .Where(m => m.AdminId == currentAdminId)
                    .ToList();
                viewModel.Admins = viewModel.Admins
                    .Where(a => a.ManagerId == currentAdminId)
                    .ToList();
                viewModel.ManagerList = new SelectList(
                    viewModel.Managers,
                    "AdminId",
                    "Username"
                );
            }
            else if (isGroupMember)
            {
                var managerId = currentAdmin.ManagerId.Value;
                var manager = await _context.Admins
                    .Include(a => a.RoleNavigation)
                    .FirstOrDefaultAsync(a => a.AdminId == managerId);

                if (manager == null || manager.RoleId != roleId)
                {
                    return Json(new { success = false, message = "Bạn chỉ có thể xem nhóm của mình." });
                }

                viewModel.Managers = viewModel.Managers
                    .Where(m => m.AdminId == managerId)
                    .ToList();
                viewModel.Admins = viewModel.Admins
                    .Where(a => a.ManagerId == managerId)
                    .ToList();
                viewModel.ManagerList = new SelectList(
                    viewModel.Managers,
                    "AdminId",
                    "Username"
                );
            }

            return View(viewModel);
        }

        // GET: Admins/Groups/ViewMembersByGroup
        public async Task<IActionResult> ViewMembersByGroup(int managerId)
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var isSuperAdminOrAdmin = currentAdmin.RoleNavigation?.RoleName is "SuperAdmin" or "Admin";
            var isDepartmentHead = (currentAdmin.IsDepartmentHead ?? false) && currentAdmin.ManagerId == null;
            var isGroupMember = currentAdmin.ManagerId != null;

            if (!isSuperAdminOrAdmin && !isDepartmentHead && !isGroupMember)
            {
                return Json(new { success = false, message = "Bạn không có quyền xem thành viên của nhóm." });
            }

            var manager = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == managerId && a.IsDepartmentHead == true && a.RoleNavigation.RoleName != "SuperAdmin");

            if (manager == null)
            {
                return Json(new { success = false, message = "Nhóm không tồn tại hoặc không hợp lệ." });
            }

            if (isDepartmentHead && managerId != currentAdminId)
            {
                return Json(new { success = false, message = "Bạn chỉ có thể xem thành viên của nhóm mình." });
            }

            if (isGroupMember && currentAdmin.ManagerId != managerId)
            {
                return Json(new { success = false, message = "Bạn chỉ có thể xem thành viên của nhóm mình." });
            }

            var viewModel = new GroupManagement
            {
                Roles = await _context.Roles
                    .Where(r => r.RoleId == manager.RoleId)
                    .Select(r => new Role { RoleId = r.RoleId, RoleName = r.RoleName })
                    .ToListAsync(),
                Managers = new List<Admin> { new Admin { AdminId = manager.AdminId, Username = manager.Username, RoleId = manager.RoleId, RoleNavigation = manager.RoleNavigation, IsDepartmentHead = manager.IsDepartmentHead } },
                Admins = await _context.Admins
                    .Include(a => a.RoleNavigation)
                    .Where(a => a.ManagerId == managerId && a.RoleNavigation.RoleName != "SuperAdmin")
                    .Select(a => new Admin { AdminId = a.AdminId, Username = a.Username, Email = a.Email, ManagerId = a.ManagerId, RoleId = a.RoleId, RoleNavigation = a.RoleNavigation, IsDepartmentHead = a.IsDepartmentHead })
                    .ToListAsync(),
                RoleList = new SelectList(
                    await _context.Roles
                        .Where(r => r.RoleName != "SuperAdmin")
                        .ToListAsync(),
                    "RoleId",
                    "RoleName"
                ),
                ManagerList = new SelectList(
                    new List<Admin> { manager },
                    "AdminId",
                    "Username"
                )
            };

            ViewData["CurrentIsDepartmentHead"] = (currentAdmin.IsDepartmentHead ?? false) && currentAdmin.ManagerId == null;
            ViewData["CurrentAdminId"] = currentAdminId;
            ViewData["ManagerId"] = managerId;
            ViewData["IsGroupMember"] = isGroupMember;

            return View(viewModel);
        }

        // GET: Admins/Groups/CreateGroup
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

            var isSuperAdminOrAdmin = currentAdmin.RoleNavigation?.RoleName is "SuperAdmin" or "Admin";
            var isDepartmentHead = currentAdmin.IsDepartmentHead == true && currentAdmin.ManagerId == null;
            var isGroupMember = currentAdmin.ManagerId != null;

            if (!isSuperAdminOrAdmin && !isDepartmentHead)
            {
                return Json(new { success = false, message = "Bạn không có quyền tạo nhóm." });
            }

            if (isGroupMember)
            {
                return Json(new { success = false, message = "Thành viên trong nhóm không được phép tạo nhóm." });
            }

            var viewModel = new GroupManagement
            {
                Roles = await _context.Roles
                    .Where(r => r.RoleName != "SuperAdmin")
                    .ToListAsync(),
                Admins = await _context.Admins
                    .Include(a => a.RoleNavigation)
                    .Where(a => a.ManagerId == null && a.IsDepartmentHead != true && a.RoleNavigation.RoleName != "SuperAdmin")
                    .ToListAsync(),
                RoleList = new SelectList(
                    await _context.Roles
                        .Where(r => r.RoleName != "SuperAdmin")
                        .ToListAsync(),
                    "RoleId",
                    "RoleName"
                ),
                ManagerList = new SelectList(Enumerable.Empty<Admin>(), "AdminId", "Username")
            };

            if (isDepartmentHead)
            {
                viewModel.Roles = viewModel.Roles
                    .Where(r => r.RoleId == currentAdmin.RoleId)
                    .ToList();
                viewModel.Admins = viewModel.Admins
                    .Where(a => a.RoleId == currentAdmin.RoleId)
                    .ToList();
                viewModel.RoleList = new SelectList(
                    viewModel.Roles,
                    "RoleId",
                    "RoleName",
                    currentAdmin.RoleId
                );
            }

            return View(viewModel);
        }

        // POST: Admins/Groups/CreateGroup
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateGroup(GroupManagement model)
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập lại." });
            }

            var isSuperAdminOrAdmin = currentAdmin.RoleNavigation?.RoleName is "SuperAdmin" or "Admin";
            var isDepartmentHead = currentAdmin.IsDepartmentHead == true && currentAdmin.ManagerId == null;
            var isGroupMember = currentAdmin.ManagerId != null;

            if (!isSuperAdminOrAdmin && !isDepartmentHead)
            {
                return Json(new { success = false, message = "Bạn không có quyền tạo nhóm." });
            }

            if (isGroupMember)
            {
                return Json(new { success = false, message = "Thành viên trong nhóm không được phép tạo nhóm." });
            }

            if (!model.RoleId.HasValue || model.RoleId <= 0)
            {
                return Json(new { success = false, message = "Vui lòng chọn vai trò." });
            }
            if (!model.ManagerId.HasValue || model.ManagerId <= 0)
            {
                return Json(new { success = false, message = "Vui lòng chọn trưởng nhóm." });
            }

            var role = await _context.Roles
                .FirstOrDefaultAsync(r => r.RoleId == model.RoleId && r.RoleName != "SuperAdmin");

            if (role == null)
            {
                return Json(new { success = false, message = "Vai trò không tồn tại hoặc không hợp lệ." });
            }

            var manager = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == model.ManagerId && a.RoleNavigation.RoleName != "SuperAdmin");

            if (manager == null)
            {
                return Json(new { success = false, message = "Trưởng nhóm không tồn tại hoặc không hợp lệ." });
            }

            if (manager.RoleId != model.RoleId)
            {
                return Json(new { success = false, message = "Trưởng nhóm phải có vai trò tương ứng với nhóm." });
            }

            if (manager.ManagerId != null || manager.IsDepartmentHead == true)
            {
                return Json(new { success = false, message = "Admin đã thuộc một nhóm khác hoặc đang là trưởng nhóm." });
            }

            if (isDepartmentHead && model.RoleId != currentAdmin.RoleId)
            {
                return Json(new { success = false, message = "Bạn chỉ có thể tạo nhóm với vai trò của mình." });
            }

            manager.IsDepartmentHead = true;
            manager.RoleId = model.RoleId.Value;
            manager.ManagerId = null;
            _context.Update(manager);

            try
            {
                await _context.SaveChangesAsync();
                TempData["Success"] = "Tạo nhóm thành công!";
                return Json(new { success = true, message = "Tạo nhóm thành công!" });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Lỗi khi tạo nhóm (managerId={model.ManagerId}): {ex.Message}");
                return Json(new { success = false, message = "Có lỗi xảy ra khi tạo nhóm. Vui lòng thử lại." });
            }
        }

        // GET: Admins/Groups/AddMemberToGroup
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

            var isSuperAdminOrAdmin = currentAdmin.RoleNavigation?.RoleName is "SuperAdmin" or "Admin";
            var isDepartmentHead = currentAdmin.IsDepartmentHead == true && currentAdmin.ManagerId == null;
            var isGroupMember = currentAdmin.ManagerId != null;

            if (!isSuperAdminOrAdmin && !isDepartmentHead)
            {
                return Json(new { success = false, message = "Bạn không có quyền thêm thành viên vào nhóm." });
            }

            if (isGroupMember)
            {
                return Json(new { success = false, message = "Thành viên trong nhóm không được phép thêm thành viên." });
            }

            var manager = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == managerId && a.IsDepartmentHead == true && a.RoleNavigation.RoleName != "SuperAdmin");

            if (manager == null)
            {
                return Json(new { success = false, message = "Trưởng nhóm không tồn tại hoặc không hợp lệ." });
            }

            if (isDepartmentHead && managerId != currentAdminId)
            {
                return Json(new { success = false, message = "Bạn chỉ có thể thêm thành viên vào nhóm của mình." });
            }

            var viewModel = new GroupManagement
            {
                Managers = new List<Admin> { manager },
                Admins = await _context.Admins
                    .Include(a => a.RoleNavigation)
                    .Where(a => a.ManagerId == null && a.IsDepartmentHead != true && a.AdminId != managerId && a.RoleId == manager.RoleId && a.RoleNavigation.RoleName != "SuperAdmin")
                    .ToListAsync(),
                ManagerList = new SelectList(
                    new List<Admin> { manager },
                    "AdminId",
                    "Username"
                ),
                ManagerId = managerId
            };

            return View(viewModel);
        }

        // POST: Admins/Groups/AddMemberToGroup
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddMemberToGroup(GroupManagement model)
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập lại." });
            }

            var isSuperAdminOrAdmin = currentAdmin.RoleNavigation?.RoleName is "SuperAdmin" or "Admin";
            var isDepartmentHead = currentAdmin.IsDepartmentHead == true && currentAdmin.ManagerId == null;
            var isGroupMember = currentAdmin.ManagerId != null;

            if (!isSuperAdminOrAdmin && !isDepartmentHead)
            {
                return Json(new { success = false, message = "Bạn không có quyền thêm thành viên vào nhóm." });
            }

            if (isGroupMember)
            {
                return Json(new { success = false, message = "Thành viên trong nhóm không được phép thêm thành viên." });
            }

            var manager = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == model.ManagerId && a.IsDepartmentHead == true && a.RoleNavigation.RoleName != "SuperAdmin");

            if (manager == null)
            {
                return Json(new { success = false, message = "Trưởng nhóm không tồn tại hoặc không hợp lệ." });
            }

            if (isDepartmentHead && model.ManagerId != currentAdminId)
            {
                return Json(new { success = false, message = "Bạn chỉ có thể thêm thành viên vào nhóm của mình." });
            }

            var admin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == model.AdminId && a.RoleNavigation.RoleName != "SuperAdmin");

            if (admin == null)
            {
                return Json(new { success = false, message = "Admin không tồn tại hoặc không hợp lệ." });
            }

            if (admin.ManagerId != null || admin.IsDepartmentHead == true)
            {
                return Json(new { success = false, message = "Admin đã thuộc một nhóm khác hoặc là trưởng nhóm." });
            }

            if (admin.RoleId != manager.RoleId)
            {
                return Json(new { success = false, message = "Vai trò của admin không khớp với vai trò của nhóm." });
            }

            admin.ManagerId = model.ManagerId;
            _context.Update(admin);

            try
            {
                await _context.SaveChangesAsync();
                TempData["Success"] = "Thêm thành viên thành công!";
                return Json(new { success = true, message = "Thêm thành viên thành công!" });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Lỗi khi thêm thành viên (adminId={model.AdminId}, managerId={model.ManagerId}): {ex.Message}");
                return Json(new { success = false, message = "Có lỗi xảy ra khi thêm thành viên. Vui lòng thử lại." });
            }
        }

        // POST: Admins/Groups/DeleteGroup
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteGroup(int managerId)
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập lại." });
            }

            var isSuperAdminOrAdmin = currentAdmin.RoleNavigation?.RoleName is "SuperAdmin" or "Admin";
            var isDepartmentHead = currentAdmin.IsDepartmentHead == true && currentAdmin.ManagerId == null;
            var isGroupMember = currentAdmin.ManagerId != null;

            if (!isSuperAdminOrAdmin && !isDepartmentHead)
            {
                return Json(new { success = false, message = "Bạn không có quyền xóa nhóm." });
            }

            if (isGroupMember)
            {
                return Json(new { success = false, message = "Thành viên trong nhóm không được phép xóa nhóm." });
            }

            var manager = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == managerId && a.IsDepartmentHead == true && a.RoleNavigation.RoleName != "SuperAdmin");

            if (manager == null)
            {
                return Json(new { success = false, message = "Nhóm không tồn tại hoặc không hợp lệ." });
            }

            if (isDepartmentHead && managerId != currentAdminId)
            {
                return Json(new { success = false, message = "Bạn chỉ có thể xóa nhóm của mình." });
            }

            var members = await _context.Admins
                .Where(a => a.ManagerId == managerId)
                .ToListAsync();
            foreach (var member in members)
            {
                member.ManagerId = null;
                _context.Update(member);
            }

            manager.IsDepartmentHead = false;
            _context.Update(manager);

            try
            {
                await _context.SaveChangesAsync();
                TempData["Success"] = "Xóa nhóm thành công!";
                return Json(new { success = true, message = "Xóa nhóm thành công!" });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Lỗi khi xóa nhóm (managerId={managerId}): {ex.Message}");
                return Json(new { success = false, message = "Có lỗi xảy ra khi xóa nhóm. Vui lòng thử lại." });
            }
        }

        // POST: Admins/Groups/DeleteMemberFromGroup
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteMemberFromGroup(int managerId, int adminId)
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập lại." });
            }

            var isSuperAdminOrAdmin = currentAdmin.RoleNavigation?.RoleName is "SuperAdmin" or "Admin";
            var isDepartmentHead = currentAdmin.IsDepartmentHead == true && currentAdmin.ManagerId == null;
            var isGroupMember = currentAdmin.ManagerId != null;

            if (!isSuperAdminOrAdmin && !isDepartmentHead)
            {
                return Json(new { success = false, message = "Bạn không có quyền xóa thành viên khỏi nhóm." });
            }

            if (isGroupMember)
            {
                return Json(new { success = false, message = "Thành viên trong nhóm không được phép xóa thành viên." });
            }

            var manager = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == managerId && a.IsDepartmentHead == true && a.RoleNavigation.RoleName != "SuperAdmin");

            if (manager == null)
            {
                return Json(new { success = false, message = "Trưởng nhóm không tồn tại hoặc không hợp lệ." });
            }

            if (isDepartmentHead && managerId != currentAdminId)
            {
                return Json(new { success = false, message = "Bạn chỉ có thể xóa thành viên khỏi nhóm của mình." });
            }

            var admin = await _context.Admins
                .FirstOrDefaultAsync(a => a.AdminId == adminId && a.ManagerId == managerId);

            if (admin == null)
            {
                return Json(new { success = false, message = "Thành viên không tồn tại hoặc không thuộc nhóm này." });
            }

            admin.ManagerId = null;
            _context.Update(admin);

            try
            {
                await _context.SaveChangesAsync();
                TempData["Success"] = "Xóa thành viên khỏi nhóm thành công!";
                return Json(new { success = true, message = "Xóa thành viên khỏi nhóm thành công!" });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Lỗi khi xóa thành viên (managerId={managerId}, adminId={adminId}): {ex.Message}");
                return Json(new { success = false, message = "Có lỗi xảy ra khi xóa thành viên. Vui lòng thử lại." });
            }
        }

        // GET: Admins/Groups/GetManagersForRole
        [HttpGet]
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

            var isSuperAdminOrAdmin = currentAdmin.RoleNavigation?.RoleName is "SuperAdmin" or "Admin";
            var isDepartmentHead = currentAdmin.IsDepartmentHead == true && currentAdmin.ManagerId == null;
            var isGroupMember = currentAdmin.ManagerId != null;

            if (!isSuperAdminOrAdmin && !isDepartmentHead)
            {
                return Json(new { success = false, message = "Bạn không có quyền xem danh sách trưởng nhóm." });
            }

            if (isGroupMember)
            {
                return Json(new { success = false, message = "Thành viên trong nhóm không được phép xem danh sách trưởng nhóm." });
            }

            var managers = await _context.Admins
                .Include(a => a.RoleNavigation)
                .Where(a => a.RoleId == roleId && a.ManagerId == null && a.IsDepartmentHead != true && a.RoleNavigation.RoleName != "SuperAdmin")
                .Select(a => new { adminId = a.AdminId, username = a.Username, roleId = a.RoleId })
                .ToListAsync();

            if (isDepartmentHead)
            {
                managers = managers.Where(m => m.adminId == currentAdminId && m.roleId == currentAdmin.RoleId).ToList();
            }

            if (!managers.Any())
            {
                return Json(new { success = false, message = "Không có admin nào phù hợp để làm trưởng nhóm cho vai trò này." });
            }

            return Json(managers);
        }
    }
}