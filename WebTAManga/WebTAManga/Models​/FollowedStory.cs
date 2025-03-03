using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class FollowedStory
{
    public int FollowId { get; set; }

    public int UserId { get; set; }

    public int StoryId { get; set; }

    public DateTime? FollowedAt { get; set; }

    public int? LastReadChapterId { get; set; }

    public virtual Chapter? LastReadChapter { get; set; }

    public virtual Story? Story { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
