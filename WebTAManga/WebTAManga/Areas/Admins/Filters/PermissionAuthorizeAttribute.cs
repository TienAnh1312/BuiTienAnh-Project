using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Filters
{
    public class PermissionAuthorizeAttribute : AuthorizeAttribute, IAuthorizationFilter
    {
        private readonly string _module;
        private readonly string _action;

        public PermissionAuthorizeAttribute(string module, string action)
        {
            _module = module;
            _action = action;
        }

        public void OnAuthorization(AuthorizationFilterContext context)
        {
            var user = context.HttpContext.User;
            if (!user.Identity.IsAuthenticated)
            {
                context.Result = new UnauthorizedResult();
                return;
            }

            if (user.IsInRole("SuperAdmin"))
            {
                return; // SuperAdmin có toàn quyền
            }

            if (!user.IsInRole("ContentManager"))
            {
                context.Result = new ForbidResult();
                return;
            }

            // Lấy AdminId từ session
            var adminId = context.HttpContext.Session.GetInt32("AdminId");
            if (!adminId.HasValue)
            {
                context.Result = new RedirectToRouteResult(new RouteValueDictionary(new { Controller = "Login", Action = "Index", Area = "Admins" }));
                return;
            }

            // Lấy context từ DI
            var serviceProvider = context.HttpContext.RequestServices;
            var dbContext = serviceProvider.GetService<WebMangaContext>();

            // Kiểm tra quyền
            var permission = dbContext.ManagerPermissions
                .FirstOrDefault(p => p.AdminId == adminId && p.Module == _module);

            if (permission == null)
            {
                context.Result = new ForbidResult();
                return;
            }

            bool hasPermission = _action switch
            {
                "View" => permission.CanView,
                "Create" => permission.CanCreate,
                "Edit" => permission.CanEdit,
                "Delete" => permission.CanDelete,
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