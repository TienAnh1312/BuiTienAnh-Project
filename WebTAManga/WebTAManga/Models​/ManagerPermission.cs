using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class ManagerPermission
{
    public int PermissionId { get; set; }

    public int AdminId { get; set; }

    public string? Module { get; set; } = null!;

    public bool? CanView { get; set; }

    public bool? CanEdit { get; set; }

    public bool? CanCreate { get; set; }

    public bool? CanDelete { get; set; }

    public int AssignedBy { get; set; }

    public DateTime AssignedAt { get; set; }

    public virtual Admin? Admin { get; set; } = null!;

    public virtual Admin? AssignedByNavigation { get; set; } = null!;
}
