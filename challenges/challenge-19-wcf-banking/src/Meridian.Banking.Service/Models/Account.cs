using System.Runtime.Serialization;

namespace Meridian.Banking.Service.Models;

/// <summary>
/// Bank account data contract.
/// </summary>
[DataContract(Name = "Account", Namespace = "http://meridian.banking.service/2024/01")]
public class Account
{
    [DataMember]
    public string AccountNumber { get; set; } = string.Empty;

    [DataMember]
    public int CustomerId { get; set; }

    /// <summary>Values: Checking, Savings, FixedDeposit.</summary>
    [DataMember]
    public string AccountType { get; set; } = string.Empty;

    [DataMember]
    public decimal Balance { get; set; }

    [DataMember]
    public DateTime OpenedDate { get; set; }

    /// <summary>Annual interest rate as a percentage (e.g. 3.5 means 3.5%).</summary>
    [DataMember]
    public decimal InterestRate { get; set; }

    /// <summary>Values: Open, Closed, Frozen.</summary>
    [DataMember]
    public string Status { get; set; } = "Open";
}
