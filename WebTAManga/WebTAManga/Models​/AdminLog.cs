using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class AdminLog
{
    public int LogId { get; set; }

    public int AdminId { get; set; }

    public string Action { get; set; } = null!;

    public int? TargetId { get; set; }

    public string? TargetTable { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual Admin? Admin { get; set; } = null!;
}
