using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebTAManga.Login.Models;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{

    public class LoginController : Controller
    {
        public WebMangaContext _context;
        public LoginController(WebMangaContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost] // POST -> khi submit form
        public IActionResult Index(LoginCustomers model)
        {
            if (!ModelState.IsValid)
            {
                ModelState.AddModelError(string.Empty, "Thông tin đăng nhập không hợp lệ.");
                return View(model);
            }

            var pass = model.Password;
            var dataLogin = _context.Users.FirstOrDefault(x => x.Email.Equals(model.Email) && x.Password.Equals(pass));
            if (dataLogin != null)
            {
                HttpContext.Session.SetString("usersLogin", model.Email);
                HttpContext.Session.SetInt32("UsersID", (int)dataLogin.UserId);
         

                return RedirectToAction("Index", "Home", new { UsersID = dataLogin.UserId });
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Thông tin đăng nhập không chính xác.");
                return View(model);
            }

        }
        [HttpGet]// thoát đăng nhập, huỷ session
        public IActionResult Logout()
        {
            HttpContext.Session.Remove("usersLogin"); // huỷ session với key  đã lưu trước đó

            return RedirectToAction("Index");
        }
    }
}