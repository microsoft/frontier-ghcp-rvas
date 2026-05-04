using System.Runtime.Serialization;

namespace Meridian.Banking.Service.Models;

/// <summary>
/// Transaction record for deposit or withdrawal activity.
/// </summary>
[DataContract(Name = "Transaction", Namespace = "http://meridian.banking.service/2024/01")]
public class Transaction
{
    [DataMember]
    public int TransactionId { get; set; }

    [DataMember]
    public string AccountNumber { get; set; } = string.Empty;

    /// <summary>Values: Deposit, Withdrawal, Transfer, InterestCredit.</summary>
    [DataMember]
    public string TransactionType { get; set; } = string.Empty;

    [DataMember]
    public decimal Amount { get; set; }

    [DataMember]
    public DateTime TransactionDate { get; set; }

    [DataMember]
    public decimal BalanceAfter { get; set; }

    [DataMember]
    public string Description { get; set; } = string.Empty;
}
