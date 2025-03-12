using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class FollowedController : Controller
    {
       
        private readonly WebMangaContext _context;
       
        public FollowedController(WebMangaContext context)
        {    
            _context = context;
        }

        //thêm vào danh sách theo dõi
        [HttpPost]
        public IActionResult AddToFollowed(int storyId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return Json(new { success = false, redirect = Url.Action("Login", "Account") });
            }

            var followedStory = _context.FollowedStories.FirstOrDefault(f => f.UserId == userId && f.StoryId == storyId);
            if (followedStory == null)
            {
                followedStory = new FollowedStory
                {
                    UserId = userId.Value,
                    StoryId = storyId,
                    LastReadChapterId = null
                };
                _context.FollowedStories.Add(followedStory);
                _context.SaveChanges();
                return Json(new { success = true, isFollowed = true, message = "The story has been added to your followed stories!" });
            }

            return Json(new { success = false, isFollowed = true, message = "This story is already in your followed stories." });
        }

        //theo dõi truyện
        public IActionResult FollowedStories()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Login", "Account");
            }

            // Lấy danh sách các câu chuyện mà người dùng đang theo dõi
            var followedStories = _context.FollowedStories
                                           .Where(f => f.UserId == userId)
                                           .Include(f => f.Story)
                                           .Include(f => f.LastReadChapter) // Bao gồm thông tin chương cuối đã đọc
                                           .ToList();

            return View(followedStories);
        }

        [HttpPost]
        public IActionResult Unfollow(int storyId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return Json(new { success = false, redirect = Url.Action("Login", "Account") });
            }

            var followedStory = _context.FollowedStories.FirstOrDefault(f => f.UserId == userId && f.StoryId == storyId);
            if (followedStory != null)
            {
                _context.FollowedStories.Remove(followedStory);
                _context.SaveChanges();
                return Json(new { success = true, isFollowed = false, message = "You have unfollowed this story." });
            }

            return Json(new { success = false, isFollowed = false, message = "You are not following this story." });
        }

    }
}
