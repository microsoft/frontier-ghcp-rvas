using CoreWCF;
using Meridian.Banking.Service.Contracts;
using Meridian.Banking.Service.Data;
using Meridian.Banking.Service.Models;

namespace Meridian.Banking.Service.Services;

/// <summary>
/// Transaction history and reporting service implementation.
/// </summary>
[ServiceBehavior(InstanceContextMode = InstanceContextMode.Single)]
public class TransactionServiceImpl : ITransactionService
{
    private readonly BankDataStore _store;

    public TransactionServiceImpl(BankDataStore store)
    {
        _store = store;
    }

    public Transaction[] GetTransactionHistory(string accountNumber, int days)
    {
        if (!_store.Accounts.ContainsKey(accountNumber))
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "ACCOUNT_NOT_FOUND", Message = $"Account {accountNumber} not found." },
                new FaultReason("Account not found"));
        }

        var query = _store.Transactions.Where(t => t.AccountNumber == accountNumber);

        if (days > 0)
        {
            var cutoff = DateTime.UtcNow.AddDays(-days);
            query = query.Where(t => t.TransactionDate >= cutoff);
        }

        return query.OrderByDescending(t => t.TransactionDate).ToArray();
    }

    public Transaction GetTransactionById(int transactionId)
    {
        var tx = _store.Transactions.FirstOrDefault(t => t.TransactionId == transactionId);
        if (tx == null)
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "TRANSACTION_NOT_FOUND", Message = $"Transaction {transactionId} not found." },
                new FaultReason("Transaction not found"));
        }
        return tx;
    }

    public StatementSummary GetStatementSummary(string accountNumber, DateTime startDate, DateTime endDate)
    {
        if (!_store.Accounts.TryGetValue(accountNumber, out var account))
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "ACCOUNT_NOT_FOUND", Message = $"Account {accountNumber} not found." },
                new FaultReason("Account not found"));
        }

        var txInRange = _store.Transactions
            .Where(t => t.AccountNumber == accountNumber
                        && t.TransactionDate >= startDate
                        && t.TransactionDate <= endDate)
            .OrderBy(t => t.TransactionDate)
            .ToList();

        decimal totalDeposits = txInRange
            .Where(t => t.TransactionType is "Deposit" or "InterestCredit" or "Transfer" && t.Description.Contains("from"))
            .Sum(t => t.Amount);

        decimal totalWithdrawals = txInRange
            .Where(t => t.TransactionType is "Withdrawal" or "Transfer" && t.Description.Contains("to"))
            .Sum(t => t.Amount);

        // Opening balance: derive by working backwards from current balance.
        // LEGACY NOTE: This is O(n) over all transactions and inaccurate if transactions
        // outside the range modified the balance after endDate.
        decimal openingBalance = account.Balance - totalDeposits + totalWithdrawals;

        return new StatementSummary
        {
            AccountNumber = accountNumber,
            StatementStartDate = startDate,
            StatementEndDate = endDate,
            OpeningBalance = openingBalance,
            ClosingBalance = account.Balance,
            TotalDeposits = totalDeposits,
            TotalWithdrawals = totalWithdrawals,
            TransactionCount = txInRange.Count
        };
    }
}
