using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class VnpayTransaction
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public double Amount { get; set; }

    public string? TxnRef { get; set; } = null!;

    public string? OrderInfo { get; set; }

    public string? ResponseCode { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ProcessedAt { get; set; }

    public string Status { get; set; } = null!;

    public virtual User? User { get; set; } = null!;
}
