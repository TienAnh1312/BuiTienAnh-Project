﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Areas.Admins.Filters;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    [Authorize(Roles = "SuperAdmin, ContentManager")]

    public class StoriesController : BaseController
    {
        private readonly WebMangaContext _context;
        private const int PageSize = 7; 

        public StoriesController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Stories
        [PermissionAuthorize("Stories", "View")]
        public async Task<IActionResult> Index(string searchTitle, string searchAuthor, string filter, int? searchGenre, int page = 1)
        {
            var stories = from s in _context.Stories
                          select s;

            // Áp dụng bộ lọc tìm kiếm
            if (!string.IsNullOrEmpty(searchTitle))
            {
                stories = stories.Where(s => s.Title.Contains(searchTitle));
            }

            if (!string.IsNullOrEmpty(searchAuthor))
            {
                stories = stories.Where(s => s.Author.Contains(searchAuthor));
            }

            // Áp dụng bộ lọc trạng thái
            switch (filter)
            {
                case "completed":
                    stories = stories.Where(s => s.IsCompleted);
                    break;
                case "updating":
                    stories = stories.Where(s => !s.IsCompleted);
                    break;
                case "hot":
                    stories = stories.Where(s => s.IsHot);
                    break;
                case "new":
                    var oneMonthAgo = DateTime.Now.AddMonths(-1);
                    stories = stories.Where(s => s.CreatedAt >= oneMonthAgo);
                    break;
            }

            // Sắp xếp theo LastUpdatedAt (nếu null thì dùng CreatedAt)
            stories = stories.OrderByDescending(s => s.LastUpdatedAt ?? s.CreatedAt);

            // Phân trang
            int totalItems = await stories.CountAsync();
            int totalPages = (int)Math.Ceiling(totalItems / (double)PageSize);

            var pagedStories = await stories
                .Skip((page - 1) * PageSize)
                .Take(PageSize)
                .ToListAsync();

            var viewModel = new StoryIndexView
            {
                Stories = pagedStories,
                CurrentPage = page,
                TotalPages = totalPages,
                SearchTitle = searchTitle,
                SearchAuthor = searchAuthor,
                Filter = filter,
                SearchGenre = searchGenre 
            };

            return View(viewModel);
        }

        // GET: Admins/Stories/Details/5
        [PermissionAuthorize("Stories", "View")]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var story = await _context.Stories
                .Include(s => s.Chapters)
                .FirstOrDefaultAsync(m => m.StoryId == id);

            if (story == null)
            {
                return NotFound();
            }

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Details", story);
            }
            return View(story);
        }

        // GET: Admins/Stories/Create
        [PermissionAuthorize("Stories", "Create")]
        public IActionResult Create()
        {
            ViewData["Genres"] = new SelectList(_context.Genres, "GenreId", "Name");
            return View();
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        [PermissionAuthorize("Stories", "Create")]
        public async Task<IActionResult> Create([Bind("StoryCode,Title,Author,Description,CoverImage,CreatedAt,IsCompleted,LastUpdatedAt,IsHot,IsNew")] Story story, int[] selectedGenres)
        {
            if (ModelState.IsValid)
            {
                // Kiểm tra trùng StoryCode
                var existingStory = await _context.Stories
                    .FirstOrDefaultAsync(s => s.StoryCode == story.StoryCode && s.StoryId != story.StoryId);

                if (existingStory != null)
                {
                    ModelState.AddModelError("StoryCode", "Mã truyện này đã tồn tại.");
                }

                if (!ModelState.IsValid)
                {
                    ViewData["Genres"] = new SelectList(_context.Genres, "GenreId", "Name");
                    return View(story);
                }

                // Tạo thư mục cho Story với tên "Title(StoryCode)"
                var storyFolderName = $"{story.Title}({story.StoryCode})";
                var storyFolderPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "stories", storyFolderName);
                if (!Directory.Exists(storyFolderPath))
                {
                    Directory.CreateDirectory(storyFolderPath);
                }

                // Xử lý ảnh bìa
                var files = HttpContext.Request.Form.Files;
                if (files.Count() > 0 && files[0].Length > 0)
                {
                    var file = files[0];
                    var fileName = file.FileName;
                    var path = Path.Combine(storyFolderPath, fileName);
                    using (var stream = new FileStream(path, FileMode.Create))
                    {
                        file.CopyTo(stream);
                        story.CoverImage = $"images/admins/stories/{storyFolderName}/{fileName}";
                    }
                }

                story.CreatedAt = DateTime.Now;
                _context.Add(story);
                await _context.SaveChangesAsync();

                // Thêm thể loại
                foreach (var genreId in selectedGenres)
                {
                    _context.StoryGenres.Add(new StoryGenre { StoryId = story.StoryId, GenreId = genreId });
                }
                await _context.SaveChangesAsync();

                return RedirectToAction(nameof(Index));
            }

            ViewData["Genres"] = new SelectList(_context.Genres, "GenreId", "Name");
            return View(story);
        }

        // GET: Admins/Stories/Edit/5
        [PermissionAuthorize("Stories", "Edit")]

        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var story = await _context.Stories
                .Include(s => s.StoryGenres) // Lấy thể loại
                .Include(s => s.Chapters)    // Load danh sách Chapters
                .FirstOrDefaultAsync(m => m.StoryId == id);

            if (story == null)
            {
                return NotFound();
            }

            var selectedGenres = story.StoryGenres?.Select(sg => sg.GenreId).ToList() ?? new List<int?>();
            Console.WriteLine("Selected Genres: " + string.Join(", ", selectedGenres)); // Debug

            ViewData["Genres"] = await _context.Genres.ToListAsync();
            ViewData["SelectedGenres"] = selectedGenres;

            return View(story);
        }

        // POST: Admins/Stories/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [PermissionAuthorize("Stories", "Edit")]
        public async Task<IActionResult> Edit(int id, [Bind("StoryId,StoryCode,Title,Author,Description,CoverImage,CreatedAt,IsCompleted,LastUpdatedAt,IsHot,IsNew")] Story story, int[] selectedGenres, IFormFile? newCoverImage)
        {
            if (id != story.StoryId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    // Kiểm tra trùng StoryCode
                    var existingStoryWithCode = await _context.Stories
                        .FirstOrDefaultAsync(s => s.StoryCode == story.StoryCode && s.StoryId != story.StoryId);
                    if (existingStoryWithCode != null)
                    {
                        ModelState.AddModelError("StoryCode", "Mã truyện này đã tồn tại.");
                        ViewData["Genres"] = _context.Genres.ToList();
                        ViewData["SelectedGenres"] = selectedGenres;
                        return View(story);
                    }

                    // Lấy thông tin truyện gốc để so sánh
                    var originalStory = await _context.Stories
                        .AsNoTracking()
                        .FirstOrDefaultAsync(s => s.StoryId == id);
                    if (originalStory == null)
                    {
                        return NotFound();
                    }

                    // Kiểm tra nếu có ảnh mới
                    if (newCoverImage != null && newCoverImage.Length > 0)
                    {
                        var fileName = newCoverImage.FileName;
                        var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "stories", fileName);
                        using (var stream = new FileStream(path, FileMode.Create))
                        {
                            await newCoverImage.CopyToAsync(stream);
                        }
                        story.CoverImage = "images/admins/stories/" + fileName;
                    }
                    else
                    {
                        story.CoverImage = originalStory.CoverImage; // Giữ ảnh cũ nếu không upload ảnh mới
                    }

                    // Giữ nguyên CreatedAt, cập nhật LastUpdatedAt
                    story.CreatedAt = originalStory.CreatedAt;
                    story.LastUpdatedAt = DateTime.Now;

                    // Cập nhật thông tin Story
                    _context.Update(story);
                    await _context.SaveChangesAsync();

                    // Nếu StoryCode thay đổi, cập nhật tất cả ChapterCode và PurchasedChapters
                    if (originalStory.StoryCode != story.StoryCode)
                    {
                        var chapters = await _context.Chapters
                            .Where(c => c.StoryId == story.StoryId)
                            .ToListAsync();

                        // Khai báo danh sách allPurchasedChapters ở phạm vi ngoài vòng lặp
                        var allPurchasedChapters = new List<PurchasedChapter>();

                        foreach (var chapter in chapters)
                        {
                            var chapterNumber = int.Parse(chapter.ChapterTitle.Replace("Chương ", ""));
                            var oldChapterCode = chapter.ChapterCode; // Lưu mã cũ để tìm trong PurchasedChapters
                            chapter.ChapterCode = $"{story.StoryCode}_C{chapterNumber}"; // Cập nhật ChapterCode mới

                            // Tìm và cập nhật PurchasedChapters
                            var purchasedChapters = await _context.PurchasedChapters
                                .Where(pc => pc.ChapterCode == oldChapterCode)
                                .ToListAsync();

                            foreach (var purchasedChapter in purchasedChapters)
                            {
                                purchasedChapter.ChapterCode = chapter.ChapterCode; // Cập nhật sang mã mới
                            }

                            // Thêm vào danh sách tổng
                            allPurchasedChapters.AddRange(purchasedChapters);
                        }

                        // Cập nhật cả Chapters và PurchasedChapters trong database
                        _context.Chapters.UpdateRange(chapters);
                        if (allPurchasedChapters.Any())
                        {
                            _context.PurchasedChapters.UpdateRange(allPurchasedChapters);
                        }
                        await _context.SaveChangesAsync();
                    }

                    // Xóa các thể loại cũ
                    var existingGenres = _context.StoryGenres.Where(sg => sg.StoryId == id);
                    _context.StoryGenres.RemoveRange(existingGenres);
                    await _context.SaveChangesAsync();

                    // Thêm các thể loại mới
                    foreach (var genreId in selectedGenres)
                    {
                        _context.StoryGenres.Add(new StoryGenre
                        {
                            StoryId = id,
                            GenreId = genreId
                        });
                    }
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!StoryExists(story.StoryId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }

                return RedirectToAction(nameof(Index));
            }

            ViewData["Genres"] = _context.Genres.ToList();
            ViewData["SelectedGenres"] = selectedGenres;
            return View(story);
        }

        // GET: Admins/Stories/Delete/5
        [PermissionAuthorize("Stories", "Delete")]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var story = await _context.Stories
                .FirstOrDefaultAsync(m => m.StoryId == id);
            if (story == null)
            {
                return NotFound();
            }

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_Delete", story);
            }
            return View(story);
        }

        // POST: Admins/Stories/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        [PermissionAuthorize("Stories", "Delete")]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var story = await _context.Stories
                .Include(s => s.Chapters)
                .ThenInclude(c => c.ChapterImages)
                .FirstOrDefaultAsync(s => s.StoryId == id);

            if (story == null)
            {
                if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                {
                    return Json(new { success = false, message = "Không tìm thấy truyện." });
                }   
                return NotFound();
            }

            try
            {
                // Xóa ảnh bìa
                if (!string.IsNullOrEmpty(story.CoverImage))
                {
                    var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", story.CoverImage);
                    if (System.IO.File.Exists(filePath))
                    {
                        System.IO.File.Delete(filePath);
                    }
                }

                // Xóa ảnh chương
                foreach (var chapter in story.Chapters)
                {
                    foreach (var image in chapter.ChapterImages)
                    {
                        var imagePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", image.ImageUrl);
                        if (System.IO.File.Exists(imagePath))
                        {
                            System.IO.File.Delete(imagePath);
                        }
                    }
                    _context.ChapterImages.RemoveRange(chapter.ChapterImages);
                }

                // Xóa chương
                _context.Chapters.RemoveRange(story.Chapters);

                // Xóa truyện
                _context.Stories.Remove(story);
                await _context.SaveChangesAsync();

                if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                {
                    return Json(new { success = true });
                }
                TempData["Success"] = "Truyện đã được xóa thành công.";
                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
                {
                    return Json(new { success = false, message = "Lỗi khi xóa truyện: " + ex.Message });
                }
                TempData["Error"] = "Lỗi khi xóa truyện: " + ex.Message;
                return RedirectToAction(nameof(Index));
            }
        }

        private bool StoryExists(int id)
        {
            return _context.Stories.Any(e => e.StoryId == id);
        }

        //hiển thị ảnh detail
        public async Task<IActionResult> GetChapterImages(int chapterId)
        {
            var chapterImages = await _context.ChapterImages
                .Where(ci => ci.ChapterId == chapterId)
                .ToListAsync();

            if (chapterImages == null || chapterImages.Count == 0)
            {
                return NotFound();
            }

            return PartialView("_ChapterImagesPartial", chapterImages);
        }

    }
    // View model cho phân trang và tìm kiếm
    public class StoryIndexView
    {
        public List<Story> Stories { get; set; }
        public int CurrentPage { get; set; }
        public int TotalPages { get; set; }
        public string SearchTitle { get; set; }
        public string SearchAuthor { get; set; }
        public string Filter { get; set; }
        public int? SearchGenre { get; set; }
    }
}
