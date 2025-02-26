using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class ExpHistory
{
    public int ExpHistoryId { get; set; }

    public int UserId { get; set; }

    public int ExpAmount { get; set; }

    public string? Reason { get; set; } = null!;

    public DateTime? CreatedAt { get; set; }

    public virtual User? User { get; set; } = null!;
}
