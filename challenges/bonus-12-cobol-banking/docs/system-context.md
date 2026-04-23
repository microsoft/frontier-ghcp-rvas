# System Context: First National Bank Core Banking

First National Bank has operated this core banking system since 1997. The system was originally written by R.K. Sharma and has been maintained by a series of developers over the years. The most recent changes were made by J. Patterson in 2019.

This is the COBOL translation of the original MUMPS codebase. The business logic is identical -- same features, same quirks, same known issues.

## What the system does

The application handles day-to-day banking operations:

- Customer enrollment and identity management
- Deposit accounts (savings, checking, fixed deposits)
- Teller transactions (deposits, withdrawals, transfers)
- Consumer loan origination and payment processing
- Interest calculation and end-of-day batch processing
- Audit trail for all operations
- Role-based access (admin, teller, auditor)

## Technology

The system is written in **COBOL** (free format), targeting the **GnuCOBOL** compiler. Where the original MUMPS system stored data in global variables that persist to disk automatically, the COBOL version uses **indexed sequential (ISAM) files** with `RECORD KEY` and `ALTERNATE RECORD KEY` declarations for lookups by secondary fields.

All source programs are in the `programs/` directory (`.cbl` files). Shared record layouts live in `copybooks/` (`.cpy` files). Runtime data files are written to `data/`.

### File organization

| Data file | Key | Alternate keys | Maps to MUMPS global |
|-----------|-----|----------------|----------------------|
| USERFILE | USER-ID | -- | `^USER` |
| CUSTFILE | CUST-ID | CUST-SSN, CUST-LAST-NAME | `^CUST` |
| ACCTFILE | ACCT-ID | ACCT-CUST-ID | `^ACCT` |
| TXNFILE | TXN-ID | TXN-ACCT-ID | `^TXNLOG` |
| LOANFILE | LOAN-ID | LOAN-CUST-ID | `^LOAN` |
| AUDITFILE | AUDIT-ID | AUDIT-DATE-IDX | `^AUDIT` |
| BATCHFILE | BATCH-RUN-ID | -- | `^BATCH` |
| CONFFILE | CONF-KEY | -- | `^BNKCONF` |

## Known issues from the maintenance log

These are carried over from the original MUMPS system and exist in the COBOL code as well:

- A hardcoded `$12` fee amount in the batch module that should read from the configuration file (noted 2017)
- A comment referencing a "temporary fix" from 2012 in the FD early closure penalty logic that was never cleaned up
- A dead code path for a "GOLD" account type that was discontinued in 2014
- Interest posting uses day-of-month >= 28 as a rough month-end check instead of actual calendar logic
- Fixed deposit interest uses simple interest (`P * R * T / 12`) while savings/checking use daily accrual -- compound interest was proposed in 2016 but never implemented
- The password hashing function (djb2 variant) is not cryptographically secure (noted in code comments)
- The days-difference calculation treats all months as 30 days
- Transfer locking order was fixed in 2018 (ticket #3887) to always lock the lower account ID first

## Default credentials

After initialization, log in with:

- **User:** `admin`
- **Password:** `admin123`

Other users: `teller1`, `teller2` (password: `teller123`), `auditor1` (password: `audit123`).

For build and run instructions, see [Running the App](running-the-app.md).
