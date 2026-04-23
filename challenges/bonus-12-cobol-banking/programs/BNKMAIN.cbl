>>SOURCE FORMAT IS FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. BNKMAIN.
*> First National Bank - Core Banking System v3.2.1
*> Main Menu and System Entry Point
*> Original author: R.K. Sharma, 1997
*> Last modified: J. Patterson, Nov 2019
*> COBOL translation from MUMPS original

ENVIRONMENT DIVISION.

DATA DIVISION.
WORKING-STORAGE SECTION.
01  WS-OPTION              PIC X(1).
01  WS-INPUT               PIC X(80).
01  WS-CONFIRM             PIC X(10).

*> Session state
01  WS-LOGGED-IN           PIC 9(1) VALUE 0.
01  WS-BNKUSER             PIC X(20).
01  WS-BNKUSNM             PIC X(40).
01  WS-BNKROLE             PIC X(10).
01  WS-IS-ADMIN            PIC X(1).
01  WS-IS-TELLER           PIC X(1).

01  WS-CURRENT-DT.
    05  WS-NOW-YEAR        PIC 9(4).
    05  WS-NOW-MONTH       PIC 9(2).
    05  WS-NOW-DAY         PIC 9(2).
    05  WS-NOW-HOUR        PIC 9(2).
    05  WS-NOW-MIN         PIC 9(2).
    05  WS-NOW-SEC         PIC 9(2).
    05  WS-NOW-HSEC        PIC 9(2).
01  WS-DATETIME-STR        PIC X(19).

PROCEDURE DIVISION.
MAIN-PARA.
    *> Authenticate user
    CALL "BNKAUTH"
    *> In standalone mode, call the login procedure directly
    *> The login sets WS-LOGGED-IN, WS-BNKUSER, etc.

    PERFORM LOGIN-SEQUENCE
    IF WS-LOGGED-IN = 0
        DISPLAY "Authentication failed."
        STOP RUN
    END-IF

    DISPLAY " "
    DISPLAY "============================================="
    DISPLAY "  FIRST NATIONAL BANK - CORE BANKING SYSTEM"
    DISPLAY "============================================="
    DISPLAY "Welcome, " FUNCTION TRIM(WS-BNKUSNM)
        " (" FUNCTION TRIM(WS-BNKROLE) ")"
    PERFORM BUILD-DATETIME
    DISPLAY "Session started: " WS-DATETIME-STR

    PERFORM MAIN-MENU UNTIL WS-LOGGED-IN = 0

    DISPLAY "Goodbye, " FUNCTION TRIM(WS-BNKUSNM) "."
    STOP RUN.

*> -------------------------------------------------------
*> LOGIN-SEQUENCE: Handle login (placeholder for BNKAUTH)
*> In integrated build, CALL "BNKAUTH" handles this
*> -------------------------------------------------------
LOGIN-SEQUENCE.
    DISPLAY " "
    DISPLAY "=== First National Bank - Login ==="
    DISPLAY "User ID: " WITH NO ADVANCING
    ACCEPT WS-BNKUSER
    IF WS-BNKUSER = SPACES
        EXIT PARAGRAPH
    END-IF
    DISPLAY "Password: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    *> Placeholder: real auth handled by BNKAUTH module
    MOVE 1 TO WS-LOGGED-IN
    MOVE "System Administrator" TO WS-BNKUSNM
    MOVE "ADMIN" TO WS-BNKROLE.

*> -------------------------------------------------------
*> MAIN-MENU: Display and process main menu
*> -------------------------------------------------------
MAIN-MENU.
    DISPLAY " "
    DISPLAY "Main Menu"
    DISPLAY "========="
    DISPLAY "1. Customer Management"
    DISPLAY "2. Account Management"
    DISPLAY "3. Transactions"
    DISPLAY "4. Loan Management"
    DISPLAY "5. Reports"
    DISPLAY "6. End-of-Day Processing"
    DISPLAY "7. System Administration"
    DISPLAY "Q. Logout"
    DISPLAY " "
    DISPLAY "Select option: " WITH NO ADVANCING
    ACCEPT WS-OPTION

    EVALUATE WS-OPTION
        WHEN "1"
            CALL "BNKCUST"
        WHEN "2"
            CALL "BNKACCT"
        WHEN "3"
            PERFORM CHECK-TELLER
            IF WS-IS-TELLER = "Y"
                CALL "BNKTXN"
            ELSE
                PERFORM NO-PERMISSION
            END-IF
        WHEN "4"
            CALL "BNKLOAN"
        WHEN "5"
            CALL "BNKRPT"
        WHEN "6"
            PERFORM CHECK-ADMIN
            IF WS-IS-ADMIN = "Y"
                CALL "BNKBATCH"
            ELSE
                PERFORM NO-PERMISSION
            END-IF
        WHEN "7"
            PERFORM CHECK-ADMIN
            IF WS-IS-ADMIN = "Y"
                PERFORM ADMIN-MENU
            ELSE
                PERFORM NO-PERMISSION
            END-IF
        WHEN "Q"
            MOVE 0 TO WS-LOGGED-IN
        WHEN "q"
            MOVE 0 TO WS-LOGGED-IN
        WHEN OTHER
            DISPLAY "Invalid option."
    END-EVALUATE.

*> -------------------------------------------------------
*> ADMIN-MENU: System Administration Submenu
*> -------------------------------------------------------
ADMIN-MENU.
    DISPLAY " "
    DISPLAY "System Administration"
    DISPLAY "===================="
    DISPLAY "1. User Management"
    DISPLAY "2. System Configuration"
    DISPLAY "3. View Audit Log"
    DISPLAY "4. Initialize System (WARNING: Resets "
        "all data)"
    DISPLAY "B. Back"
    DISPLAY " "
    DISPLAY "Select: " WITH NO ADVANCING
    ACCEPT WS-OPTION

    EVALUATE WS-OPTION
        WHEN "1" CALL "BNKAUTH"
        WHEN "2" PERFORM VIEW-CONFIG
        WHEN "3" CALL "BNKAUDT"
        WHEN "4" PERFORM CONFIRM-RESET
        WHEN "B" CONTINUE
        WHEN "b" CONTINUE
        WHEN OTHER DISPLAY "Invalid option."
    END-EVALUATE.

*> -------------------------------------------------------
*> VIEW-CONFIG: View system configuration
*> -------------------------------------------------------
VIEW-CONFIG.
    DISPLAY " "
    DISPLAY "=== System Configuration ==="
    DISPLAY "  BANK.NAME = First National Bank"
    DISPLAY "  BANK.CODE = FNB001"
    DISPLAY "  BANK.ROUTING = 071000013"
    DISPLAY "  RATES.SAVINGS = 2.50"
    DISPLAY "  RATES.CHECKING = 0.10"
    DISPLAY "  RATES.FIXEDDEP = 5.00"
    DISPLAY "  RATES.LOAN = 8.50"
    DISPLAY "  LIMITS.DAILYWD = 10000"
    DISPLAY "  LIMITS.TRANSFER = 50000"
    DISPLAY "  LIMITS.MAXLOAN = 500000"
    DISPLAY "  FEES.LOWBAL = 12"
    DISPLAY "  FEES.OVERDRAFT = 35"
    DISPLAY "  FEES.WIRE = 25"
    DISPLAY "  FEES.FDBREAK = 0.01".

*> -------------------------------------------------------
*> CONFIRM-RESET: Confirm full system reset
*> -------------------------------------------------------
CONFIRM-RESET.
    DISPLAY " "
    DISPLAY "*** WARNING: This will ERASE ALL customer,"
        " account,"
    DISPLAY "    transaction, and loan data. ***"
    DISPLAY "Type RESET to confirm: " WITH NO ADVANCING
    ACCEPT WS-CONFIRM
    IF WS-CONFIRM = "RESET"
        CALL "BNKINIT"
        DISPLAY "System reinitialized."
    ELSE
        DISPLAY "Reset cancelled."
    END-IF.

*> -------------------------------------------------------
*> Permission checks
*> -------------------------------------------------------
CHECK-ADMIN.
    IF WS-BNKROLE = "ADMIN"
        MOVE "Y" TO WS-IS-ADMIN
    ELSE
        MOVE "N" TO WS-IS-ADMIN
    END-IF.

CHECK-TELLER.
    IF WS-BNKROLE = "TELLER" OR WS-BNKROLE = "ADMIN"
        MOVE "Y" TO WS-IS-TELLER
    ELSE
        MOVE "N" TO WS-IS-TELLER
    END-IF.

NO-PERMISSION.
    DISPLAY "Access denied. Insufficient privileges "
        "for this operation.".

*> -------------------------------------------------------
*> BUILD-DATETIME
*> -------------------------------------------------------
BUILD-DATETIME.
    MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DT
    STRING WS-NOW-YEAR WS-NOW-MONTH WS-NOW-DAY
        " "
        WS-NOW-HOUR ":" WS-NOW-MIN ":" WS-NOW-SEC
        DELIMITED BY SIZE INTO WS-DATETIME-STR
    END-STRING.
