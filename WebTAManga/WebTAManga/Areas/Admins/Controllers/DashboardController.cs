using Microsoft.AspNetCore.Mvc;

namespace WebTAManga.Areas.Admins.Controllers
{
    public class DashboardController : BaseController
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
