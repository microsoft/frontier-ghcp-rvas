using System.Runtime.Serialization;

namespace Meridian.Banking.Service.Models;

/// <summary>
/// Loan agreement data contract.
/// </summary>
[DataContract(Name = "Loan", Namespace = "http://meridian.banking.service/2024/01")]
public class Loan
{
    [DataMember]
    public int LoanId { get; set; }

    [DataMember]
    public int CustomerId { get; set; }

    [DataMember]
    public decimal LoanAmount { get; set; }

    [DataMember]
    public decimal OutstandingBalance { get; set; }

    /// <summary>Annual interest rate as a percentage.</summary>
    [DataMember]
    public decimal InterestRate { get; set; }

    [DataMember]
    public int TermMonths { get; set; }

    [DataMember]
    public decimal MonthlyPayment { get; set; }

    [DataMember]
    public DateTime OriginationDate { get; set; }

    [DataMember]
    public DateTime MaturityDate { get; set; }

    /// <summary>Values: Active, Closed, Defaulted.</summary>
    [DataMember]
    public string Status { get; set; } = "Active";
}

/// <summary>
/// Single payment entry in a loan amortization schedule.
/// </summary>
[DataContract(Name = "LoanPaymentSchedule", Namespace = "http://meridian.banking.service/2024/01")]
public class LoanPaymentSchedule
{
    [DataMember]
    public int PaymentNumber { get; set; }

    [DataMember]
    public DateTime DueDate { get; set; }

    [DataMember]
    public decimal Payment { get; set; }

    [DataMember]
    public decimal Principal { get; set; }

    [DataMember]
    public decimal Interest { get; set; }

    [DataMember]
    public decimal Balance { get; set; }
}
