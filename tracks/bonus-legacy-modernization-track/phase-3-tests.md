# Phase 3: Test Harness

[Back to Legacy Code Modernization Track](../bonus-legacy-modernization-track.md)

**Duration:** 1.5-2 hours

**Focus:** Writing characterization tests that capture current behavior before migration

## Tasks

1. **Set up the test infrastructure.** Add JUnit 5 and Spring Boot Test dependencies. Create a test configuration that initializes the H2 database with the existing schema and seed data.

2. **Write characterization tests for account operations.** Test current behavior, not ideal behavior. If a SQL injection vulnerability exists, your test should document that you can query with injected SQL -- it captures the reality. Cover:
   - Listing accounts (with and without type filter)
   - Creating an account (minimum balance rules for CHK and SAV, interest rate tiers, max 5 accounts per customer)
   - Account creation with invalid customer ID

3. **Write characterization tests for transfers.** Cover:
   - Successful transfer between two active accounts
   - Transfer with insufficient funds
   - Transfer exceeding the $10,000 limit
   - Transfer involving an inactive account

4. **Write characterization tests for batch operations.** Cover:
   - Monthly interest calculation (verify the formula and rounding)
   - Customer tier updates (verify the thresholds: STANDARD < $50k, GOLD >= $50k, PLATINUM >= $250k)

5. **Write characterization tests for customer operations.** Cover:
   - Creating a customer (duplicate email check, default tier assignment)
   - Searching customers (by name, by email)
   - Getting a customer with their accounts

6. **Verify all tests pass.** These tests capture the application's current behavior. When you migrate in Phase 4, these same tests should still pass (after updating imports and annotations).

## Verification

- [ ] Test infrastructure set up (JUnit 5, Spring Boot Test)
- [ ] Account operation tests written and passing (at least 6 tests)
- [ ] Transfer tests written and passing (at least 4 tests)
- [ ] Batch operation tests written and passing (at least 3 tests)
- [ ] Customer operation tests written and passing (at least 4 tests)
- [ ] All tests pass with the current (legacy) codebase

---

Previous: [Phase 2: Security and Debt Audit](phase-2-audit.md) | Next: [Phase 4: Migration](phase-4-migration.md)
