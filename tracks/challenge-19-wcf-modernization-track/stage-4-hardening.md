# Stage 4: Integration and hardening

**Duration:** 1-2 hours

**Focus:** Run characterization tests against the REST API, fix behavior gaps, complete Swagger documentation, and write migration notes

## Objective

Adapt the Stage 2 characterization tests to the REST API. Investigate failures against the original behavior and any intentional changes. Fix migration gaps, complete the API documentation, and write migration notes that consuming teams can use to update their clients.

## Tasks

1. **Adapt characterization tests to the REST API.** Take the test project from Stage 2:
   - Add a configuration flag or test base class that points tests at either the WCF service or the REST API
   - Replace WCF channel factory calls with `HttpClient` calls
   - Replace `FaultException<ServiceFault>` assertions with HTTP status code assertions
   - Keep business logic assertions identical; change only the transport layer

2. **Run all tests against the REST API.** Fix any failures:
   - If a test fails, investigate whether the REST API is missing business logic, or the test needs to account for a legitimate behavior difference
   - Fix the REST API implementation rather than weakening test assertions
   - Document any behavior differences you chose to keep intentionally

3. **Write integration tests across controllers.** Test scenarios that span multiple operations:
   - Create a deposit, then check transaction history
   - Make a transfer, then verify both account balances
   - Make a loan payment, then check the updated outstanding balance
   - Verify that an operation on a frozen account returns the correct status code from both `AccountController` and `TransactionController`

4. **Complete Swagger documentation.** Verify the OpenAPI spec is useful:
   - Every endpoint has a summary comment
   - Every response code is documented (200, 400, 404, etc.)
   - Request body schemas are correct
   - Error response schema is documented
   - The Swagger UI is accessible at `/swagger` and allows trying out endpoints

5. Create `docs/migration-notes.md` with:
   - A table mapping each WCF operation to its REST verb and path
   - Data type changes, including SOAP `DateTime` vs. JSON ISO 8601 and `decimal` vs. JSON numbers
   - A table mapping `FaultException<ServiceFault>` errors to HTTP status codes
   - Breaking changes that require WCF clients to change their code
   - Intentional behavior changes, including fixed bugs and updated conventions
   - Deprecation guidance that states when a deployed WCF service could be shut down

6. **Validate the full system end-to-end.** Run through one complete workflow manually:
   - Start both services (WCF and REST)
   - Fetch customer 1001's profile and accounts from the REST API
   - Deposit $500 into the checking account
   - Transfer $200 to savings
   - Check transaction history for both accounts
   - Apply monthly interest to the savings account
   - Verify all balances are correct

## Verification

- [ ] Stage 2 characterization tests adapted to run against the REST API
- [ ] All tests pass against the REST API
- [ ] Integration tests written and passing
- [ ] Swagger UI accessible and documents all endpoints, status codes, and schemas
- [ ] `docs/migration-notes.md` written: endpoint map, type changes, error code map, breaking changes
- [ ] End-to-end manual workflow completed with correct results
- [ ] No unhandled exceptions returning HTTP 500 for expected error conditions

---

Previous: [Stage 3: REST API Migration](stage-3-migration.md)
