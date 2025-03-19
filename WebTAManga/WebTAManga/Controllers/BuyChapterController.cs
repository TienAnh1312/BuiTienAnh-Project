using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class BuyChapterController : Controller
    {
        
        private readonly WebMangaContext _context;
       
        public BuyChapterController(WebMangaContext context)
        {   
            _context = context;
        }

        [HttpPost]
        public IActionResult BuyChapter(int chapterId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                TempData["ErrorMessage"] = "Bạn cần đăng nhập để mua Chương!";
                return RedirectToAction("Login", "Account");
            }

            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            var chapter = _context.Chapters.FirstOrDefault(c => c.ChapterId == chapterId);

            if (chapter == null || user == null)
            {
                TempData["ErrorMessage"] = "Không tìm thấy Chương hoặc người dùng!";
                return RedirectToAction("ReadChapter", new { id = chapterId });
            }

            // Kiểm tra xem user đã mua chapter này chưa dựa trên ChapterCode
            bool isAlreadyPurchased = _context.PurchasedChapters
                .Any(pc => pc.UserId == userId && pc.ChapterCode == chapter.ChapterCode);

            if (isAlreadyPurchased)
            {
                TempData["InfoMessage"] = "Bạn đã mua Chương này rồi!";
                return RedirectToAction("ReadChapter", new { id = chapterId });
            }

            // Logic mua chương
            if (user.Coins < chapter.Coins)
            {
                TempData["ErrorMessage"] = "Bạn không có đủ xu để mua Chương này!";
                return RedirectToAction("ReadChapter", "ReadChapter", new { id = chapterId });
            }

            using (var transaction = _context.Database.BeginTransaction())
            {
                try
                {
                    user.Coins -= chapter.Coins;
                    _context.PurchasedChapters.Add(new PurchasedChapter
                    {
                        UserId = user.UserId,
                        ChapterCode = chapter.ChapterCode,
                        PurchasedAt = DateTime.Now
                    });

                    _context.SaveChanges();
                    transaction.Commit();

                    TempData["SuccessMessage"] = "Mua Chương thành công!";
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    TempData["ErrorMessage"] = "Có lỗi xảy ra, vui lòng thử lại!";
                }
            }
            return RedirectToAction("ReadChapter", "ReadChapter", new { id = chapterId });
        }
    }
}
