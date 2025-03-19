using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class PurchasedChapter
{
    public int PurchasedChapterId { get; set; }

    public int? UserId { get; set; }

    public int? ChapterId { get; set; }

    public DateTime? PurchasedAt { get; set; }

    public string? ChapterCode { get; set; }

    public virtual Chapter? Chapter { get; set; }

    public virtual User? User { get; set; }
}
