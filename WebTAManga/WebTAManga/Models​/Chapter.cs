using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Chapter
{
    public int ChapterId { get; set; }

    public int? StoryId { get; set; }

    public string? ChapterTitle { get; set; }

    public DateTime? CreatedAt { get; set; }

    public bool? IsLocked { get; set; }

    public double? Coins { get; set; }

    public bool? IsUnlocked { get; set; }

    public string? ChapterCode { get; set; }

    public string? UpdateAt { get; set; }

    public virtual ICollection<ChapterImage> ChapterImages { get; set; } = new List<ChapterImage>();

    public virtual ICollection<Comment> Comments { get; set; } = new List<Comment>();

    public virtual ICollection<FollowedStory> FollowedStories { get; set; } = new List<FollowedStory>();

    public virtual ICollection<PurchasedChapter> PurchasedChapters { get; set; } = new List<PurchasedChapter>();

    public virtual ICollection<ReadingHistory> ReadingHistories { get; set; } = new List<ReadingHistory>();

    public virtual Story? Story { get; set; }
}
