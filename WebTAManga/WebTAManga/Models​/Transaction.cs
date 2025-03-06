using System;
using System.Collections.Generic;

namespace WebTAManga.Models​;

public partial class Transaction
{
    public int TransactionId { get; set; }

    public int? UserId { get; set; }

    public int Amount { get; set; }

    public int Coins { get; set; }

    public string? TransactionStatus { get; set; }

    public string? VnpayTransactionId { get; set; }

    public DateTime CreatedAt { get; set; }

    public virtual User? User { get; set; }
}
