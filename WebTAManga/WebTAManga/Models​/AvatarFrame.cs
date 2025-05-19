using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class AvatarFrame
{
    public int AvatarFrameId { get; set; }

    public string? Name { get; set; }

    public string? ImagePath { get; set; }

    public double? Price { get; set; }

    public DateTime? CreateAt { get; set; }

    public DateTime? UpdateAt { get; set; }

    public virtual ICollection<PurchasedAvatarFrame> PurchasedAvatarFrames { get; set; } = new List<PurchasedAvatarFrame>();

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
