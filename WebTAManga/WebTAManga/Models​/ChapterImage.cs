using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class ChapterImage
{
    public int ImageId { get; set; }

    public int ChapterId { get; set; }

    public string ImageUrl { get; set; } = null!;

    public int PageNumber { get; set; }

    public int? StoryId { get; set; }

    public virtual Chapter? Chapter { get; set; } = null!;
}
