using CoreWCF;
using Meridian.Banking.Service.Contracts;
using Meridian.Banking.Service.Data;
using Meridian.Banking.Service.Models;

namespace Meridian.Banking.Service.Services;

/// <summary>
/// Loan service implementation.
///
/// LEGACY PATTERNS (intentional for challenge purposes):
/// - Amortization schedule has a known date calculation bug (uses AddDays(30) instead of AddMonths(1))
/// - Monthly payment formula duplicated inline rather than extracted to a helper
/// - Interest and principal split uses intermediate rounding that can drift over a loan term
/// </summary>
[ServiceBehavior(InstanceContextMode = InstanceContextMode.Single)]
public class LoanServiceImpl : ILoanService
{
    private readonly BankDataStore _store;

    public LoanServiceImpl(BankDataStore store)
    {
        _store = store;
    }

    public Loan GetLoanById(int loanId)
    {
        if (!_store.Loans.TryGetValue(loanId, out var loan))
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "LOAN_NOT_FOUND", Message = $"Loan {loanId} not found." },
                new FaultReason("Loan not found"));
        }
        return loan;
    }

    public Loan[] GetLoansByCustomer(int customerId)
    {
        return _store.Loans.Values.Where(l => l.CustomerId == customerId).ToArray();
    }

    public decimal MakePayment(int loanId, decimal paymentAmount)
    {
        var loan = GetLoanById(loanId);

        if (loan.Status == "Closed")
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "LOAN_CLOSED", Message = "This loan has already been paid off." },
                new FaultReason("Loan is closed"));
        }

        if (paymentAmount <= 0)
        {
            throw new FaultException<ServiceFault>(
                new ServiceFault { ErrorCode = "INVALID_AMOUNT", Message = "Payment amount must be greater than zero." },
                new FaultReason("Invalid amount"));
        }

        // Split payment between interest and principal.
        decimal monthlyRate = loan.InterestRate / 100m / 12m;
        decimal interestPortion = Math.Round(loan.OutstandingBalance * monthlyRate, 2);
        decimal principalPortion = paymentAmount - interestPortion;

        if (principalPortion < 0)
        {
            // Payment does not even cover interest -- still apply it but balance grows.
            principalPortion = 0;
        }

        loan.OutstandingBalance = Math.Max(0, loan.OutstandingBalance - principalPortion);

        if (loan.OutstandingBalance == 0)
        {
            loan.Status = "Closed";
        }

        return loan.OutstandingBalance;
    }

    public LoanPaymentSchedule[] GetAmortizationSchedule(int loanId)
    {
        var loan = GetLoanById(loanId);

        var schedule = new List<LoanPaymentSchedule>();
        decimal balance = loan.LoanAmount;
        decimal monthlyRate = loan.InterestRate / 100m / 12m;

        // PMT formula: P * (r * (1+r)^n) / ((1+r)^n - 1)
        double r = (double)monthlyRate;
        int n = loan.TermMonths;
        double pmt = (double)loan.LoanAmount * (r * Math.Pow(1 + r, n)) / (Math.Pow(1 + r, n) - 1);
        decimal monthlyPayment = Math.Round((decimal)pmt, 2);

        // LEGACY BUG: AddDays(30) is used instead of AddMonths(1).
        // This causes payment dates to drift and results in incorrect due dates for
        // months with 28, 29, or 31 days.
        DateTime dueDate = loan.OriginationDate.AddDays(30);

        for (int i = 1; i <= loan.TermMonths; i++)
        {
            decimal interest = Math.Round(balance * monthlyRate, 2);
            decimal principal = monthlyPayment - interest;

            if (i == loan.TermMonths)
            {
                // Last payment: pay off remaining balance exactly.
                principal = balance;
                monthlyPayment = principal + interest;
            }

            balance -= principal;
            if (balance < 0) balance = 0;

            schedule.Add(new LoanPaymentSchedule
            {
                PaymentNumber = i,
                DueDate = dueDate,
                Payment = monthlyPayment,
                Principal = principal,
                Interest = interest,
                Balance = balance
            });

            dueDate = dueDate.AddDays(30); // BUG: should be AddMonths(1)
        }

        return schedule.ToArray();
    }
}
