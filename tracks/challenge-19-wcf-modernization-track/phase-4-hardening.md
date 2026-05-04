# Phase 4: Integration and Hardening

[Back to Legacy WCF Banking Modernization Track](../challenge-19-wcf-modernization-track.md)

**Duration:** 1-2 hours

**Focus:** Running characterization tests against the REST API, fixing behavior gaps, adding Swagger, writing migration notes

## Objective

Adapt the Phase 2 characterization tests to run against your new REST API. Every test that passed against the WCF service should pass against the REST API -- if it does not, the migration dropped a business rule. Fix the gaps, add API documentation, and produce a migration notes document that a consuming team could use to update their clients.

## Tasks

1. **Adapt characterization tests to the REST API.** Take the test project from Phase 2:
   - Add a configuration flag or test base class that points tests at either the WCF service or the REST API
   - Replace WCF channel factory calls with `HttpClient` calls
   - Replace `FaultException<ServiceFault>` assertions with HTTP status code assertions
   - Keep business logic assertions identical -- only the transport layer changes

2. **Run all tests against the REST API.** Fix any failures:
   - If a test fails, investigate whether the REST API is missing business logic, or the test needs to account for a legitimate behavior difference
   - Do not change test assertions to pass -- change the REST API implementation
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

5. **Write a migration notes document.** Create `docs/migration-notes.md` with:
   - **Endpoint mapping table** -- each WCF operation name alongside its REST equivalent (verb + path)
   - **Data type changes** -- SOAP `DateTime` serialization vs. JSON ISO 8601, `decimal` vs. JSON numbers
   - **Error handling changes** -- `FaultException<ServiceFault>` replaced by HTTP status codes; include a mapping table
   - **Breaking changes** -- anything a WCF client cannot do in REST without a code change
   - **Intentional behavior changes** -- bugs you fixed, conventions you updated
   - **Deprecation guidance** -- if you were deploying this, when would the WCF service be shut down?

6. **Validate the full system end-to-end.** Run through one complete workflow manually:
   - Start both services (WCF and REST)
   - Fetch customer 1001's profile and accounts from the REST API
   - Deposit $500 into the checking account
   - Transfer $200 to savings
   - Check transaction history for both accounts
   - Apply monthly interest to the savings account
   - Verify all balances are correct

## Verification

- [ ] Phase 2 characterization tests adapted to run against the REST API
- [ ] All tests pass against the REST API
- [ ] Integration tests written and passing
- [ ] Swagger UI accessible and documents all endpoints, status codes, and schemas
- [ ] `docs/migration-notes.md` written: endpoint map, type changes, error code map, breaking changes
- [ ] End-to-end manual workflow completed with correct results
- [ ] No unhandled exceptions returning HTTP 500 for expected error conditions

---

Previous: [Phase 3: REST API Migration](phase-3-migration.md)
