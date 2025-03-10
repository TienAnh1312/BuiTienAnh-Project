using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class FavoritesController : Controller
    {
        private readonly WebMangaContext _context;

       
        public FavoritesController(WebMangaContext context)
        {  
            _context = context;
        }

        //thêm vào danh sách yêu thích
        [HttpPost]
        public IActionResult AddToFavorites(int storyId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return Json(new { success = false, redirect = Url.Action("Login", "Account") });
            }

            var favorite = _context.Favorites.FirstOrDefault(f => f.UserId == userId && f.StoryId == storyId);
            if (favorite == null)
            {
                favorite = new Favorite
                {
                    UserId = userId.Value,
                    StoryId = storyId,
                    AddedAt = DateTime.Now
                };
                _context.Favorites.Add(favorite);
                _context.SaveChanges();
                return Json(new { success = true, isFavorited = true, message = "The story has been added to your favorites!" });
            }

            return Json(new { success = false, isFavorited = true, message = "This story is already in your favorites." });
        }

        //danh sách yêu thích
        public IActionResult FavoriteList()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Login", "Account");
            }

            var favorites = _context.Favorites
                                    .Include(f => f.Story)
                                    .Where(f => f.UserId == userId)
                                    .Select(f => f.Story)
                                    .ToList();

            return View(favorites);
        }

        //xóa khỏi danh sách yêu thích
        [HttpPost]
        public IActionResult RemoveFromFavorites(int storyId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return Json(new { success = false, redirect = Url.Action("Login", "Account") });
            }

            var favorite = _context.Favorites.FirstOrDefault(f => f.UserId == userId && f.StoryId == storyId);
            if (favorite != null)
            {
                _context.Favorites.Remove(favorite);
                _context.SaveChanges();
                return Json(new { success = true, isFavorited = false, message = "The story has been removed from your favorites." });
            }

            return Json(new { success = false, isFavorited = false, message = "This story is not in your favorites." });
        }
    }
}
