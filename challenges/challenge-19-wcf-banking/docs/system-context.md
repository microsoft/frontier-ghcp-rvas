# Meridian Savings Bank -- System Context

This document describes the Meridian Savings Bank WCF service. Read it before exploring the source code.

## Background

Meridian Savings Bank is a fictional regional bank operating since 1987. Its core banking platform was built in 2010-2012 using Windows Communication Foundation (WCF) -- a SOAP-based service framework that was the enterprise standard for .NET at the time.

The service has been running in production ever since, with minimal changes. It handles the bank's account management, loan processing, and transaction history for roughly 45,000 customers.

The system currently runs on CoreWCF (.NET 8) in a containerized environment -- a 2024 migration from the original .NET Framework 4.8 installation. The business logic was untouched during that migration; only the hosting layer changed.

The bank's new engineering team has been asked to modernize the service to a REST API. You have been brought in to help.

## Services

### AccountService (`/AccountService`)

Manages customer profiles and deposit accounts. Handles deposits, withdrawals, and transfers.

Operations: `GetCustomerProfile`, `GetAccountsByCustomer`, `GetAccountByNumber`, `Deposit`, `Withdraw`, `Transfer`, `CalculateAndApplyMonthlyInterest`

Account types: Checking (0.01% annual interest, $500 overdraft limit), Savings (3.5% annual interest, no overdraft), FixedDeposit (negotiated rate, no withdrawals before maturity).

### LoanService (`/LoanService`)

Manages consumer loan agreements. Supports personal loans and auto loans.

Operations: `GetLoanById`, `GetLoansByCustomer`, `MakePayment`, `GetAmortizationSchedule`

### TransactionService (`/TransactionService`)

Provides read-only access to transaction history and statement generation.

Operations: `GetTransactionHistory`, `GetTransactionById`, `GetStatementSummary`

## Data

Five seed customers are loaded at startup (IDs 1001-1005). Each customer has one or more accounts with transaction history. Customer 1001 (John Smith) and Customer 1003 (Robert Chen) have active loans. Customer 1004 (Maria Rodriguez) has a frozen checking account -- useful for testing error paths.

Account numbers follow the pattern `CHK-{customerId}` for checking and `SAV-{customerId}` for savings.

## Known Issues

The original developers left a few notes in the code:

- `Deposit` does not validate negative amounts (the field "accepts" a negative deposit, which functions as a hidden withdrawal).
- `Transfer` is not atomic -- if the service crashes between debiting the source and crediting the destination, the accounts will be inconsistent.
- `GetAmortizationSchedule` uses `AddDays(30)` instead of `AddMonths(1)` for payment dates, causing date drift over a loan term.
- `GetStatementSummary` derives the opening balance by working backwards from the current balance, which gives wrong results for periods that do not cover all transactions.
- Monthly interest uses simple interest with no day-count convention.

These are real issues, not bugs introduced for the challenge. They are worth documenting during Phase 1 and deciding whether to preserve or fix during Phase 3.

## Service Faults

All operations declare `FaultContract(typeof(ServiceFault))`. The `ServiceFault` data contract has three fields: `ErrorCode` (string), `Message` (string), and `Timestamp` (DateTime).

Known error codes: `ACCOUNT_NOT_FOUND`, `CUSTOMER_NOT_FOUND`, `INSUFFICIENT_FUNDS`, `ACCOUNT_CLOSED`, `ACCOUNT_FROZEN`, `INVALID_AMOUNT`, `LOAN_NOT_FOUND`, `LOAN_CLOSED`, `TRANSACTION_NOT_FOUND`, `VALIDATION_ERROR`.

## Starting the Service

```bash
cd challenges/challenge-19-wcf-banking
dotnet run --project src/Meridian.Banking.Service
```

The service listens on `http://localhost:5000` by default.
