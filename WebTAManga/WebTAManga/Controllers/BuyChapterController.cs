using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class BuyChapterController : Controller
    {
        
        private readonly WebMangaContext _context;
       
        // Constructor 
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
                TempData["ErrorMessage"] = "Bạn cần đăng nhập để mua chapter!";
                return RedirectToAction("Index", "Login");
            }

            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            var chapter = _context.Chapters.FirstOrDefault(c => c.ChapterId == chapterId);

            if (chapter == null || user == null)
            {
                TempData["ErrorMessage"] = "Không tìm thấy chapter hoặc người dùng!";
                return RedirectToAction("ReadChapter", new { id = chapterId });
            }

            // Kiểm tra xem user đã mua chapter này chưa
            bool isAlreadyPurchased = _context.PurchasedChapters
                .Any(pc => pc.UserId == userId && pc.ChapterId == chapterId);

            if (isAlreadyPurchased)
            {
                TempData["InfoMessage"] = "Bạn đã mua chapter này rồi!";
                return RedirectToAction("ReadChapter", new { id = chapterId });
            }

            // Kiểm tra số xu của người dùng trước khi thực hiện giao dịch
            if (user.Coins < chapter.Coins)
            {
                TempData["ErrorMessage"] = "Bạn không có đủ xu để mua chapter này!";
                return RedirectToAction("ReadChapter", new { id = chapterId });
            }

            // Nếu đủ xu, tiến hành giao dịch
            using (var transaction = _context.Database.BeginTransaction())
            {
                try
                {
                    // Trừ xu của người dùng
                    user.Coins -= chapter.Coins;

                    // Thêm vào danh sách chương đã mua
                    _context.PurchasedChapters.Add(new PurchasedChapter
                    {
                        UserId = user.UserId,
                        ChapterId = chapter.ChapterId,
                        PurchasedAt = DateTime.Now
                    });

                    _context.SaveChanges();

                    // Commit transaction
                    transaction.Commit();

                    TempData["SuccessMessage"] = "Mua chapter thành công!";
                }
                catch (Exception ex)
                {
                    // Rollback nếu có lỗi
                    transaction.Rollback();
                    TempData["ErrorMessage"] = "Có lỗi xảy ra, vui lòng thử lại!";
                }
            }
            return RedirectToAction("ReadChapter", "ReadChapter", new { id = chapterId });
        }
    }
}
