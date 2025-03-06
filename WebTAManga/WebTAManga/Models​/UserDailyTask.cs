using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class UserDailyTask
{
    public int UserTaskId { get; set; }

    public int? UserId { get; set; }

    public int? TaskId { get; set; }

    public bool IsCompleted { get; set; }

    public DateTime? CompletedAt { get; set; }

    public DateOnly TaskDate { get; set; }

    public virtual DailyTask? Task { get; set; }

    public virtual User? User { get; set; }
}
