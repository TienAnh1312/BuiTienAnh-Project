using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;
using System.Linq;
using System.Threading.Tasks;
using WebTAManga.Areas.Admins.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    [Authorize(Roles = "SuperAdmin")]
    public class PermissionsController : BaseController
    {
        private readonly WebMangaContext _context;

        public PermissionsController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Permissions
        public async Task<IActionResult> Index(int? adminId)
        {
            var admins = await _context.Admins
                .Include(a => a.RoleNavigation)
                .Where(a => a.RoleNavigation.RoleName == "ContentManager")
                .ToListAsync();

            ViewData["Admins"] = admins;
            ViewData["SelectedAdminId"] = adminId;

            var permissions = adminId.HasValue
                ? await _context.ManagerPermissions
                    .Where(p => p.AdminId == adminId)
                    .ToListAsync()
                : new List<ManagerPermission>();

            ViewData["Modules"] = PermissionModules.AllModules;
            return View(permissions);
        }

        // GET: Admins/Permissions/Create
        public IActionResult Create(int adminId)
        {
            var admin = _context.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefault(a => a.AdminId == adminId && a.RoleNavigation.RoleName == "ContentManager");

            if (admin == null)
            {
                return NotFound();
            }

            ViewData["Modules"] = PermissionModules.AllModules;
            return View(new ManagerPermission { AdminId = adminId, AssignedBy = HttpContext.Session.GetInt32("AdminId") ?? 0 });
        }

        // POST: Admins/Permissions/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("AdminId,Module,CanView,CanEdit,CanCreate,CanDelete,AssignedBy")] ManagerPermission permission)
        {
            if (ModelState.IsValid)
            {
                permission.AssignedAt = DateTime.Now;
                _context.Add(permission);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index), new { adminId = permission.AdminId });
            }

            ViewData["Modules"] = PermissionModules.AllModules;
            return View(permission);
        }

        // GET: Admins/Permissions/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var permission = await _context.ManagerPermissions.FindAsync(id);
            if (permission == null)
            {
                return NotFound();
            }

            ViewData["Modules"] = PermissionModules.AllModules;
            return View(permission);
        }

        // POST: Admins/Permissions/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("PermissionId,AdminId,Module,CanView,CanEdit,CanCreate,CanDelete,AssignedBy,AssignedAt")] ManagerPermission permission)
        {
            if (id != permission.PermissionId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(permission);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!_context.ManagerPermissions.Any(p => p.PermissionId == id))
                    {
                        return NotFound();
                    }
                    throw;
                }
                return RedirectToAction(nameof(Index), new { adminId = permission.AdminId });
            }

            ViewData["Modules"] = PermissionModules.AllModules;
            return View(permission);
        }

        // GET: Admins/Permissions/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var permission = await _context.ManagerPermissions
                .Include(p => p.Admin)
                .FirstOrDefaultAsync(p => p.PermissionId == id);
            if (permission == null)
            {
                return NotFound();
            }

            return View(permission);
        }

        // POST: Admins/Permissions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var permission = await _context.ManagerPermissions.FindAsync(id);
            if (permission != null)
            {
                _context.ManagerPermissions.Remove(permission);
                await _context.SaveChangesAsync();
            }
            return RedirectToAction(nameof(Index), new { adminId = permission.AdminId });
        }
    }
}