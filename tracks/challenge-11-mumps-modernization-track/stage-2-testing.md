# Stage 2: Characterization Testing

**Duration:** 2-3 hours
**Focus:** Writing tests that capture existing behavior before changing anything

## Objective

Write a comprehensive test suite in your target language that documents and verifies the banking system's current behavior. These tests become the safety net for Stage 4 -- if your translation passes all characterization tests, you can be confident the business logic is preserved.

You are not testing the MUMPS code directly. Instead, you are reimplementing the testable business logic (calculations, validations, data transformations) in your target language and writing tests against those implementations.

## Tasks

1. **Set up your target language project.** Create a new project in the challenge folder for your chosen language (e.g., `psl/`, `java/`, `python/`, `typescript/`). Set up a test framework (JUnit 5, pytest, Jest, xUnit -- whatever fits your language). Define the project structure you will use for the full translation in Stage 4.

2. **Test the utility functions.** Start with `BNKUTIL.m` -- the simplest module. Implement and test:
   - Date formatting (`FMTDT`): YYYYMMDD to MM/DD/YYYY
   - Date validation (`VALDATE`): valid and invalid dates, leap years
   - Month addition (`ADDMON`): edge cases around year boundaries and month-end clamping
   - Currency formatting (`FMTCUR`): negative numbers, zero, large numbers, decimal handling
   - String operations (`UPPER`, `LPAD`, `TRIM`)

3. **Test the validation logic.** From `BNKCUST.m`, implement and test:
   - SSN validation (`VALSSN`): valid format, wrong length, missing dashes, non-digits
   - ZIP code validation (`VALZIP`): 5-digit, 9-digit with dash, invalid
   - SSN masking (`MASKSSN`): full SSN, short input
   - Adult age check (`ISADULT`): exactly 18, under 18, birthday edge cases

4. **Test the financial calculations.** These are the critical ones. From `BNKLOAN.m` and `BNKINTR.m`:
   - Monthly payment calculation (`CALCPMT`): verify against known PMT formula values. Test with P=$25,000 R=8.5% N=60, P=$75,000 R=8.5% N=120, and the 0% edge case.
   - Interest portion calculation (`INTPART`): verify the monthly interest split
   - Amortization schedule: verify that the full schedule sums correctly (total payments = principal + total interest)
   - Savings interest accrual: daily rate calculation, month-end posting logic
   - FD maturity interest: simple interest formula `P * R * T`

5. **Test the transaction rules.** From `BNKTXN.m` and `BNKACCT.m`:
   - Deposit validations: positive amount, active account, no FD deposits
   - Withdrawal validations: sufficient funds, daily limit, FD restriction
   - Transfer validations: both accounts active, not same account, transfer limit, locking order
   - Overdraft logic: checking accounts allow overdraft, savings do not
   - Minimum opening deposit by account type

6. **Test the batch processing logic.** From `BNKBATCH.m`:
   - Monthly fee charging: only on the 1st, only for checking below $500
   - Loan overdue detection: 30-day and 90-day thresholds
   - Batch idempotency: cannot run twice on the same day

7. **Test the authentication rules.** From `BNKAUTH.m`:
   - Password hashing produces consistent output for the same input
   - Login lockout after 3 failed attempts
   - Disabled accounts cannot log in
   - Role checks (admin, teller, auditor)

If your Translation agent or business-rule skill misses a MUMPS rounding quirk or the month-end edge case, refine that customization with the specific rule before rerunning it.

## What Copilot Helps With vs. What Requires Your Judgment

**Copilot is good at:** Generating test boilerplate, producing edge case lists from a business rule description, translating a MUMPS formula into your language, scaffolding the test project structure.

**You decide:** Which behaviors are intentional vs. accidental (is the month-end interest posting at day >= 28 a bug or a feature?), what level of precision to test financial calculations at, and how to model the MUMPS global database in your target language's type system.

## Verification

- [ ] Target language project set up with test framework
- [ ] Utility function tests passing (date, currency, string operations)
- [ ] Validation logic tests passing (SSN, ZIP, age check)
- [ ] Financial calculation tests passing (PMT, interest, amortization)
- [ ] Transaction rule tests passing (deposit, withdrawal, transfer constraints)
- [ ] Batch processing logic tests passing (fees, overdue detection)
- [ ] Authentication rule tests passing
- [ ] All tests green -- this is your safety net for Stage 4

---

Previous: [Stage 1: Code Archaeology](stage-1-archaeology.md) | Next: [Stage 3: Feature Evolution](stage-3-evolution.md)
