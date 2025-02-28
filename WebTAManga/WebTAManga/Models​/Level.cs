using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Level
{
    public int LevelId { get; set; }

    public int ExpRequired { get; set; }

    public int CategoryRankId { get; set; }

    public virtual CategoryRank? CategoryRank { get; set; } = null!;
}
