﻿using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class User
{
    public int UserId { get; set; }

    public string Username { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Password { get; set; } = null!;

    public DateTime? CreatedAt { get; set; }

    public virtual ICollection<Comment> Comments { get; set; } = new List<Comment>();

    public virtual ICollection<Favorite> Favorites { get; set; } = new List<Favorite>();

    public virtual ICollection<FollowedStory> FollowedStories { get; set; } = new List<FollowedStory>();

    public virtual ICollection<Rating> Ratings { get; set; } = new List<Rating>();

    public virtual ICollection<ReadingHistory> ReadingHistories { get; set; } = new List<ReadingHistory>();
}
