using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Notification
{
    public int NotificationId { get; set; }

    public int? UserId { get; set; }

    public string? Message { get; set; }

    public DateTime CreatedAt { get; set; }

    public bool IsRead { get; set; }

    public string? Link { get; set; }

    public int? CommentId { get; set; }

    public virtual Comment? Comment { get; set; }

    public virtual User? User { get; set; }
}
