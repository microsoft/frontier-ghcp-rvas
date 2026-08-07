# Phase 3: Feature Evolution

**Duration:** 1.5-2 hours
**Focus:** Extending the system with new features to test your understanding

## Objective

Prove you understand the system by extending it. Add new features that require touching multiple modules and maintaining consistency with the existing data model, business rules, and coding patterns. You can do this in MUMPS (if you have YottaDB running) or in your target language (if you already started translating in Phase 2).

## Choose Your Features

Pick **at least two** from the list below. Each one exercises a different part of the system.

### Feature A: Multi-Currency Support

Add support for accounts denominated in EUR and GBP in addition to USD. This requires:

- A currency exchange rate table in `^BNKCONF`
- Validation that transfers between accounts in different currencies apply the exchange rate
- Currency display in all reports and statements
- A restriction: Fixed Deposits must remain in their original currency

### Feature B: Scheduled Transfers

Add a recurring transfer capability:

- A new global `^SCHED` to store scheduled transfer definitions (source, destination, amount, frequency, next run date)
- A menu option to create/view/cancel scheduled transfers
- Integration into the batch module to execute due transfers during EOD processing
- Proper error handling when a scheduled transfer fails (insufficient funds)

### Feature C: Account Statements by Email

Add the ability to generate a statement and "send" it (write to a file in a customer-specific directory):

- Generate the account statement in a structured format (CSV or JSON)
- Write it to `statements/<customerID>/<accountID>_<date>.csv`
- Add a menu option and a batch option (monthly auto-generation)
- Include all transactions for the billing period

### Feature D: Overdraft Protection Linking

Allow a savings account to be linked as overdraft protection for a checking account:

- A new field on checking accounts: `ODPROTECT` linking to a savings account
- When a checking withdrawal would exceed the balance + overdraft limit, automatically transfer the shortfall from the linked savings account
- Record both transactions (the transfer and the original withdrawal)
- A menu option to link/unlink the protection account

### Feature E: Interest Rate Tiers

Replace the flat savings interest rate with tiered rates based on balance:

- Balance < $1,000: base rate
- Balance $1,000-$25,000: base rate + 0.5%
- Balance $25,000-$100,000: base rate + 1.0%
- Balance > $100,000: base rate + 1.5%

Update the interest calculation module and the reporting module to reflect tiers.

### Feature F: Transaction Search

Add a global transaction search that works across all accounts:

- Search by date range, amount range, transaction type, or description keyword
- Display results with account number, customer name, and full transaction details
- Add the option to export results to CSV
- Consider performance: how do you query efficiently across the `^TXNLOG` global?

## Tasks

1. **Design the feature.** Before writing code, document what changes are needed: which globals, which routines, what new menu options, what edge cases.
2. **Implement** the feature in your chosen language (MUMPS or target).
3. **Write tests** for the new functionality, following the same patterns from Phase 2.
4. **Update your architecture document** from Phase 1 to reflect the additions.

## Copilot Tips for This Phase

- Describe the feature to Copilot in banking terms first, then ask for the implementation. "Add a scheduled transfers table that the EOD batch picks up and executes" gives better results than "add a cron job."
- If implementing in MUMPS, ask Copilot to generate code that follows the existing style -- point it at an existing routine as a reference.
- Use agent mode to scaffold the full feature (data model + business logic + menu integration + tests) in one pass, then refine.

## Verification

- [ ] At least two features selected and designed
- [ ] Features implemented with proper data model changes
- [ ] Tests written and passing for new features
- [ ] Existing tests still pass (no regressions)
- [ ] Architecture document updated

---

Previous: [Phase 2: Characterization Testing](phase-2-testing.md) | Next: [Phase 4: Language Translation](phase-4-translation.md)
