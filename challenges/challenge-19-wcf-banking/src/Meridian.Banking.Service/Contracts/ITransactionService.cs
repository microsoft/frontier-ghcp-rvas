using System.ServiceModel;
using Meridian.Banking.Service.Models;

namespace Meridian.Banking.Service.Contracts;

/// <summary>
/// WCF Service Contract for transaction history and reporting.
/// </summary>
[ServiceContract(Name = "ITransactionService", Namespace = "http://meridian.banking.service/2024/01")]
public interface ITransactionService
{
    /// <summary>
    /// Retrieves transaction history for an account.
    /// Results are ordered newest-first.
    /// </summary>
    /// <param name="days">Number of days to look back. Pass 0 for full history.</param>
    [OperationContract]
    [FaultContract(typeof(ServiceFault))]
    Transaction[] GetTransactionHistory(string accountNumber, int days);

    /// <summary>Retrieves a single transaction by its ID.</summary>
    [OperationContract]
    [FaultContract(typeof(ServiceFault))]
    Transaction GetTransactionById(int transactionId);

    /// <summary>
    /// Produces a statement summary for a date range.
    /// Opening balance is the balance at the start of the range, not account open date.
    /// </summary>
    [OperationContract]
    [FaultContract(typeof(ServiceFault))]
    StatementSummary GetStatementSummary(string accountNumber, DateTime startDate, DateTime endDate);
}
