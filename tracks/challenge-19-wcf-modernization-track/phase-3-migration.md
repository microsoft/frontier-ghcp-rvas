# Phase 3: REST API Migration

[Back to Legacy WCF Banking Modernization Track](../challenge-19-wcf-modernization-track.md)

**Duration:** 2-3 hours

**Focus:** Building an ASP.NET Core Web API that replaces each WCF service operation, preserving all business logic

## Objective

Rewrite the Meridian Savings Bank service as a REST API using ASP.NET Core Web API (.NET 8). The new API must match the behavior captured in the Phase 2 tests. You are not wrapping the WCF service -- you are porting the business logic into modern patterns.

Decide up front whether to fix the known bugs (see `docs/system-context.md`) as part of migration, or preserve them to match the characterization tests exactly. Either choice is valid -- but make it deliberately and document it.

## Tasks

1. **Design the REST API before writing any code.** For each WCF service, define:
   - Resources and their URL paths
   - HTTP verbs per operation
   - Request body schemas (translated from `DataContract` types to plain JSON objects)
   - Response schemas
   - HTTP status codes for each `ErrorCode` (from your fault catalog in Phase 1)
   - A decision on whether to use controllers or minimal APIs

2. **Scaffold the ASP.NET Core Web API project.**
   - Add a new project to the solution targeting `net8.0`
   - Set up dependency injection for your service/repository classes
   - Add Swashbuckle for OpenAPI generation
   - Configure a global exception handler to translate domain exceptions to HTTP responses

3. **Build the data layer.** Choose a persistence approach:
   - In-memory dictionaries/lists (simplest -- mirrors what the WCF service uses)
   - Entity Framework Core with SQLite (more realistic production path)
   - Either is fine -- document your choice in the project README
   - Seed the same 5 customers, accounts, loans, and transactions as the WCF service

4. **Implement `AccountController`.** Map each `AccountService` operation:
   - `GET /api/customers/{id}` -- `GetCustomerProfile`
   - `GET /api/customers/{id}/accounts` -- `GetAccountsByCustomer`
   - `GET /api/accounts/{accountNumber}` -- `GetAccountByNumber`
   - `POST /api/accounts/{accountNumber}/deposits` -- `Deposit`
   - `POST /api/accounts/{accountNumber}/withdrawals` -- `Withdraw`
   - `POST /api/transfers` -- `Transfer`
   - `POST /api/accounts/{accountNumber}/interest` -- `CalculateAndApplyMonthlyInterest`

5. **Implement `LoanController`.** Map each `LoanService` operation:
   - `GET /api/loans/{id}` -- `GetLoanById`
   - `GET /api/customers/{id}/loans` -- `GetLoansByCustomer`
   - `POST /api/loans/{id}/payments` -- `MakePayment`
   - `GET /api/loans/{id}/amortization` -- `GetAmortizationSchedule`

6. **Implement `TransactionController`.** Map each `TransactionService` operation:
   - `GET /api/accounts/{accountNumber}/transactions` -- `GetTransactionHistory` (with `?days=N` query param)
   - `GET /api/transactions/{id}` -- `GetTransactionById`
   - `GET /api/accounts/{accountNumber}/statement` -- `GetStatementSummary` (with `?startDate=&endDate=` params)

7. **Port the business logic.** For each operation:
   - Extract logic from the WCF service implementation class
   - Move it into a C# service class (not the controller)
   - Preserve all validation rules, calculations, and error conditions
   - Return the appropriate HTTP status code for each error condition

8. **Test two endpoints manually** to verify the API is working before moving to Phase 4:
   - Fetch customer 1001's accounts
   - Attempt to withdraw more than the savings account balance

## What Copilot Helps With vs. What Requires Your Judgment

**Copilot is reliable for:**

- Generating controller skeletons from your endpoint design description
- Translating WCF service implementation methods to C# service classes
- Mapping `ErrorCode` values to HTTP status codes
- Scaffolding Swashbuckle configuration
- Suggesting dependency injection registration

**Requires your judgment:**

- Deciding the REST resource model -- WCF operations map to REST in multiple valid ways
- Deciding whether to fix bugs during migration or preserve them (and which bugs are bugs vs. undocumented features)
- Deciding what "Transfer" means atomically in a REST context
- Validating that Copilot's business logic translation is actually correct -- it will not know about the documented quirks

## Verification

- [ ] ASP.NET Core Web API project added to the solution
- [ ] All three controllers implemented (`AccountController`, `LoanController`, `TransactionController`)
- [ ] All WCF operations have a corresponding REST endpoint
- [ ] Business logic ported: validation rules, overdraft logic, interest calculation, amortization formula
- [ ] HTTP status codes match the fault catalog from Phase 1
- [ ] Error responses return JSON with at minimum `errorCode` and `message` fields
- [ ] Two endpoints manually tested and working
- [ ] Swagger UI accessible at `/swagger`

---

Previous: [Phase 2: Characterization Tests](phase-2-testing.md) | Next: [Phase 4: Integration and Hardening](phase-4-hardening.md)
