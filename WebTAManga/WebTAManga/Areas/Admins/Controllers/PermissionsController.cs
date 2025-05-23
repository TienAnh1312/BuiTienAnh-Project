using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Areas.Admins.Filters;
using WebTAManga.Areas.Admins.Models;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    [Authorize] 
    public class PermissionsController : BaseController
    {
        private readonly WebMangaContext _context;

        public PermissionsController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Permissions/AssignPermissions/5
        public async Task<IActionResult> AssignPermissions(int? id)
        {
            if (id == null)
            {
                return NotFound("ID không hợp lệ.");
            }

            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return RedirectToAction("Index", "Login");
            }

            // Kiểm tra quyền truy cập: chỉ SuperAdmin, Admin, hoặc trưởng nhóm
            var isSuperAdminOrAdmin = currentAdmin.RoleNavigation?.RoleName is "SuperAdmin" or "Admin";
            var isDepartmentHead = currentAdmin.IsDepartmentHead == true;
            if (!isSuperAdminOrAdmin && !isDepartmentHead)
            {
                return Forbid("Bạn không có quyền chỉnh sửa quyền của bất kỳ ai.");
            }

            var admin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == id);
            if (admin == null)
            {
                return NotFound("Admin không tồn tại.");
            }

            // Ngăn thành viên không phải trưởng nhóm chỉnh sửa quyền của bất kỳ ai
            if (!isSuperAdminOrAdmin && !isDepartmentHead)
            {
                return Forbid("Bạn không có quyền chỉnh sửa quyền của người khác.");
            }

            // Kiểm tra quyền của trưởng nhóm
            if (isDepartmentHead && admin.ManagerId != currentAdminId)
            {
                return Forbid("Bạn chỉ có thể sửa quyền cho thành viên trong nhóm của mình.");
            }

            // Gán danh sách module dựa trên vai trò
            List<string> modules = PermissionModules.ManagerAssignableModules.GetValueOrDefault(admin.RoleNavigation?.RoleName, new List<string>());
            if (!modules.Any())
            {
                return Forbid("Vai trò không hợp lệ để gán quyền.");
            }

            var permissions = await _context.ManagerPermissions
                .Where(p => p.AdminId == id)
                .ToListAsync();

            ViewData["Admin"] = admin;
            ViewData["CurrentAdminId"] = currentAdminId;
            ViewData["CurrentIsDepartmentHead"] = isDepartmentHead; // Truyền trạng thái trưởng nhóm
            ViewData["Modules"] = modules;
            ViewData["Permissions"] = permissions;

            return View();
        }

        // POST: Admins/Permissions/AssignPermissions
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AssignPermissions(int id, [FromForm] IFormCollection form)
        {
            var currentAdminId = HttpContext.Session.GetInt32("AdminId") ?? 0;
            var currentAdmin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == currentAdminId);

            if (currentAdmin == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập lại." });
            }

            // Kiểm tra quyền truy cập: chỉ SuperAdmin, Admin, hoặc trưởng nhóm
            var isSuperAdminOrAdmin = currentAdmin.RoleNavigation?.RoleName is "SuperAdmin" or "Admin";
            var isDepartmentHead = currentAdmin.IsDepartmentHead == true;
            if (!isSuperAdminOrAdmin && !isDepartmentHead)
            {
                return Json(new { success = false, message = "Bạn không có quyền chỉnh sửa quyền của bất kỳ ai." });
            }

            var admin = await _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefaultAsync(a => a.AdminId == id);
            if (admin == null)
            {
                return Json(new { success = false, message = "Admin không tồn tại." });
            }

            // Ngăn thành viên không phải trưởng nhóm chỉnh sửa quyền của bất kỳ ai
            if (!isSuperAdminOrAdmin && !isDepartmentHead)
            {
                return Json(new { success = false, message = "Bạn không có quyền chỉnh sửa quyền của người khác." });
            }

            // Kiểm tra quyền của trưởng nhóm
            if (isDepartmentHead && admin.ManagerId != currentAdminId)
            {
                return Json(new { success = false, message = "Bạn chỉ có thể sửa quyền cho thành viên trong nhóm của mình." });
            }

            // Gán danh sách module dựa trên vai trò
            List<string> modules = PermissionModules.ManagerAssignableModules.GetValueOrDefault(admin.RoleNavigation?.RoleName, new List<string>());
            if (!modules.Any())
            {
                return Json(new { success = false, message = "Vai trò không hợp lệ để gán quyền." });
            }

            // Kiểm tra module hợp lệ
            var selectedModules = form["selectedModules"].ToList();
            if (selectedModules.Any(m => !PermissionModules.AllModules.Contains(m)))
            {
                return Json(new { success = false, message = "Module không hợp lệ." });
            }

            var existingPermissions = await _context.ManagerPermissions
                .Where(p => p.AdminId == id)
                .ToListAsync();

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

            try
            {
                await _context.SaveChangesAsync();
                Console.WriteLine($"Admin {currentAdminId} sửa quyền cho admin {id} vào {DateTime.Now}");
                TempData["Success"] = "Cập nhật quyền thành công!";
                return Json(new { success = true, message = "Cập nhật quyền thành công!" });
            }
            catch (DbUpdateException ex)
            {
                Console.WriteLine($"Lỗi khi lưu quyền (adminId={id}): {ex.Message}");
                return Json(new { success = false, message = "Có lỗi xảy ra khi lưu quyền. Vui lòng thử lại." });
            }
        }
    }
}