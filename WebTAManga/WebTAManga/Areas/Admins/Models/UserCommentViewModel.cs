using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Models
{
    public class UserCommentViewModel
    {
        public User User { get; set; }
        public List<Story> Stories { get; set; }
    }

}
