using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Genre
{
    public int GenreId { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<StoryGenre> StoryGenres { get; set; } = new List<StoryGenre>();
}
