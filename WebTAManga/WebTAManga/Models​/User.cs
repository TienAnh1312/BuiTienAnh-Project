using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class User
{
    public int UserId { get; set; }

    public string? Username { get; set; }

    public string? Email { get; set; }

    public string? Password { get; set; }

    public DateTime? CreatedAt { get; set; }

    public int? RankId { get; set; }

    public string? Avatar { get; set; }

    public double Level { get; set; }

    public double? ExpPoints { get; set; }

    public int? AvatarFrameId { get; set; }

    public double? Coins { get; set; }

    public int? CategoryRankId { get; set; }

    public int? ShakeCount { get; set; }

    public string? VerificationCode { get; set; }

    public bool IsEmailVerified { get; set; }

    public DateTime? VerificationCodeExpires { get; set; }

    public int VipLevel { get; set; }

    public double TotalRechargedCoins { get; set; }

    public string? ConfirmPassword { get; set; }

    public virtual AvatarFrame? AvatarFrame { get; set; }

    public virtual CategoryRank? CategoryRank { get; set; }

    public virtual ICollection<Comment> Comments { get; set; } = new List<Comment>();

    public virtual ICollection<ExpHistory> ExpHistories { get; set; } = new List<ExpHistory>();

    public virtual ICollection<Favorite> Favorites { get; set; } = new List<Favorite>();

    public virtual ICollection<FollowedStory> FollowedStories { get; set; } = new List<FollowedStory>();

    public virtual ICollection<Notification> Notifications { get; set; } = new List<Notification>();

    public virtual ICollection<PurchasedAvatarFrame> PurchasedAvatarFrames { get; set; } = new List<PurchasedAvatarFrame>();

    public virtual ICollection<PurchasedChapter> PurchasedChapters { get; set; } = new List<PurchasedChapter>();

    public virtual Rank? Rank { get; set; }

    public virtual ICollection<Rating> Ratings { get; set; } = new List<Rating>();

    public virtual ICollection<ReadingHistory> ReadingHistories { get; set; } = new List<ReadingHistory>();

    public virtual ICollection<Transaction> Transactions { get; set; } = new List<Transaction>();

    public virtual ICollection<UserDailyTask> UserDailyTasks { get; set; } = new List<UserDailyTask>();
}
