using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class DailyTask
{
    public int TaskId { get; set; }

    public string? TaskName { get; set; } = null!;

    public string? Description { get; set; } = null!;

    public int ExpReward { get; set; }

    public int CoinReward { get; set; }

    public int ShakeReward { get; set; }

    public virtual ICollection<UserDailyTask> UserDailyTasks { get; set; } = new List<UserDailyTask>();
}
