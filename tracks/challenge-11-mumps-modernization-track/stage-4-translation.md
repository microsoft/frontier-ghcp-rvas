# Stage 4: Language Translation

**Duration:** 2.5-3 hours
**Focus:** Translating the full MUMPS system to a modern language while preserving behavior

## Objective

Translate the core banking system from MUMPS to your chosen modern language. Preserve all business rules, validations, and calculations while using the target language's conventions. The translation must pass all Stage 2 characterization tests.

## Translation Strategy

Choose one of these approaches:

Bottom-up translation starts with utilities and data access, followed by business logic and the service layer. Test each layer independently.

Module-by-module translation handles one routine at a time (e.g., BNKUTIL, then BNKCUST, then BNKACCT). This limits how much code you need to consider at once.

Run characterization tests throughout translation. Passing tests show that the covered behaviors match.

## Tasks

1. **Design the target architecture.** Before translating any code, decide on:
   - How to model the MUMPS global database: in-memory maps, an ORM with SQLite, a repository pattern with interfaces, or something else
   - Class/module structure: one class per MUMPS routine, or reorganized by domain (Customer, Account, Transaction, Loan)
   - Error handling: MUMPS uses `$ZTRAP` and status checks; your language likely has exceptions
   - How to handle LOCK semantics: thread synchronization, database locks, or something else
   - Input/output: the MUMPS system is terminal-based (READ/WRITE); your translation can keep a CLI, expose a REST API, or use any interface

2. **Translate the data layer.** Replace `^GLOBAL` access with your persistence strategy:
   - `^CUST` -> Customer storage with indexes
   - `^ACCT` -> Account storage with customer cross-references
   - `^TXNLOG` -> Transaction log with account and date indexes
   - `^LOAN` -> Loan records with customer cross-references
   - `^USER` -> User/authentication store
   - `^AUDIT` -> Append-only audit log
   - `^BNKCONF` -> System configuration
   - `^BATCH` -> Batch run history
   - Preserve the ID generation and sequencing behavior

3. **Translate the business logic modules.** For each MUMPS routine, produce the equivalent in your target:
   - `BNKUTIL` -> Utility/helper classes (date, currency, string operations)
   - `BNKAUTH` -> Authentication service (login, role checks, password hashing)
   - `BNKCUST` -> Customer service (CRUD, search, validation)
   - `BNKACCT` -> Account service (open, close, view, balance inquiry)
   - `BNKTXN` -> Transaction service (deposit, withdraw, transfer, fee, credit)
   - `BNKLOAN` -> Loan service (origination, payment, payoff, amortization)
   - `BNKINTR` -> Interest calculation service
   - `BNKRPT` -> Report service (statements, daily reports, portfolio summaries)
   - `BNKBATCH` -> Batch processing service (EOD runner)
   - `BNKAUDT` -> Audit service
   - `BNKINIT` -> Data initialization / seed data

4. **Preserve the tricky parts.** Pay special attention to:
   - Transfer locking order (lower account ID first to prevent deadlocks)
   - The PMT formula for loan payments (floating-point precision matters)
   - Interest accrual bucket (`ACCRINT`) and month-end posting logic
   - Daily withdrawal limit check (sum of today's withdrawals)
   - FD early closure penalty calculation
   - Batch idempotency (one run per day)
   - Loan default escalation (30-day warning, 90-day default)

5. **Run your characterization tests.** Every test from Stage 2 should pass against the translated code. Fix any discrepancies by comparing the MUMPS logic with your translation.

6. **Fix the known technical debt.** Now that the code is in a language you control:
   - Replace the hardcoded maintenance fee with a configurable value
   - Fix the month-end interest posting to use actual calendar month-end dates
   - Implement proper password hashing (bcrypt, argon2, or equivalent)
   - Remove the dead GOLD account type code path
   - Apply the FD early closure penalty from configuration instead of hardcoded 1%

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can translate syntax and utilities, generate class skeletons, and draft repository or DAO implementations.

You choose the architecture and how to map MUMPS globals to your persistence model. Use characterization tests to record existing behavior, then decide which quirks are bugs and how to apply target-language conventions.

## Verification

- [ ] Target architecture documented (data layer, module structure, error handling)
- [ ] Data layer translated with storage for all 8 globals
- [ ] All business logic modules translated
- [ ] All characterization tests from Stage 2 passing against translated code
- [ ] At least 3 technical debt items fixed in the translated version
- [ ] Code compiles/runs and produces correct output for basic operations

---

Previous: [Stage 3: Feature Evolution](stage-3-evolution.md)
