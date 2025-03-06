using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class StoryGenre
{
    public int StoryGenreId { get; set; }

    public int? StoryId { get; set; }

    public int? GenreId { get; set; }

    public virtual Genre? Genre { get; set; }

    public virtual Story? Story { get; set; }
}
