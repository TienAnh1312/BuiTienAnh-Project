using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class PurchasedAvatarFrame
{
    public int PurchasedAvatarFrameId { get; set; }

    public int? UserId { get; set; }

    public int? AvatarFrameId { get; set; }

    public DateTime PurchasedAt { get; set; }

    public virtual AvatarFrame? AvatarFrame { get; set; }

    public virtual User? User { get; set; }
}
