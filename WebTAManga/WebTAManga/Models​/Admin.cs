using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Admin
{
    public int AdminId { get; set; }

    public string? Username { get; set; } = null!;

    public string? Email { get; set; } = null!;

    public string? Password { get; set; } = null!;

    public string? Role { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual ICollection<AdminLog> AdminLogs { get; set; } = new List<AdminLog>();
}
