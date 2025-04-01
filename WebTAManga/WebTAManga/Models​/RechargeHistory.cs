using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class RechargeHistory
{
    public int RechargeId { get; set; }

    public int? UserId { get; set; }

    public int Amount { get; set; }

    public double Coins { get; set; }

    public string? Status { get; set; }

    public string? MomoTransactionId { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? CompletedAt { get; set; }

    public string? PaymentMethod { get; set; }

    public virtual User? User { get; set; }
}
