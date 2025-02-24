using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Rank
{
    public int RankId { get; set; }

    public string? Name { get; set; } = null!;

    public double MinExp { get; set; }

    public int CategoryId { get; set; }

    public virtual RankCategory? Category { get; set; } = null!;

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
