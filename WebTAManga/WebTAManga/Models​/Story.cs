using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Story
{
    public int StoryId { get; set; }

    public string? Title { get; set; }

    public string? Author { get; set; }

    public string? Description { get; set; }

    public string? CoverImage { get; set; }

    public DateTime? CreatedAt { get; set; }

    public bool IsCompleted { get; set; }

    public DateTime? LastUpdatedAt { get; set; }

    public bool IsHot { get; set; }

    public bool IsNew { get; set; }

    public virtual ICollection<Chapter> Chapters { get; set; } = new List<Chapter>();

    public virtual ICollection<Comment> Comments { get; set; } = new List<Comment>();

    public virtual ICollection<Favorite> Favorites { get; set; } = new List<Favorite>();

    public virtual ICollection<FollowedStory> FollowedStories { get; set; } = new List<FollowedStory>();

    public virtual ICollection<Rating> Ratings { get; set; } = new List<Rating>();

    public virtual ICollection<ReadingHistory> ReadingHistories { get; set; } = new List<ReadingHistory>();

    public virtual ICollection<StoryGenre> StoryGenres { get; set; } = new List<StoryGenre>();
}
