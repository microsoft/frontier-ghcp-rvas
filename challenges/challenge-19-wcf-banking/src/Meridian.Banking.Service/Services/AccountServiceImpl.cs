using CoreWCF;
using Meridian.Banking.Service.Contracts;
using Meridian.Banking.Service.Data;
using Meridian.Banking.Service.Models;

namespace Meridian.Banking.Service.Services;

/// <summary>
/// Account and customer service implementation.
///
/// LEGACY PATTERNS (intentional for challenge purposes):
/// - Business logic mixed directly into service layer -- no repository or service abstraction
/// - No input sanitization on string parameters
/// - Overdraft logic hardcoded as a magic number ($500 limit for checking)
/// - Deposit does not validate negative amounts
/// </summary>
[ServiceBehavior(InstanceContextMode = InstanceContextMode.Single)]
public class AccountServiceImpl : IAccountService
{
    private readonly BankDataStore _store;

    public AccountServiceImpl(BankDataStore store)
    {
        _store = store;
    }

    public CustomerProfile GetCustomerProfile(int customerId)
    {
        if (!_store.Customers.TryGetValue(customerId, out var customer))
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "CUSTOMER_NOT_FOUND", Message = $"Customer {customerId} not found." },
                new FaultReason("Customer not found"));
        }
        return customer;
    }

    public Account[] GetAccountsByCustomer(int customerId)
    {
        if (!_store.Customers.ContainsKey(customerId))
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "CUSTOMER_NOT_FOUND", Message = $"Customer {customerId} not found." },
                new FaultReason("Customer not found"));
        }
        return _store.Accounts.Values.Where(a => a.CustomerId == customerId).ToArray();
    }

    public Account GetAccountByNumber(string accountNumber)
    {
        if (!_store.Accounts.TryGetValue(accountNumber, out var account))
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "ACCOUNT_NOT_FOUND", Message = $"Account {accountNumber} not found." },
                new FaultReason("Account not found"));
        }
        return account;
    }

    public decimal Deposit(string accountNumber, decimal amount)
    {
        var account = GetAccountByNumber(accountNumber);

        if (account.Status == "Closed")
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "ACCOUNT_CLOSED", Message = "Cannot deposit to a closed account." },
                new FaultReason("Account is closed"));
        }

        if (account.Status == "Frozen")
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "ACCOUNT_FROZEN", Message = "Account is frozen. Contact a branch representative." },
                new FaultReason("Account is frozen"));
        }

        // LEGACY BUG: No check for amount <= 0. Negative deposits are accepted.
        account.Balance += amount;

        _store.Transactions.Add(new Transaction
        {
            TransactionId = _store.NextTransactionId(),
            AccountNumber = accountNumber,
            TransactionType = "Deposit",
            Amount = amount,
            TransactionDate = DateTime.UtcNow,
            BalanceAfter = account.Balance,
            Description = "Deposit"
        });

        return account.Balance;
    }

    public decimal Withdraw(string accountNumber, decimal amount)
    {
        var account = GetAccountByNumber(accountNumber);

        if (account.Status == "Closed")
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "ACCOUNT_CLOSED", Message = "Cannot withdraw from a closed account." },
                new FaultReason("Account is closed"));
        }

        if (account.Status == "Frozen")
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "ACCOUNT_FROZEN", Message = "Account is frozen. Contact a branch representative." },
                new FaultReason("Account is frozen"));
        }

        if (amount <= 0)
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "INVALID_AMOUNT", Message = "Withdrawal amount must be greater than zero." },
                new FaultReason("Invalid amount"));
        }

        // Overdraft rules: checking allows up to $500 overdraft; savings does not allow overdraft.
        decimal overdraftLimit = account.AccountType == "Checking" ? 500m : 0m;
        if (account.Balance - amount < -overdraftLimit)
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "INSUFFICIENT_FUNDS", Message = $"Insufficient funds. Available balance: {account.Balance:C}, overdraft limit: {overdraftLimit:C}." },
                new FaultReason("Insufficient funds"));
        }

        account.Balance -= amount;

        _store.Transactions.Add(new Transaction
        {
            TransactionId = _store.NextTransactionId(),
            AccountNumber = accountNumber,
            TransactionType = "Withdrawal",
            Amount = amount,
            TransactionDate = DateTime.UtcNow,
            BalanceAfter = account.Balance,
            Description = "Withdrawal"
        });

        return account.Balance;
    }

    public void Transfer(string sourceAccountNumber, string destinationAccountNumber, decimal amount)
    {
        var source = GetAccountByNumber(sourceAccountNumber);
        var destination = GetAccountByNumber(destinationAccountNumber);

        if (amount <= 0)
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "INVALID_AMOUNT", Message = "Transfer amount must be greater than zero." },
                new FaultReason("Invalid amount"));
        }

        // LEGACY BUG: Transfer is not atomic. If destination update succeeds but source
        // update fails partway through, the data will be inconsistent.
        // A proper implementation would use a transaction scope or compensating transaction.
        if (source.Balance < amount)
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "INSUFFICIENT_FUNDS", Message = "Insufficient funds in source account." },
                new FaultReason("Insufficient funds"));
        }

        source.Balance -= amount;
        destination.Balance += amount;

        var now = DateTime.UtcNow;
        _store.Transactions.Add(new Transaction
        {
            TransactionId = _store.NextTransactionId(),
            AccountNumber = sourceAccountNumber,
            TransactionType = "Transfer",
            Amount = amount,
            TransactionDate = now,
            BalanceAfter = source.Balance,
            Description = $"Transfer to {destinationAccountNumber}"
        });
        _store.Transactions.Add(new Transaction
        {
            TransactionId = _store.NextTransactionId(),
            AccountNumber = destinationAccountNumber,
            TransactionType = "Transfer",
            Amount = amount,
            TransactionDate = now,
            BalanceAfter = destination.Balance,
            Description = $"Transfer from {sourceAccountNumber}"
        });
    }

    public decimal CalculateAndApplyMonthlyInterest(string accountNumber)
    {
        var account = GetAccountByNumber(accountNumber);

        if (account.Status != "Open")
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "ACCOUNT_CLOSED", Message = "Interest can only be applied to open accounts." },
                new FaultReason("Account is not open"));
        }

        // Simple monthly interest: balance * (annualRate% / 12)
        // LEGACY NOTE: No day-count convention applied (not Actual/360, not 30/360).
        decimal monthlyRate = account.InterestRate / 100m / 12m;
        decimal interest = Math.Round(account.Balance * monthlyRate, 2);

        account.Balance += interest;

        _store.Transactions.Add(new Transaction
        {
            TransactionId = _store.NextTransactionId(),
            AccountNumber = accountNumber,
            TransactionType = "InterestCredit",
            Amount = interest,
            TransactionDate = DateTime.UtcNow,
            BalanceAfter = account.Balance,
            Description = "Monthly interest credit"
        });

        return interest;
    }
}
