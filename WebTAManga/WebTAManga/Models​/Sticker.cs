using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Sticker
{
    public int StickerId { get; set; }

    public string? Name { get; set; }

    public string? ImagePath { get; set; }

    public virtual ICollection<Comment> Comments { get; set; } = new List<Comment>();
}
