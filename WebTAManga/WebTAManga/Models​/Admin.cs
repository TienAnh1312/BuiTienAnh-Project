using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Admin
{
    public int AdminId { get; set; }

    public string? Username { get; set; }

    public string? Email { get; set; }

    public string? Password { get; set; }

    public string? Role { get; set; }

    public DateTime? CreatedAt { get; set; }

    public int? RoleId { get; set; }

    public int? ManagerId { get; set; }

    public string? Area { get; set; }

    public bool? IsDepartmentHead { get; set; }

    public virtual ICollection<AdminLog> AdminLogs { get; set; } = new List<AdminLog>();

    public virtual ICollection<Admin> InverseManager { get; set; } = new List<Admin>();

    public virtual Admin? Manager { get; set; }

    public virtual ICollection<ManagerPermission> ManagerPermissionAdmins { get; set; } = new List<ManagerPermission>();

    public virtual ICollection<ManagerPermission> ManagerPermissionAssignedByNavigations { get; set; } = new List<ManagerPermission>();

    public virtual Role? RoleNavigation { get; set; }
}
