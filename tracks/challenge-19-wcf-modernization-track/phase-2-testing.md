# Phase 2: Characterization Tests

[Back to Legacy WCF Banking Modernization Track](../challenge-19-wcf-modernization-track.md)

**Duration:** 1.5-2 hours

**Focus:** Writing tests that document and lock in the WCF service's current behavior before any migration work starts

## Objective

Write a test suite that captures what the WCF service currently does -- correct behavior, bugs, and all. These tests become your safety net for Phase 3. If your new REST API passes all of them, you know the business logic survived the migration intact.

You are testing the running WCF service over HTTP, not the implementation classes directly. The goal is behavioral coverage, not line coverage.

## Tasks

1. **Start the WCF service.** Run it in one terminal window and keep it running throughout this phase:

   ```bash
   dotnet run --project src/Meridian.Banking.Service
   ```

2. **Create a test project.** Add an xUnit or NUnit project to the solution:
   - Target .NET 8
   - Reference `System.ServiceModel.Http` for WCF client channel factory, or use `HttpClient` with raw SOAP payloads
   - Configure the service endpoint URL as a constant or environment variable
   - Add a fixture that resets to seed data between test classes (or accept that tests run against the same in-memory state and design accordingly)

3. **Test `AccountService` operations.**
   - `GetCustomerProfile`: valid customer, non-existent customer (`CUSTOMER_NOT_FOUND`)
   - `GetAccountsByCustomer`: returns correct accounts, no accounts for unknown customer
   - `GetAccountByNumber`: valid account, invalid account (`ACCOUNT_NOT_FOUND`)
   - `Deposit`: updates balance, records a transaction, works on Open accounts
   - `Withdraw`: reduces balance, respects overdraft limit (checking: -$500 floor, savings: no overdraft)
   - `Transfer`: both accounts updated, insufficient funds in source (`INSUFFICIENT_FUNDS`)
   - `CalculateAndApplyMonthlyInterest`: correct formula applied, transaction recorded

4. **Test `LoanService` operations.**
   - `GetLoanById`: valid loan, non-existent loan (`LOAN_NOT_FOUND`)
   - `GetLoansByCustomer`: returns correct loans
   - `MakePayment`: balance decreases, principal/interest split is correct, closed loan rejects payment
   - `GetAmortizationSchedule`: correct number of entries, monthly payment matches expected PMT formula, date sequence

5. **Test `TransactionService` operations.**
   - `GetTransactionHistory`: returns transactions in newest-first order, `days=0` returns all, `days=30` filters correctly
   - `GetTransactionById`: valid transaction, invalid transaction
   - `GetStatementSummary`: totals add up, date range filtering works

6. **Test fault conditions.** Write at least one test per `ErrorCode`:
   - `ACCOUNT_NOT_FOUND`, `CUSTOMER_NOT_FOUND`
   - `INSUFFICIENT_FUNDS` (savings -- no overdraft, checking -- beyond -$500)
   - `ACCOUNT_CLOSED` and `ACCOUNT_FROZEN` (customer 1004 has a frozen account)
   - `INVALID_AMOUNT` (zero or negative)
   - `LOAN_NOT_FOUND`, `LOAN_CLOSED`

7. **Test edge cases that expose known issues.** Document what you find, not what you expect:
   - Deposit a negative amount -- what actually happens?
   - Transfer between the same account
   - Amortization schedule date sequence -- does `AddDays(30)` vs `AddMonths(1)` matter for a short term?
   - Statement summary for a date range with no transactions

## Verification

- [ ] Test project compiles and connects to the running WCF service
- [ ] `AccountService`: all operations have at least one passing test
- [ ] `LoanService`: all operations have at least one passing test
- [ ] `TransactionService`: all operations have at least one passing test
- [ ] Every `ErrorCode` has a test that verifies the fault is thrown under the correct condition
- [ ] Edge case tests written for the documented bugs -- tests pass against current behavior (even if behavior is wrong)
- [ ] All tests pass against the running WCF service

---

Previous: [Phase 1: Contract Archaeology](phase-1-archaeology.md) | Next: [Phase 3: REST API Migration](phase-3-migration.md)
