# Running the COBOL Banking Application

Running the COBOL code is **optional** for this challenge -- you can read and work with the `.cbl` files without compiling. But if you want to see the system in action, here is how.

## Prerequisites

You need **GnuCOBOL** installed. On Debian/Ubuntu:

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

## Compiling the Programs

From the `challenges/bonus-12-cobol-banking/` directory:

```bash
# Compile the initialization program first
cobc -x -free -I copybooks -o bnkinit programs/BNKINIT.cbl

# Compile the main application (links all modules)
cobc -x -free -I copybooks -o bnkmain programs/BNKMAIN.cbl \
    programs/BNKAUTH.cbl programs/BNKCUST.cbl \
    programs/BNKACCT.cbl programs/BNKTXN.cbl \
    programs/BNKLOAN.cbl programs/BNKINTR.cbl \
    programs/BNKBATCH.cbl programs/BNKRPT.cbl \
    programs/BNKAUDT.cbl programs/BNKUTIL.cbl
```

The `-free` flag enables free-format source (no fixed columns). The `-I copybooks` flag tells the compiler where to find `.cpy` copybook files.

If you want to compile each program as a standalone module:

```bash
for f in programs/*.cbl; do
    cobc -free -I copybooks -c "$f"
done
```

## Initializing the Database

Run the initialization program to create all ISAM data files and load seed data:

```bash
./bnkinit
```

This creates files in the `data/` directory. The seed data includes customers, accounts, transactions, loans, users, and system configuration -- the same data as the MUMPS version.

This step **clears all existing data** and creates fresh records. Only run it when you want a clean slate.

## Starting the Application

```bash
./bnkmain
```

This launches the main menu. Log in with one of the default accounts:

| User | Password | Role |
|------|----------|------|
| `admin` | `admin123` | ADMIN -- full access including batch processing and user management |
| `teller1` | `teller123` | TELLER -- can process transactions |
| `teller2` | `teller123` | TELLER -- can process transactions |
| `auditor1` | `audit123` | AUDITOR -- read-only access to reports and audit logs |

## Quick Walkthrough

After logging in as `admin`, try these operations to get oriented:

1. **View customers** -- Select option 1 (Customer Management), then search or view by ID.
2. **Check an account balance** -- Option 2 (Account Management), then balance inquiry.
3. **Make a deposit** -- Log in as `teller1`, option 3 (Transactions), then deposit.
4. **Run end-of-day batch** -- Log in as `admin`, option 6. This calculates interest, checks loans, and charges fees.
5. **View reports** -- Option 5 for statements and portfolio summaries.

## Stopping the Application

Type `Q` at the main menu to log out and exit.

## Troubleshooting

**"cobc: command not found"** -- GnuCOBOL is not installed. See Prerequisites above.

**Compilation errors about copybooks** -- Make sure you include `-I copybooks` in the compile command so the compiler can find the `.cpy` files.

**"file not found" at runtime** -- The `data/` directory must exist. Run `mkdir -p data` if it is missing, then run `./bnkinit` to create the ISAM files.

**"BNKINIT already loaded" or stale data** -- Run `./bnkinit` again to reset everything. This is destructive -- it wipes all data files and reloads seed data.

**Garbled terminal output** -- Some terminals handle the DISPLAY output differently. Make sure your terminal supports standard COBOL console I/O. If columns look off, widen your terminal to at least 120 characters.
