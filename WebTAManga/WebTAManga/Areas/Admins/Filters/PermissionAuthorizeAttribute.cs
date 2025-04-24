using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;
using WebTAManga.Areas.Admins.Models;

namespace WebTAManga.Areas.Admins.Filters
{
    public class PermissionAuthorizeAttribute : ActionFilterAttribute
    {
        private readonly string _module;
        private readonly string _action;

        public PermissionAuthorizeAttribute(string module, string action)
        {
            _module = module;
            _action = action;
        }

        public override void OnActionExecuting(ActionExecutingContext context)
        {
            var user = context.HttpContext.User;
            if (!user.Identity.IsAuthenticated)
            {
                context.Result = new UnauthorizedResult();
                return;
            }

            if (user.IsInRole("SuperAdmin") || user.IsInRole("Admin"))
            {
                return;
            }

            var adminId = context.HttpContext.Session.GetInt32("AdminId");
            if (!adminId.HasValue)
            {
                context.Result = new RedirectToRouteResult(new RouteValueDictionary(new { Controller = "Login", Action = "Index", Area = "Admins" }));
                return;
            }

            var serviceProvider = context.HttpContext.RequestServices;
            var dbContext = serviceProvider.GetService<WebMangaContext>();

            var currentAdmin = dbContext.Admins
                .Include(a => a.RoleNavigation)
                .FirstOrDefault(a => a.AdminId == adminId.Value);

            if (currentAdmin == null)
            {
                context.Result = new RedirectToRouteResult(new RouteValueDictionary(new { Controller = "Login", Action = "Index", Area = "Admins" }));
                return;
            }

            // ContentManager hoặc các vai trò khác cần kiểm tra quyền trong ManagerPermissions
            List<string> allowedModules = new List<string>();
            if (PermissionModules.ManagerAssignableModules.ContainsKey(currentAdmin.RoleNavigation?.RoleName))
            {
                allowedModules = PermissionModules.ManagerAssignableModules[currentAdmin.RoleNavigation.RoleName];
            }

            if (!allowedModules.Contains(_module))
            {
                context.Result = new ForbidResult();
                return;
            }

            var permission = dbContext.ManagerPermissions
                .FirstOrDefault(p => p.AdminId == adminId.Value && p.Module == _module);

            if (permission == null)
            {
                context.Result = new ForbidResult();
                return;
            }

            bool hasPermission = _action switch
            {
                "View" => permission.CanView.GetValueOrDefault(false),
                "Create" => permission.CanCreate.GetValueOrDefault(false),
                "Edit" => permission.CanEdit.GetValueOrDefault(false),
                "Delete" => permission.CanDelete.GetValueOrDefault(false),
                _ => false
            };

            if (!hasPermission)
            {
                context.Result = new ForbidResult();
                return;
            }
        }
    }
}