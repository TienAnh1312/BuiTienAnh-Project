using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Controllers
{
    public class ProfileController : Controller
    {
        private readonly WebMangaContext _context;
        private readonly IWebHostEnvironment _environment;
        private readonly IWebHostEnvironment _hostingEnvironment;
      

        public ProfileController(WebMangaContext context, IWebHostEnvironment environment, IWebHostEnvironment hostingEnvironment)
        {
            _context = context;
            _environment = environment;
            _hostingEnvironment = hostingEnvironment;
        }
        public IActionResult Profile()
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var user = _context.Users
                .Include(u => u.Rank)
                .Include(u => u.CategoryRank)
                .Include(u => u.AvatarFrame)
                .Include(u => u.PurchasedAvatarFrames)
                .ThenInclude(p => p.AvatarFrame)       // Include thông tin khung đã mua
                .FirstOrDefault(u => u.UserId == userId);

            if (user == null)
            {
                return NotFound();
            }

            // Xác định RankId: nếu chưa chọn thì lấy mặc định (RankId = 1)
            int currentRankId = user.RankId ?? 1;

            // Tìm Level hiện tại dựa trên ExpPoints trong tất cả Levels
            var currentLevel = _context.Levels
                .Where(l => l.ExpRequired <= (user.ExpPoints ?? 0))
                .OrderByDescending(l => l.ExpRequired)
                .FirstOrDefault();

            var nextLevel = _context.Levels
                .Where(l => l.ExpRequired > (user.ExpPoints ?? 0))
                .OrderBy(l => l.ExpRequired)
                .FirstOrDefault();

            // Tính tỷ lệ phần trăm tiến trình và xác định levelName
            double progressPercentage = 0;
            string levelName = "Chưa xác định";

            if (currentLevel != null)
            {
                var categoryRank = _context.CategoryRanks
                    .FirstOrDefault(cr => cr.RankId == currentRankId && cr.CategoryRankId == currentLevel.CategoryRankId);

                if (categoryRank != null)
                {
                    levelName = categoryRank.Name;
                    user.CategoryRankId = categoryRank.CategoryRankId;
                    user.Level = currentLevel.LevelId;
                }
                else
                {
                    var matchingCategoryRank = _context.CategoryRanks
                        .Join(_context.Levels,
                            cr => cr.CategoryRankId,
                            l => l.CategoryRankId,
                            (cr, l) => new { CategoryRank = cr, Level = l })
                        .Where(x => x.CategoryRank.RankId == currentRankId && x.Level.ExpRequired <= (user.ExpPoints ?? 0))
                        .OrderByDescending(x => x.Level.ExpRequired)
                        .Select(x => x.CategoryRank)
                        .FirstOrDefault();

                    if (matchingCategoryRank != null)
                    {
                        levelName = matchingCategoryRank.Name;
                        user.CategoryRankId = matchingCategoryRank.CategoryRankId;
                        user.Level = _context.Levels
                            .FirstOrDefault(l => l.CategoryRankId == matchingCategoryRank.CategoryRankId && l.ExpRequired <= (user.ExpPoints ?? 0))?.LevelId ?? 0;
                    }
                    else
                    {
                        var defaultCategoryRank = _context.CategoryRanks
                            .Where(cr => cr.RankId == currentRankId)
                            .OrderBy(cr => cr.CategoryRankId)
                            .FirstOrDefault();
                        levelName = defaultCategoryRank?.Name ?? "Chưa xác định";
                        user.CategoryRankId = defaultCategoryRank?.CategoryRankId;
                        user.Level = 0;
                    }
                }

                if (nextLevel != null)
                {
                    double currentExp = user.ExpPoints ?? 0;
                    double expRequiredForNext = nextLevel.ExpRequired;
                    double expRequiredForCurrent = currentLevel.ExpRequired;
                    progressPercentage = ((currentExp - expRequiredForCurrent) / (expRequiredForNext - expRequiredForCurrent)) * 100;
                    if (progressPercentage > 100) progressPercentage = 100;
                }
                else
                {
                    progressPercentage = 100;
                    levelName = "Đỉnh Phong";
                }
            }
            else
            {
                var defaultCategoryRank = _context.CategoryRanks
                    .Where(cr => cr.RankId == currentRankId)
                    .OrderBy(cr => cr.CategoryRankId)
                    .FirstOrDefault();
                levelName = defaultCategoryRank?.Name ?? "Chưa xác định";
                user.CategoryRankId = defaultCategoryRank?.CategoryRankId;
                user.Level = 0;
            }

            _context.SaveChanges();

            // Truyền dữ liệu vào ViewBag
            ViewBag.LevelName = levelName;
            ViewBag.ProgressPercentage = progressPercentage;
            ViewBag.ExpPoints = user.ExpPoints ?? 0;
            ViewBag.Ranks = _context.Ranks.ToList();
            ViewBag.AvatarFrames = _context.AvatarFrames.ToList(); // Tất cả khung có sẵn
            ViewBag.PurchasedFrames = user.PurchasedAvatarFrames.Select(p => p.AvatarFrame).ToList(); // Danh sách khung đã mua
            ViewBag.UserCoins = user.Coins ?? 0; // Số xu hiện tại của người dùng

            return View(user);
        }

        // POST: Users/Profile
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Profile([Bind("UserId,Username,Email,Level,Avatar,AvatarFrame,Password,RankId")] User user, IFormFile avatarFile, string newPassword, int selectedRankId, int? selectedFrameId = null)
        {
            var currentUserId = HttpContext.Session.GetInt32("UsersID");
            if (currentUserId == null)
            {
                return RedirectToAction("Index", "Login");
            }

            // Lấy thông tin người dùng hiện tại từ cơ sở dữ liệu
            var existingUser = await _context.Users
                .Include(u => u.Rank)
                .Include(u => u.CategoryRank)
                .Include(u => u.AvatarFrame)
                .Include(u => u.PurchasedAvatarFrames)
                .ThenInclude(p => p.AvatarFrame)
                .FirstOrDefaultAsync(u => u.UserId == currentUserId);

            if (existingUser == null)
            {
                return NotFound();
            }

            // Cập nhật thông tin cơ bản (không liên quan đến khung)
            existingUser.Username = user.Username;
            existingUser.Email = user.Email;
            existingUser.RankId = selectedRankId;

            // Xử lý Rank và Level
            var currentLevel = _context.Levels
                .Where(l => l.ExpRequired <= (existingUser.ExpPoints ?? 0))
                .OrderByDescending(l => l.ExpRequired)
            .FirstOrDefault();

            if (currentLevel != null)
            {
                var categoryRank = _context.CategoryRanks
                    .FirstOrDefault(cr => cr.RankId == selectedRankId && cr.CategoryRankId == currentLevel.CategoryRankId);
                existingUser.CategoryRankId = categoryRank?.CategoryRankId ?? _context.CategoryRanks
                    .Where(cr => cr.RankId == selectedRankId)
                    .OrderBy(cr => cr.CategoryRankId)
                    .FirstOrDefault()?.CategoryRankId;
                existingUser.Level = currentLevel.LevelId;
            }

            // Xử lý AvatarFrameId (khung avatar) - chỉ cập nhật nếu người dùng chọn khung
            if (selectedFrameId.HasValue && selectedFrameId != 0)
            {
                // Kiểm tra xem khung có tồn tại và đã được mua không
                var avatarFrameExists = await _context.AvatarFrames.AnyAsync(af => af.AvatarFrameId == selectedFrameId.Value);
                var isPurchased = _context.PurchasedAvatarFrames.Any(p => p.UserId == currentUserId && p.AvatarFrameId == selectedFrameId.Value);

                if (!avatarFrameExists)
                {
                    ModelState.AddModelError("", "Khung avatar được chọn không tồn tại.");
                    return View(existingUser);
                }
                if (!isPurchased)
                {
                    ModelState.AddModelError("", "Bạn không sở hữu khung avatar này.");
                    return View(existingUser);
                }

                // Nếu hợp lệ, cập nhật AvatarFrameId
                existingUser.AvatarFrameId = selectedFrameId.Value;
            }
            // Nếu không chọn khung (selectedFrameId là null hoặc 0), giữ nguyên giá trị hiện tại của AvatarFrameId
            // Hoặc có thể đặt thành null nếu bạn muốn cho phép bỏ chọn khung:
            // existingUser.AvatarFrameId = null;

            // Xử lý cập nhật avatar (nếu có file upload)
            if (avatarFile != null && avatarFile.Length > 0)
            {
                var uploadsFolder = Path.Combine(_environment.WebRootPath, "uploads/avatars");
                if (!Directory.Exists(uploadsFolder))
                {
                    Directory.CreateDirectory(uploadsFolder);
                }

                var fileName = Path.GetFileName(avatarFile.FileName);
                var filePath = Path.Combine(uploadsFolder, fileName);

                if (!string.IsNullOrEmpty(existingUser.Avatar))
                {
                    var oldAvatarPath = Path.Combine(uploadsFolder, existingUser.Avatar);
                    if (System.IO.File.Exists(oldAvatarPath))
                    {
                        System.IO.File.Delete(oldAvatarPath);
                    }
                }

                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    await avatarFile.CopyToAsync(fileStream);
                }
                existingUser.Avatar = fileName;
            }

            // Xử lý mật khẩu mới (nếu có)
            if (!string.IsNullOrEmpty(newPassword))
            {
                var passwordHasher = new PasswordHasher<User>();
                existingUser.Password = passwordHasher.HashPassword(existingUser, newPassword);
            }

            // Lưu thay đổi
            try
            {
                _context.Update(existingUser);
                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "Thông tin đã được cập nhật thành công!";
            }
            catch (DbUpdateException ex)
            {
                ModelState.AddModelError("", $"Lỗi khi lưu thay đổi: {ex.InnerException?.Message}");
                return View(existingUser);
            }

            return RedirectToAction("Profile");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult UpdateProfile(User model, IFormFile avatarFile, int avatarFrameId, string newPassword)
        {
            if (ModelState.IsValid)
            {
                var user = _context.Users.FirstOrDefault(u => u.UserId == model.UserId);

                if (user != null)
                {
                    // Xử lý avatar
                    if (avatarFile != null && avatarFile.Length > 0)
                    {
                        var filePath = Path.Combine(_hostingEnvironment.WebRootPath, "uploads", "avatars", avatarFile.FileName);
                        using (var stream = new FileStream(filePath, FileMode.Create))
                        {
                            avatarFile.CopyTo(stream);
                        }
                        user.Avatar = avatarFile.FileName;
                    }

                    // Cập nhật khung viền avatar
                    user.AvatarFrameId = avatarFrameId;

                    // Cập nhật mật khẩu nếu có
                    if (!string.IsNullOrEmpty(newPassword))
                    {
                        user.Password = newPassword;  // Cần mã hóa mật khẩu trước khi lưu.
                    }

                    _context.SaveChanges();

                    TempData["SuccessMessage"] = "Profile updated successfully.";
                    return RedirectToAction("Profile");
                }
            }

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult UpdateRank(int userId, int selectedRankId)
        {
            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            if (user == null)
            {
                return NotFound();
            }

            // Cập nhật RankId mới
            user.RankId = selectedRankId;

            // Tìm Level hiện tại dựa trên ExpPoints trong tất cả Levels
            var currentLevel = _context.Levels
                .Where(l => l.ExpRequired <= (user.ExpPoints ?? 0))
                .OrderByDescending(l => l.ExpRequired)
                .FirstOrDefault();

            if (currentLevel != null)
            {
                // Tìm CategoryRank tương ứng với RankId mới và Level hiện tại
                var categoryRank = _context.CategoryRanks
                    .FirstOrDefault(cr => cr.RankId == selectedRankId && cr.CategoryRankId == currentLevel.CategoryRankId);

                if (categoryRank != null)
                {
                    user.CategoryRankId = categoryRank.CategoryRankId;
                    user.Level = currentLevel.LevelId;
                }
                else
                {
                    // Nếu không tìm thấy CategoryRank khớp với Level hiện tại, tìm CategoryRank phù hợp nhất trong Rank mới dựa trên ExpPoints
                    var matchingCategoryRank = _context.CategoryRanks
                        .Join(_context.Levels,
                            cr => cr.CategoryRankId,
                            l => l.CategoryRankId,
                            (cr, l) => new { CategoryRank = cr, Level = l })
                        .Where(x => x.CategoryRank.RankId == selectedRankId && x.Level.ExpRequired <= (user.ExpPoints ?? 0))
                        .OrderByDescending(x => x.Level.ExpRequired)
                        .Select(x => x.CategoryRank)
                        .FirstOrDefault();

                    if (matchingCategoryRank != null)
                    {
                        user.CategoryRankId = matchingCategoryRank.CategoryRankId;
                        user.Level = _context.Levels
                            .FirstOrDefault(l => l.CategoryRankId == matchingCategoryRank.CategoryRankId && l.ExpRequired <= (user.ExpPoints ?? 0))?.LevelId ?? 0;
                    }
                    else
                    {
                        // Nếu không có CategoryRank nào phù hợp, lấy CategoryRank thấp nhất trong Rank mới
                        var defaultCategoryRank = _context.CategoryRanks
                            .Where(cr => cr.RankId == selectedRankId)
                            .OrderBy(cr => cr.CategoryRankId)
                            .FirstOrDefault();
                        user.CategoryRankId = defaultCategoryRank?.CategoryRankId;
                        user.Level = 0;
                    }
                }
            }
            else
            {
                // Nếu không có Level nào phù hợp, lấy CategoryRank thấp nhất trong Rank mới
                var defaultCategoryRank = _context.CategoryRanks
                    .Where(cr => cr.RankId == selectedRankId)
                    .OrderBy(cr => cr.CategoryRankId)
                    .FirstOrDefault();
                user.CategoryRankId = defaultCategoryRank?.CategoryRankId;
                user.Level = 0;
            }

            _context.SaveChanges();

            TempData["SuccessMessage"] = "Rank và CategoryRank đã được cập nhật!";
            return RedirectToAction("Profile");
        }

        private void UpdateCategoryRankByExp(User user)
        {
            if (user == null) return;

            // Tìm level phù hợp với EXP của User
            var level = _context.Levels
                .Where(l => l.ExpRequired <= user.ExpPoints)
                .OrderByDescending(l => l.ExpRequired) // Lấy Level cao nhất phù hợp
                .FirstOrDefault();

            if (level != null)
            {
                // Cập nhật Level mới cho User
                user.Level = level.LevelId;

                // Cập nhật CategoryRank phù hợp với Level mới
                user.CategoryRankId = level.CategoryRankId;
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult UpdateAvatarFrame(int userId, int selectedFrameId)
        {
            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            if (user == null)
            {
                return NotFound();
            }

            user.AvatarFrameId = selectedFrameId;
            _context.SaveChanges();

            TempData["SuccessMessage"] = "Khung avatar đã được cập nhật thành công!";
            return RedirectToAction("Profile");
        }

        private bool UserExists(int id)
        {
            return _context.Users.Any(e => e.UserId == id);
        }

        //kiểm tra người dùng mua khung
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult PurchaseAvatarFrame(int avatarFrameId)
        {
            var userId = HttpContext.Session.GetInt32("UsersID");
            if (userId == null)
            {
                return RedirectToAction("Index", "Login");
            }

            var user = _context.Users.FirstOrDefault(u => u.UserId == userId);
            var avatarFrame = _context.AvatarFrames.FirstOrDefault(f => f.AvatarFrameId == avatarFrameId);

            if (user == null || avatarFrame == null)
            {
                return NotFound();
            }

            // Kiểm tra đã mua chưa
            var alreadyPurchased = _context.PurchasedAvatarFrames
                .Any(p => p.UserId == userId && p.AvatarFrameId == avatarFrameId);

            if (alreadyPurchased)
            {
                TempData["ErrorMessage"] = "Bạn đã sở hữu khung này!";
                return RedirectToAction("Profile");
            }

            // Tính giá sau khi giảm (giả sử VIP từ cấp 5 trở lên được giảm 10%)
            double discount = user.VipLevel >= 1 ? 0.9 : 1.0; // Giảm 10% nếu VIP >= 5
            double? finalPrice = avatarFrame.Price * discount;

            if (user.Coins < finalPrice)
            {
                TempData["ErrorMessage"] = "Bạn không đủ xu để mua khung này!";
                return RedirectToAction("Profile");
            }

            // Trừ xu và thêm khung
            user.Coins -= finalPrice;
            _context.PurchasedAvatarFrames.Add(new PurchasedAvatarFrame
            {
                UserId = userId.Value,
                AvatarFrameId = avatarFrameId,
                PurchasedAt = DateTime.Now
            });

            _context.SaveChanges();

            TempData["SuccessMessage"] = $"Mua khung thành công với giá {finalPrice} xu!";
            return RedirectToAction("Profile");
        }
    }
}
