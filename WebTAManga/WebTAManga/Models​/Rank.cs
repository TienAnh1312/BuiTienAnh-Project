using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Rank
{
    public int RankId { get; set; }

    public string? Name { get; set; }

    public virtual ICollection<CategoryRank> CategoryRanks { get; set; } = new List<CategoryRank>();

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
