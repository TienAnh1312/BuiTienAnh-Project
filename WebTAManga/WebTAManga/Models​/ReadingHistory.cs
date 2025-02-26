using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class ReadingHistory
{
    public int HistoryId { get; set; }

    public int UserId { get; set; }

    public int StoryId { get; set; }

    public int ChapterId { get; set; }

    public DateTime? LastReadAt { get; set; }

    public DateTime? StartTime { get; set; }

    public DateTime? EndTime { get; set; }

    public virtual Chapter? Chapter { get; set; } = null!;

    public virtual Story? Story { get; set; } = null!;

    public virtual User? User { get; set; } = null!;
}
