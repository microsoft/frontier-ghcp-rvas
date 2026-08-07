# Stage 4: Language Translation

**Duration:** 2.5-3 hours
**Focus:** Translating the full MUMPS system to a modern language while preserving behavior

## Objective

Translate the core banking system from MUMPS to your chosen modern language. The translated system must pass all characterization tests from Stage 2. This is not a rewrite from scratch -- it is a faithful translation that preserves every business rule, validation, and calculation while adopting modern language patterns.

## Translation Strategy

There are two valid approaches. Pick the one that matches your preference.

**Bottom-up:** Start with utilities and data-access, then build up to business logic, then add the service layer. This is safer -- each layer can be tested independently.

**Module-by-module:** Translate one MUMPS routine at a time (e.g., all of BNKUTIL, then BNKCUST, then BNKACCT). This keeps the mental context tight.

Either way, run your characterization tests continuously. Every green test is proof that a piece of business logic survived the translation intact.

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

**Copilot is good at:** Converting MUMPS syntax to your target language line-by-line, generating class skeletons from your architecture decisions, producing repository / DAO implementations from the data model, rewriting utility functions.

**You decide:** The overall architecture (Copilot generates what you describe -- describe well), how to handle the impedance mismatch between MUMPS globals and your persistence model, when a MUMPS behavior is a bug vs. intentional (your characterization tests resolve this), and what "idiomatic" means in your target language.

## Verification

- [ ] Target architecture documented (data layer, module structure, error handling)
- [ ] Data layer translated with storage for all 8 globals
- [ ] All business logic modules translated
- [ ] All characterization tests from Stage 2 passing against translated code
- [ ] At least 3 technical debt items fixed in the translated version
- [ ] Code compiles/runs and produces correct output for basic operations

---

Previous: [Stage 3: Feature Evolution](stage-3-evolution.md)
