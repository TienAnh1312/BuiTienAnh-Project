using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class CategoryRank
{
    public int CategoryRankId { get; set; }

    public string? Name { get; set; }

    public int? RankId { get; set; }

    public DateTime? CreateAt { get; set; }

    public DateTime? UpdateAt { get; set; }

    public virtual ICollection<Level> Levels { get; set; } = new List<Level>();

    public virtual Rank? Rank { get; set; }

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
