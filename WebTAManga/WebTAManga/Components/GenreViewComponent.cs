using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebTAManga.Models;

namespace WebTAManga.Components
{
    public class GenreViewComponent : ViewComponent
    {
        private readonly WebMangaContext _context;

        public GenreViewComponent(WebMangaContext context)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context)); // Kiểm tra null
        }

        public async Task<IViewComponentResult> InvokeAsync()
        {
            var genres = await _context.Genres.ToListAsync() ?? new List<Genre>(); // Trả về danh sách rỗng nếu null
            return View(genres);
        }
    }
}
