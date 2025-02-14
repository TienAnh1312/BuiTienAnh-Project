using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Models
{
    public class UserStoryCommentsViewModel
    {
        public User User { get; set; }
        public Story Story { get; set; }
        public List<Comment> Comments { get; set; }
    }
}
