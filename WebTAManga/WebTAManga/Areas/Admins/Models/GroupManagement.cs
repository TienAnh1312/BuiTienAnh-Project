using Microsoft.AspNetCore.Mvc.Rendering;
using WebTAManga.Models;
using System.ComponentModel;

namespace WebTAManga.Areas.Admins.Models
{
    public class GroupManagement
    {
        public List<Role> Roles { get; set; } = new List<Role>();
        public List<Admin> Managers { get; set; } = new List<Admin>();
        public List<Admin> Admins { get; set; } = new List<Admin>();

        [DisplayName("Danh sách vai trò")]
        public SelectList RoleList { get; set; }

        [DisplayName("Danh sách trưởng nhóm")]
        public SelectList ManagerList { get; set; }

        public int? RoleId { get; set; }

        public int? ManagerId { get; set; 
}
        public int? AdminId { get; set; }
    }
}