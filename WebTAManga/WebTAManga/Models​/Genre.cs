using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Genre
{
    public int GenreId { get; set; }

    public string? Name { get; set; }

    public string? Title { get; set; }

    public DateTime? CreateAt { get; set; }

    public DateTime? UpdateAt { get; set; }

    public virtual ICollection<StoryGenre> StoryGenres { get; set; } = new List<StoryGenre>();
}
