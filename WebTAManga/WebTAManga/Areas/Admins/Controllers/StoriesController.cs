using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    
    public class StoriesController : BaseController
    {
        private readonly WebMangaContext _context;

        public StoriesController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Stories
        public async Task<IActionResult> Index()
        {
            return View(await _context.Stories.ToListAsync());
        }

        // GET: Admins/Stories/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var story = await _context.Stories
                .Include(s => s.Chapters) // Chỉ load danh sách Chapters
                .FirstOrDefaultAsync(m => m.StoryId == id);

            if (story == null)
            {
                return NotFound();
            }

            return View(story);
        }

        // GET: Admins/Stories/Create
        public IActionResult Create()
        {
            ViewData["Genres"] = new SelectList(_context.Genres, "GenreId", "Name");
            return View();
        }


        // POST: Admins/Stories/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("StoryId,Title,Author,Description,CoverImage,CreatedAt,IsCompleted,LastUpdatedAt,IsHot,IsNew")] Story story, int[] selectedGenres)
        {
            if (ModelState.IsValid)
            {
                // Kiểm tra trùng lặp Code khi sửa
                var existingProductByCode = await _context.Stories
                    .FirstOrDefaultAsync(p => p.Title == story.Title && p.StoryId != story.StoryId);

                if (existingProductByCode != null)
                {
                    ModelState.AddModelError("Code", "Sản phẩm này đã tồn tại.");
                }

                if (!ModelState.IsValid)
                {
                    return View(story);
                }

                // Xử lý ảnh, nếu có ảnh mới
                var files = HttpContext.Request.Form.Files;
                if (files.Count() > 0 && files[0].Length > 0)
                {
                    var file = files[0];
                    var fileName = file.FileName;
                    var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "stories", fileName);

                    using (var stream = new FileStream(path, FileMode.Create))
                    {
                        file.CopyTo(stream);
                        story.CoverImage = "images/admins/stories/" + fileName; // Lưu đường dẫn ảnh
                    }
                }

                // Thiết lập ngày tạo và ngày cập nhật tự động
                story.CreatedAt = DateTime.Now;

                // Thêm sản phẩm vào cơ sở dữ liệu
                _context.Add(story);
                await _context.SaveChangesAsync();

                // Thêm vào bảng StoryGenre
                foreach (var genreId in selectedGenres)
                {
                    _context.StoryGenres.Add(new StoryGenre
                    {
                        StoryId = story.StoryId,
                        GenreId = genreId
                    });
                }
                await _context.SaveChangesAsync();

                return RedirectToAction(nameof(Index));
            }

            ViewData["Genres"] = new SelectList(_context.Genres, "GenreId", "Name");
            return View(story);
        }

        // GET: Admins/Stories/Edit/5
       
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var story = await _context.Stories
                .Include(s => s.StoryGenres) //lấy thể loại story
                .Include(s => s.Chapters) // Load danh sách Chapters
                .FirstOrDefaultAsync(m => m.StoryId == id);

            if (story == null)
            {
                return NotFound();
            }

            // Lấy danh sách thể loại đã chọn
            var selectedGenres = story.StoryGenres.Select(sg => sg.GenreId).ToList();

            ViewData["Genres"] = _context.Genres.ToList();
            ViewData["SelectedGenres"] = selectedGenres;

            return View(story);
        }


        // POST: Admins/Stories/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("StoryId,Title,Author,Description,CoverImage,CreatedAt,IsCompleted,LastUpdatedAt,IsHot,IsNew")] Story story, int[] selectedGenres, IFormFile? newCoverImage)
        {
            if (id != story.StoryId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    // Kiểm tra nếu có ảnh mới
                    if (newCoverImage != null && newCoverImage.Length > 0)
                    {
                        var fileName = newCoverImage.FileName;
                        var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "admins", "stories", fileName);

                        using (var stream = new FileStream(path, FileMode.Create))
                        {
                            await newCoverImage.CopyToAsync(stream);
                        }

                        story.CoverImage = "images/admins/stories/" + fileName; // Cập nhật ảnh mới
                    }
                    else
                    {
                        // Nếu không chọn ảnh mới, giữ ảnh cũ
                        var existingStory = await _context.Stories.AsNoTracking().FirstOrDefaultAsync(s => s.StoryId == id);
                        if (existingStory != null)
                        {
                            story.CoverImage = existingStory.CoverImage;
                        }
                    }

                   
                    var originalStory = await _context.Stories.AsNoTracking().FirstOrDefaultAsync(s => s.StoryId == id);
                    if (originalStory != null)
                    {
                        story.CreatedAt = originalStory.CreatedAt; // Giữ nguyên ngày tạo
                    }
                    story.LastUpdatedAt = DateTime.Now; 

                    // Cập nhật thông tin Story
                    _context.Update(story);
                    await _context.SaveChangesAsync();

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

            return View(story);
        }

        // POST: Admins/Stories/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var story = await _context.Stories.FindAsync(id);
            if (story != null)
            {
                _context.Stories.Remove(story);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
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
}
