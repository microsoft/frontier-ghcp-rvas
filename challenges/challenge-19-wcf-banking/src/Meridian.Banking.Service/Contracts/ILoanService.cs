using System.ServiceModel;
using Meridian.Banking.Service.Models;

namespace Meridian.Banking.Service.Contracts;

/// <summary>
/// WCF Service Contract for loan management.
/// </summary>
[ServiceContract(Name = "ILoanService", Namespace = "http://meridian.banking.service/2024/01")]
public interface ILoanService
{
    /// <summary>Retrieves a loan by its ID.</summary>
    [OperationContract]
    [FaultContract(typeof(ServiceFault))]
    Loan GetLoanById(int loanId);

    /// <summary>Retrieves all loans for a customer.</summary>
    [OperationContract]
    [FaultContract(typeof(ServiceFault))]
    Loan[] GetLoansByCustomer(int customerId);

    /// <summary>
    /// Applies a payment to a loan, splitting principal and interest.
    /// Overpayment is applied entirely to principal.
    /// </summary>
    /// <returns>Outstanding balance after payment.</returns>
    [OperationContract]
    [FaultContract(typeof(ServiceFault))]
    decimal MakePayment(int loanId, decimal paymentAmount);

    /// <summary>
    /// Generates the amortization schedule for a loan.
    /// NOTE: Date calculation has a known bug -- does not handle leap years correctly.
    /// Monthly payments are offset by exactly 30 days regardless of month length.
    /// </summary>
    [OperationContract]
    [FaultContract(typeof(ServiceFault))]
    LoanPaymentSchedule[] GetAmortizationSchedule(int loanId);
}
