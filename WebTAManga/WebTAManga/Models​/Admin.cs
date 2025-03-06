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

    public virtual ICollection<AdminLog> AdminLogs { get; set; } = new List<AdminLog>();
}
