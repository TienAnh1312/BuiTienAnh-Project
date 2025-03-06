using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Comment
{
    public int CommentId { get; set; }

    public int? UserId { get; set; }

    public int? StoryId { get; set; }

    public string? Content { get; set; }

    public DateTime? CreatedAt { get; set; }

    public int? ParentCommentId { get; set; }

    public int? StickerId { get; set; }

    public virtual ICollection<Comment> InverseParentComment { get; set; } = new List<Comment>();

    public virtual Comment? ParentComment { get; set; }

    public virtual Sticker? Sticker { get; set; }

    public virtual Story? Story { get; set; }

    public virtual User? User { get; set; }
}
