using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class RankCategory
{
    public int CategoryId { get; set; }

    public string? Name { get; set; } = null!;

    public virtual ICollection<Rank> Ranks { get; set; } = new List<Rank>();
}
