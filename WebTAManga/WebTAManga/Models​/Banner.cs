using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Banner
{
    public int Id { get; set; }

    public string? ImageUrl { get; set; }

    public string? Title { get; set; }

    public string? Description { get; set; }

    public string? LinkUrl { get; set; }

    public bool IsActive { get; set; }

    public int DisplayOrder { get; set; }
}
