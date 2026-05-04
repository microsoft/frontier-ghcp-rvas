using System.ServiceModel;
using Meridian.Banking.Service.Models;

namespace Meridian.Banking.Service.Contracts;

/// <summary>
/// WCF Service Contract for account and customer management.
/// Provides SOAP endpoints over BasicHttpBinding.
/// </summary>
[ServiceContract(Name = "IAccountService", Namespace = "http://meridian.banking.service/2024/01")]
public interface IAccountService
{
    /// <summary>Retrieves a customer profile by ID.</summary>
    [OperationContract]
    [FaultContract(typeof(ServiceFault))]
    CustomerProfile GetCustomerProfile(int customerId);

    /// <summary>Retrieves all accounts for a given customer.</summary>
    [OperationContract]
    [FaultContract(typeof(ServiceFault))]
    Account[] GetAccountsByCustomer(int customerId);

    /// <summary>Retrieves a single account by account number.</summary>
    [OperationContract]
    [FaultContract(typeof(ServiceFault))]
    Account GetAccountByNumber(string accountNumber);

    /// <summary>
    /// Deposits funds into an account.
    /// NOTE: Legacy implementation -- does not validate against negative amounts.
    /// </summary>
    /// <returns>New account balance after deposit.</returns>
    [OperationContract]
    [FaultContract(typeof(ServiceFault))]
    decimal Deposit(string accountNumber, decimal amount);

    /// <summary>
    /// Withdraws funds from an account.
    /// Checking accounts permit overdraft up to $500. Savings accounts do not.
    /// </summary>
    /// <returns>New account balance after withdrawal.</returns>
    [OperationContract]
    [FaultContract(typeof(ServiceFault))]
    decimal Withdraw(string accountNumber, decimal amount);

    /// <summary>
    /// Transfers funds between two accounts.
    /// Both accounts must be Open. The transfer is not atomic in this implementation.
    /// </summary>
    [OperationContract]
    [FaultContract(typeof(ServiceFault))]
    void Transfer(string sourceAccountNumber, string destinationAccountNumber, decimal amount);

    /// <summary>
    /// Calculates monthly interest and credits it to the account.
    /// Uses simple interest: balance * (rate / 100 / 12).
    /// NOTE: Does not account for day-count conventions.
    /// </summary>
    /// <returns>Interest amount credited.</returns>
    [OperationContract]
    [FaultContract(typeof(ServiceFault))]
    decimal CalculateAndApplyMonthlyInterest(string accountNumber);
}
