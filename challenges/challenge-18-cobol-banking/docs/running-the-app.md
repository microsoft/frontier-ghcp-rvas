# Running the COBOL banking application

Running the COBOL code is **optional**. You can inspect the `.cbl` files without
compiling them. Use these steps to compare the running program with your
source-derived expectations.

## Prerequisites

Install GnuCOBOL. On Debian/Ubuntu:

```bash
sudo apt-get update
sudo apt-get install -y gnucobol
```

On macOS with Homebrew:

```bash
brew install gnucobol
```

Verify the install:

```bash
cobc --version
```

You should see `cobc (GnuCOBOL)` followed by a version number. Version 3.1.2 or later is recommended.

## Compiling the programs

All commands run from the `challenges/challenge-18-cobol-banking/` directory.

### Step 1: Compile and run the initializer

```bash
cobc -x -free programs/BNKINIT.cbl
./BNKINIT
```

This creates ISAM files in `data/` and loads seed customers, accounts,
transactions, loans, users, and system configuration. It **clears all existing
data**, so run it only when you intend to reset the records.

### Step 2: Compile the main application

`BNKMAIN` calls 10 other modules at runtime. All modules must be compiled together so the linker can resolve them:

```bash
cobc -x -free programs/BNKMAIN.cbl \
    programs/BNKAUTH.cbl programs/BNKCUST.cbl \
    programs/BNKACCT.cbl programs/BNKTXN.cbl \
    programs/BNKLOAN.cbl programs/BNKINTR.cbl \
    programs/BNKBATCH.cbl programs/BNKRPT.cbl \
    programs/BNKAUDT.cbl programs/BNKUTIL.cbl
```

The `-x` flag produces an executable. The `-free` flag enables free-format source (no fixed columns). Copybook paths in the source use relative paths (`copybooks/*.cpy`), so no `-I` flag is needed as long as you compile from the challenge root directory.

If you only run `cobc -x -free programs/BNKMAIN.cbl` without the other modules, you will get `module 'BNKAUTH' not found` at runtime.

### Step 3: Run the application

```bash
./BNKMAIN
```

This launches the main menu. Log in with one of the default accounts:

| User | Password | Role |
|------|----------|------|
| `admin` | `admin123` | ADMIN -- full access including batch processing and user management |
| `teller1` | `teller123` | TELLER -- can process transactions |
| `teller2` | `teller123` | TELLER -- can process transactions |
| `auditor1` | `audit123` | AUDITOR -- read-only access to reports and audit logs |

## Quick walkthrough

After logging in as `admin`, try these operations to get oriented:

1. View customers with option 1 (Customer Management), then search or view by ID.
2. Check an account balance with option 2 (Account Management), then balance inquiry.
3. Make a deposit as `teller1` with option 3 (Transactions), then deposit.
4. Run the end-of-day batch as `admin` with option 6. This calculates interest, checks loans, and charges fees.
5. View statements and portfolio summaries with option 5.

## Stopping the application

Type `Q` at the main menu to log out and exit.

## Troubleshooting

If `cobc` is not found, install GnuCOBOL as described under Prerequisites.

For copybook compilation errors, run the compile command from
`challenges/challenge-18-cobol-banking/` so relative `copybooks/` paths resolve.

For a runtime "file not found" error, check that `data/` exists. Run
`mkdir -p data` if it is missing, then `./BNKINIT` to create the ISAM files.

If `BNKAUTH` is not found, recompile BNKMAIN with the other modules linked.
Use the full command in Step 2.

For "BNKINIT already loaded" or stale data, run `./BNKINIT` to reset the records.
**This wipes all data files** and reloads seed data.

For garbled DISPLAY output, check that your terminal supports standard COBOL
console I/O. If columns are misaligned, widen it to at least 120 characters.
