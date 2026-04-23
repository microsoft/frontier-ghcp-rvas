# Phase 4: Full-Stack Modernization

[Back to Legacy COBOL Banking Modernization Track](../bonus-cobol-modernization-track.md)

**Duration:** 2.5-3 hours
**Focus:** Building a modern web application from the COBOL business logic -- React frontend + API backend

## Objective

Modernize the core banking system from a COBOL terminal application into a full web application. The backend exposes the business logic as a REST API. The frontend is a React application with a modern, polished UI. The modernized system must pass all characterization tests from Phase 2 -- every business rule, validation, and calculation must survive the translation intact.

This is not a terminal app with a web wrapper. You are building a real web application that a bank employee would use at their desk.

## Tools Setup

Install the frontend-design skill before starting this phase. It gives Copilot the ability to generate polished React components and page layouts:

```shell
npx skills install anthropics/claude-code
```

When prompted, select `frontend-design` from the list. This skill teaches Copilot how to scaffold React components from descriptions, suggest layouts, and help with UI/UX decisions. Use it naturally in Copilot chat -- ask for component designs, page layouts, or form structures and the skill guides the output.

## Tasks

### Backend: REST API

1. **Design the API layer.** Before translating any code, decide on:
   - How to model the COBOL ISAM files: in-memory maps, an ORM with SQLite/PostgreSQL, a repository pattern with interfaces, or something else
   - Module structure: one service per COBOL program, or reorganized by domain (Customer, Account, Transaction, Loan)
   - Error handling: COBOL uses status codes and condition checks; your language has exceptions or result types
   - How to handle COBOL's sequential file locking: database transactions, optimistic locking, or something else
   - API design: RESTful endpoints organized by resource

2. **Translate the data layer.** Replace ISAM file access with your persistence strategy:
   - Customer file -> Customer storage with indexes
   - Account file -> Account storage with customer cross-references
   - Transaction log -> Transaction log with account and date indexes
   - Loan file -> Loan records with customer cross-references
   - User file -> User/authentication store
   - Audit file -> Append-only audit log
   - Configuration file -> System configuration
   - Batch history -> Batch run history
   - Preserve the ID generation and sequencing behavior

3. **Translate the business logic.** For each COBOL program, produce the equivalent backend service:
   - Utilities -> Helper/utility classes (date, currency, string operations)
   - Authentication -> Auth service with JWT or session-based auth (login, role checks, password hashing)
   - Customer management -> Customer service (CRUD, search, validation)
   - Account management -> Account service (open, close, view, balance inquiry)
   - Transactions -> Transaction service (deposit, withdraw, transfer, fee, credit)
   - Loans -> Loan service (origination, payment, payoff, amortization)
   - Interest -> Interest calculation service
   - Reports -> Report service (statements, daily reports, portfolio summaries)
   - Batch -> Batch processing service (EOD runner)
   - Audit -> Audit service

4. **Preserve the tricky parts.** Pay special attention to:
   - Transfer locking order (lower account ID first to prevent deadlocks)
   - The PMT formula for loan payments (COMP-3 packed decimal precision matters -- verify against COBOL's results)
   - Interest accrual and month-end posting logic
   - Daily withdrawal limit check (sum of today's withdrawals)
   - FD early closure penalty calculation
   - Batch idempotency (one run per day)
   - Loan default escalation (30-day warning, 90-day default)

### Frontend: React UI

5. **Design and implement the React frontend.** Use Copilot with the `frontend-design` skill to help scaffold components and layouts. The application should include these pages:
   - **Login screen** -- role-based access (admin, teller, auditor)
   - **Dashboard** -- overview of today's activity, quick actions for tellers
   - **Customer management** -- search, create, edit customers with validation
   - **Account overview** -- list accounts for a customer, show balances, transaction history with filtering
   - **Transfer form** -- account-to-account transfer with real-time validation (balance check, daily limits, same-account prevention)
   - **Loan management** -- application form, payment screen, amortization schedule display, payoff calculator
   - **Reports and statements** -- account statements with date range selection, daily activity reports, portfolio summaries with tables or charts
   - **Admin panel** -- user management, system configuration, batch processing controls, audit log viewer

6. **Make it look good.** This is a banking application -- it should feel professional and trustworthy. Use a component library (Material UI, Ant Design, Chakra UI) or a utility framework (Tailwind CSS). Pay attention to form validation feedback, loading states, error messages, and responsive layout. The `frontend-design` skill is particularly useful here for generating polished component designs.

### Integration and Verification

7. **Run your characterization tests.** Every test from Phase 2 should pass against the backend services. Fix any discrepancies by comparing the COBOL logic with your translation.

8. **Fix the known technical debt.** Now that the code is in a language you control:
   - Replace the hardcoded maintenance fee with a configurable value
   - Fix the month-end interest posting to use actual calendar month-end dates
   - Implement proper password hashing (bcrypt, argon2, or equivalent)
   - Remove dead code paths
   - Apply the FD early closure penalty from configuration instead of hardcoded values

9. **End-to-end smoke test.** Manually test the full workflow through the React UI:
   - Log in as a teller
   - Create a customer
   - Open a checking and savings account
   - Make a deposit, withdrawal, and transfer
   - View the transaction history
   - Run end-of-day batch
   - Check the reports

## What Copilot Helps With vs. What Requires Your Judgment

**Copilot is good at:** Converting COBOL paragraphs to your backend language, generating REST endpoint boilerplate, producing repository/DAO implementations from the data model, rewriting utility functions, generating test fixtures.

**The frontend-design skill is good at:** Scaffolding React components from descriptions, designing page layouts, generating form validation code, creating responsive UI patterns, suggesting component library usage.

**You decide:** The overall architecture (both tools generate what you describe -- describe well), how to handle the impedance mismatch between COBOL ISAM files and your persistence model, the API contract between frontend and backend, when a COBOL behavior is a bug vs. intentional (your characterization tests resolve this), and the UX flow for the banking application.

## Verification

- [ ] Backend API implemented with all business logic translated
- [ ] Data layer translated with storage for all ISAM file equivalents
- [ ] All characterization tests from Phase 2 passing against backend services
- [ ] React frontend implemented with all required pages
- [ ] Frontend connects to backend API and handles errors gracefully
- [ ] At least 3 technical debt items fixed in the modernized version
- [ ] End-to-end smoke test completed through the UI
- [ ] Application looks and feels like a professional banking tool

---

Previous: [Phase 3: Feature Evolution](phase-3-evolution.md)
