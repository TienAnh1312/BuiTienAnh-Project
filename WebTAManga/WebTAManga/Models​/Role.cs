﻿using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Role
{
    public int RoleId { get; set; }

    public string? RoleName { get; set; }

    public string? Description { get; set; }

    public virtual ICollection<Admin> Admins { get; set; } = new List<Admin>();
}
