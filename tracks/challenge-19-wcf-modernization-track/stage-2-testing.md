# Stage 2: Characterization tests

**Duration:** 1.5-2 hours

**Focus:** Write tests that capture the WCF service's current behavior before migration

## Objective

Write a test suite that captures the WCF service's current behavior, including bugs. Use it in Stage 3 to check that the REST API preserves the covered behavior.

Test the running WCF service over HTTP. Cover observable behavior rather than implementation lines.

## Tasks

1. **Start the WCF service.** Run it in one terminal window and keep it running throughout this stage:

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
   - `INSUFFICIENT_FUNDS` (savings has no overdraft; checking cannot go below -$500)
   - `ACCOUNT_CLOSED` and `ACCOUNT_FROZEN` (customer 1004 has a frozen account)
   - `INVALID_AMOUNT` (zero or negative)
   - `LOAN_NOT_FOUND`, `LOAN_CLOSED`

7. **Test edge cases that expose known issues.** Document what you find, not what you expect:
   - Deposit a negative amount and record what happens
   - Transfer between the same account
   - Compare `AddDays(30)` and `AddMonths(1)` in the amortization schedule date sequence for a short term
   - Statement summary for a date range with no transactions

If your Banking Domain agent or WSDL skill produces a generic characterization test or misses the frozen-account edge case, refine it before using the test to check migration behavior.

## Verification

- [ ] Test project compiles and connects to the running WCF service
- [ ] `AccountService`: all operations have at least one passing test
- [ ] `LoanService`: all operations have at least one passing test
- [ ] `TransactionService`: all operations have at least one passing test
- [ ] Every `ErrorCode` has a test that verifies the fault is thrown under the correct condition
- [ ] Edge case tests cover documented bugs and pass against current behavior, even when that behavior is wrong
- [ ] All tests pass against the running WCF service

---

Previous: [Stage 1: Contract Archaeology](stage-1-archaeology.md) | Next: [Stage 3: REST API Migration](stage-3-migration.md)
