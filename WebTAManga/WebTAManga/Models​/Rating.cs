using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Rating
{
    public int RatingId { get; set; }

    public int UserId { get; set; }

    public int StoryId { get; set; }

    public byte Rating1 { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual Story? Story { get; set; } = null!;

    public virtual User? User { get; set; } = null!;
}
