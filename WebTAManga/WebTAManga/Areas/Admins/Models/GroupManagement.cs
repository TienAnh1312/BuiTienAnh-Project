using Microsoft.AspNetCore.Mvc.Rendering;
using WebTAManga.Models;

namespace WebTAManga.Areas.Admins.Models
{
    public class GroupManagement
    {
        public List<Role> Roles { get; set; } = new List<Role>();
        public List<Admin> Managers { get; set; } = new List<Admin>();
        public List<Admin> Admins { get; set; } = new List<Admin>();
        public SelectList RoleList { get; set; }
        public SelectList ManagerList { get; set; }
    }
}
