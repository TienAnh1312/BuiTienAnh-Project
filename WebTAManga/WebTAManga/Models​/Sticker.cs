using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Sticker
{
    public int StickerId { get; set; }

    public string? Name { get; set; } = null!;

    public string? ImagePath { get; set; } = null!;

    public virtual ICollection<Comment> Comments { get; set; } = new List<Comment>();
}
