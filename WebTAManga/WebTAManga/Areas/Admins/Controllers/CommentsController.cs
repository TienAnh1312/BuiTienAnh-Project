using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Areas.Admins.Models;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Controllers
{
    
    public class CommentsController : BaseController
    {
        private readonly WebMangaContext _context;

        public CommentsController(WebMangaContext context)
        {
            _context = context;
        }

        // GET: Admins/Comments
        public async Task<IActionResult> Index()
        {
            var usersWithCommentCount = await _context.Users
                .Where(u => u.Comments.Any()) // Lọc user có bình luận
                .Select(u => new
                {
                    u.UserId,
                    u.Username,
                    u.Email,
                    CommentCount = u.Comments.Count()
                })
                .ToListAsync();

            return View(usersWithCommentCount);
        }


        // GET: Admins/Comments/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            var stories = await _context.Comments
                .Where(c => c.UserId == id)
                .Select(c => c.Story)
                .Distinct()
                .ToListAsync();

            var viewModel = new UserCommentViewModel
            {
                User = user,
                Stories = stories
            };
            
            return View(viewModel);
        }


        // GET: Admins/Comments/Create
        public IActionResult Create()
        {
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId");
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId");
            return View();
        }

        // POST: Admins/Comments/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("CommentId,UserId,StoryId,Content,CreatedAt")] Comment comment)
        {
            if (ModelState.IsValid)
            {
                _context.Add(comment);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId", comment.StoryId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", comment.UserId);
            return View(comment);
        }

        // GET: Admins/Comments/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var comment = await _context.Comments.FindAsync(id);
            if (comment == null)
            {
                return NotFound();
            }
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId", comment.StoryId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", comment.UserId);
            return View(comment);
        }

        // POST: Admins/Comments/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("CommentId,UserId,StoryId,Content,CreatedAt")] Comment comment)
        {
            if (id != comment.CommentId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(comment);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!CommentExists(comment.CommentId))
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
            ViewData["StoryId"] = new SelectList(_context.Stories, "StoryId", "StoryId", comment.StoryId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", comment.UserId);
            return View(comment);
        }

        // GET: Admins/Comments/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var comment = await _context.Comments
                .Include(c => c.Story)
                .Include(c => c.User)
                .FirstOrDefaultAsync(m => m.CommentId == id);
            if (comment == null)
            {
                return NotFound();
            }

            return View(comment);
        }

        // POST: Admins/Comments/DeleteMultiple
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteMultiple(int[] commentIds, string returnUrl = null)
        {
            if (commentIds == null || !commentIds.Any())
            {
                TempData["ErrorMessage"] = "Vui lòng chọn ít nhất một bình luận để xóa.";
                return RedirectToAction(nameof(Index));
            }

            try
            {
                // Cập nhật các comment con trước khi xóa
                var childComments = await _context.Comments
                    .Where(c => commentIds.Contains((int)c.ParentCommentId))
                    .ToListAsync();

                foreach (var comment in childComments)
                {
                    comment.ParentCommentId = null;
                }

                // Lấy các comment cần xóa
                var commentsToDelete = await _context.Comments
                    .Where(c => commentIds.Contains(c.CommentId))
                    .ToListAsync();

                if (!commentsToDelete.Any())
                {
                    TempData["ErrorMessage"] = "Không tìm thấy bình luận nào để xóa.";
                    return RedirectToAction(nameof(Index));
                }

                _context.Comments.RemoveRange(commentsToDelete);
                await _context.SaveChangesAsync();

                TempData["SuccessMessage"] = $"Đã xóa thành công {commentsToDelete.Count} bình luận.";

                // Quay lại trang trước nếu có returnUrl
                if (!string.IsNullOrEmpty(returnUrl) && Url.IsLocalUrl(returnUrl))
                {
                    return Redirect(returnUrl);
                }

                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = "Có lỗi xảy ra khi xóa bình luận: " + ex.Message;
                return RedirectToAction(nameof(Index));
            }
        }

        private bool CommentExists(int id)
        {
            return _context.Comments.Any(e => e.CommentId == id);
        }

        //hiển thị bình luận của user trong một story
        public async Task<IActionResult> UserStoryComments(int userId, int storyId)
        {
            var comments = await _context.Comments
                .Where(c => c.UserId == userId && c.StoryId == storyId)
                .ToListAsync();

            var viewModel = new UserStoryCommentsViewModel
            {
                Comments = comments,
                Story = await _context.Stories.FindAsync(storyId),
                User = await _context.Users.FindAsync(userId)
            };

            return View(viewModel);
        }

    }
}
