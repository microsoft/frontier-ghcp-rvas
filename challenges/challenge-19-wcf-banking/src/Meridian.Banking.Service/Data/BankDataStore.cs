using Meridian.Banking.Service.Models;

namespace Meridian.Banking.Service.Data;

/// <summary>
/// In-memory data store for Meridian Savings Bank.
/// Seed data includes 5 customers with accounts, transactions, and loans.
///
/// LEGACY NOTE: This class mixes data access and initialization logic.
/// A proper implementation would separate repository concerns.
/// </summary>
public class BankDataStore
{
    private int _nextTransactionId = 1001;
    private int _nextLoanId = 2001;

    public Dictionary<int, CustomerProfile> Customers { get; } = new();
    public Dictionary<string, Account> Accounts { get; } = new();
    public Dictionary<int, Loan> Loans { get; } = new();
    public List<Transaction> Transactions { get; } = new();

    public BankDataStore()
    {
        Seed();
    }

    public int NextTransactionId() => _nextTransactionId++;
    public int NextLoanId() => _nextLoanId++;

    private void Seed()
    {
        // Customer 1001 -- John Smith
        AddCustomer(1001, "John", "Smith", "john.smith@example.com", "555-0101", new DateTime(2015, 3, 15));
        AddAccount("CHK-001001", 1001, "Checking", 5250.75m, new DateTime(2015, 3, 15), 0.01m);
        AddAccount("SAV-001001", 1001, "Savings", 12500.00m, new DateTime(2016, 6, 20), 3.5m);
        AddTx("CHK-001001", "Deposit",    5000.00m, new DateTime(2024, 1, 5),  5000.00m, "Initial deposit");
        AddTx("CHK-001001", "Withdrawal",  200.00m, new DateTime(2024, 1, 10), 4800.00m, "ATM withdrawal");
        AddTx("CHK-001001", "Deposit",     750.00m, new DateTime(2024, 1, 20), 5550.00m, "Payroll deposit");
        AddTx("CHK-001001", "Withdrawal",  100.00m, new DateTime(2024, 1, 25), 5450.00m, "Bill payment");
        AddTx("CHK-001001", "Withdrawal",  199.25m, new DateTime(2024, 2, 1),  5250.75m, "ATM withdrawal");
        AddTx("SAV-001001", "Deposit",   12500.00m, new DateTime(2016, 6, 20), 12500.00m, "Opening deposit");
        AddLoan(1001, 25000m, 18750m, 4.5m, 60, 460.43m, new DateTime(2022, 1, 15));

        // Customer 1002 -- Sarah Johnson
        AddCustomer(1002, "Sarah", "Johnson", "sarah.johnson@example.com", "555-0102", new DateTime(2018, 7, 10));
        AddAccount("CHK-001002", 1002, "Checking", 3100.00m, new DateTime(2018, 7, 10), 0.01m);
        AddAccount("SAV-001002", 1002, "Savings",  8200.00m, new DateTime(2019, 1, 15), 3.5m);
        AddTx("CHK-001002", "Deposit",   3000.00m, new DateTime(2024, 1, 3),  3000.00m, "Initial deposit");
        AddTx("CHK-001002", "Deposit",    500.00m, new DateTime(2024, 1, 17), 3500.00m, "Transfer in");
        AddTx("CHK-001002", "Withdrawal", 400.00m, new DateTime(2024, 2, 1),  3100.00m, "Rent payment");
        AddTx("SAV-001002", "Deposit",   8000.00m, new DateTime(2019, 1, 15), 8000.00m, "Opening deposit");
        AddTx("SAV-001002", "Deposit",    200.00m, new DateTime(2024, 1, 30), 8200.00m, "Monthly savings");

        // Customer 1003 -- Robert Chen (has a closed account)
        AddCustomer(1003, "Robert", "Chen", "robert.chen@example.com", "555-0103", new DateTime(2017, 4, 22));
        AddAccount("CHK-001003", 1003, "Checking", 9800.50m,  new DateTime(2017, 4, 22), 0.01m);
        AddAccount("SAV-001003", 1003, "Savings",  22000.00m, new DateTime(2020, 2, 10), 3.5m);
        AddTx("CHK-001003", "Deposit", 10000.00m, new DateTime(2024, 1, 2),  10000.00m, "Opening deposit");
        AddTx("CHK-001003", "Withdrawal", 199.50m, new DateTime(2024, 1, 28), 9800.50m, "Bill payment");
        AddTx("SAV-001003", "Deposit", 20000.00m, new DateTime(2020, 2, 10), 20000.00m, "Opening deposit");
        AddTx("SAV-001003", "Deposit",  2000.00m, new DateTime(2024, 1, 10), 22000.00m, "Contribution");
        AddLoan(1003, 50000m, 42000m, 6.25m, 84, 727.55m, new DateTime(2021, 6, 1));

        // Customer 1004 -- Maria Rodriguez (frozen account to test error path)
        AddCustomer(1004, "Maria", "Rodriguez", "maria.rodriguez@example.com", "555-0104", new DateTime(2019, 11, 5));
        var frozenAcct = AddAccount("CHK-001004", 1004, "Checking", 650.00m, new DateTime(2019, 11, 5), 0.01m);
        frozenAcct.Status = "Frozen";
        AddAccount("SAV-001004", 1004, "Savings", 4500.00m, new DateTime(2021, 3, 1), 3.5m);
        AddTx("SAV-001004", "Deposit", 4500.00m, new DateTime(2021, 3, 1), 4500.00m, "Opening deposit");

        // Customer 1005 -- David Park
        AddCustomer(1005, "David", "Park", "david.park@example.com", "555-0105", new DateTime(2020, 8, 30));
        AddAccount("CHK-001005", 1005, "Checking", 1200.00m, new DateTime(2020, 8, 30), 0.01m);
        AddTx("CHK-001005", "Deposit",    1500.00m, new DateTime(2024, 1, 5),  1500.00m, "Opening deposit");
        AddTx("CHK-001005", "Withdrawal",  300.00m, new DateTime(2024, 1, 22), 1200.00m, "ATM withdrawal");
    }

    private void AddCustomer(int id, string first, string last, string email, string phone, DateTime created)
    {
        Customers[id] = new CustomerProfile
        {
            CustomerId = id,
            FirstName = first,
            LastName = last,
            Email = email,
            PhoneNumber = phone,
            Status = "Active",
            CreatedDate = created
        };
    }

    private Account AddAccount(string number, int customerId, string type, decimal balance, DateTime opened, decimal rate)
    {
        var acct = new Account
        {
            AccountNumber = number,
            CustomerId = customerId,
            AccountType = type,
            Balance = balance,
            OpenedDate = opened,
            InterestRate = rate,
            Status = "Open"
        };
        Accounts[number] = acct;
        return acct;
    }

    private void AddTx(string accountNumber, string type, decimal amount, DateTime date, decimal balanceAfter, string description)
    {
        Transactions.Add(new Transaction
        {
            TransactionId = _nextTransactionId++,
            AccountNumber = accountNumber,
            TransactionType = type,
            Amount = amount,
            TransactionDate = date,
            BalanceAfter = balanceAfter,
            Description = description
        });
    }

    private void AddLoan(int customerId, decimal amount, decimal outstanding, decimal rate, int termMonths, decimal monthlyPayment, DateTime originated)
    {
        var id = _nextLoanId++;
        Loans[id] = new Loan
        {
            LoanId = id,
            CustomerId = customerId,
            LoanAmount = amount,
            OutstandingBalance = outstanding,
            InterestRate = rate,
            TermMonths = termMonths,
            MonthlyPayment = monthlyPayment,
            OriginationDate = originated,
            MaturityDate = originated.AddMonths(termMonths),
            Status = "Active"
        };
    }
}
