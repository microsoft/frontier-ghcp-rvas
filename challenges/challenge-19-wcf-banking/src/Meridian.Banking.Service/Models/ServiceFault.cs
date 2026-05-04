using System.Runtime.Serialization;

namespace Meridian.Banking.Service.Models;

/// <summary>
/// SOAP fault returned when a service operation fails.
/// Included on every OperationContract via FaultContract(typeof(ServiceFault)).
/// </summary>
[DataContract(Name = "ServiceFault", Namespace = "http://meridian.banking.service/2024/01")]
public class ServiceFault
{
    /// <summary>
    /// Machine-readable error code. Known values:
    /// ACCOUNT_NOT_FOUND, CUSTOMER_NOT_FOUND, INSUFFICIENT_FUNDS,
    /// ACCOUNT_CLOSED, ACCOUNT_FROZEN, INVALID_AMOUNT, LOAN_NOT_FOUND,
    /// LOAN_CLOSED, VALIDATION_ERROR.
    /// </summary>
    [DataMember]
    public string ErrorCode { get; set; } = string.Empty;

    [DataMember]
    public string Message { get; set; } = string.Empty;

    [DataMember]
    public DateTime Timestamp { get; set; } = DateTime.UtcNow;
}

/// <summary>
/// Account statement summary for a given date range.
/// </summary>
[DataContract(Name = "StatementSummary", Namespace = "http://meridian.banking.service/2024/01")]
public class StatementSummary
{
    [DataMember]
    public string AccountNumber { get; set; } = string.Empty;

    [DataMember]
    public DateTime StatementStartDate { get; set; }

    [DataMember]
    public DateTime StatementEndDate { get; set; }

    [DataMember]
    public decimal OpeningBalance { get; set; }

    [DataMember]
    public decimal ClosingBalance { get; set; }

    [DataMember]
    public decimal TotalDeposits { get; set; }

    [DataMember]
    public decimal TotalWithdrawals { get; set; }

    [DataMember]
    public int TransactionCount { get; set; }
}
