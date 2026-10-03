# Stage 2: Characterization Testing

**Duration:** 2-3 hours
**Focus:** Writing tests that capture existing behavior before changing anything

## Objective

Write tests in your target language that capture the banking system's current behavior. Use them in Stage 4 to check the translated business logic.

You are not testing the MUMPS code directly. Instead, you are reimplementing the testable business logic (calculations, validations, data transformations) in your target language and writing tests against those implementations.

## Tasks

1. Create a target-language project in the challenge folder (e.g., `psl/`, `java/`, `python/`, `typescript/`). Set up a suitable test framework such as JUnit 5, pytest, Jest, or xUnit. Define the structure for the full Stage 4 translation.

2. Start with utility functions in `BNKUTIL.m`, the simplest module. Implement and test:
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

4. **Test the financial calculations** from `BNKLOAN.m` and `BNKINTR.m`:
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

Copilot can draft tests and edge case lists, translate formulas, and set up the test project.

You decide whether behaviors such as interest posting at day >= 28 are intentional. Choose the precision for financial tests and how to model MUMPS globals in your target language.

## Verification

- [ ] Target language project set up with test framework
- [ ] Utility function tests passing (date, currency, string operations)
- [ ] Validation logic tests passing (SSN, ZIP, age check)
- [ ] Financial calculation tests passing (PMT, interest, amortization)
- [ ] Transaction rule tests passing (deposit, withdrawal, transfer constraints)
- [ ] Batch processing logic tests passing (fees, overdue detection)
- [ ] Authentication rule tests passing
- [ ] All tests pass before Stage 4

---

Previous: [Stage 1: Code Archaeology](stage-1-archaeology.md) | Next: [Stage 3: Feature Evolution](stage-3-evolution.md)
