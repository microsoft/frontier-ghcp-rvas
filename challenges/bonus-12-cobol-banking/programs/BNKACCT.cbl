>>SOURCE FORMAT IS FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. BNKACCT.
*> Account Management Module
*> Open, close, view, and list bank accounts
*> Account types: SAV (Savings), CHK (Checking), FD (Fixed Deposit)

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT ACCTFILE ASSIGN TO "data/ACCTFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS ACCT-ID
        ALTERNATE RECORD KEY IS ACCT-CUST-ID
            WITH DUPLICATES
        FILE STATUS IS WS-FILE-STATUS.

    SELECT CUSTFILE ASSIGN TO "data/CUSTFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS CUST-ID
        FILE STATUS IS WS-CUST-STATUS.

DATA DIVISION.
FILE SECTION.
FD  ACCTFILE.
    COPY "copybooks/ACCTFLD.cpy".

FD  CUSTFILE.
    COPY "copybooks/CUSTFLD.cpy".

WORKING-STORAGE SECTION.
01  WS-FILE-STATUS         PIC X(2).
01  WS-CUST-STATUS         PIC X(2).
01  WS-EOF                 PIC 9(1) VALUE 0.
01  WS-OPTION              PIC X(1).
01  WS-INPUT               PIC X(80).
01  WS-ACCT-SEQ            PIC 9(6) VALUE 100000.
01  WS-CONFIRM             PIC X(1).

01  WS-BNKUSER             PIC X(20).
01  WS-BNKROLE             PIC X(10).

01  WS-OPEN-CID            PIC 9(5).
01  WS-OPEN-TYPE           PIC X(3).
01  WS-OPEN-DEP            PIC S9(11)V99.
01  WS-OPEN-RATE           PIC 9(3)V99.
01  WS-OPEN-TERM           PIC 9(3).
01  WS-MIN-DEP             PIC S9(11)V99.

01  WS-CLOSE-BAL           PIC S9(11)V99.
01  WS-CLOSE-PEN           PIC S9(11)V99.

01  WS-CURRENT-DT.
    05  WS-NOW-YEAR        PIC 9(4).
    05  WS-NOW-MONTH       PIC 9(2).
    05  WS-NOW-DAY         PIC 9(2).
    05  WS-NOW-HOUR        PIC 9(2).
    05  WS-NOW-MIN         PIC 9(2).
    05  WS-NOW-SEC         PIC 9(2).
    05  WS-NOW-HSEC        PIC 9(2).
01  WS-DATETIME-STR        PIC X(19).
01  WS-TODAY-STR            PIC 9(8).
01  WS-MATURITY-DATE       PIC 9(8).

PROCEDURE DIVISION.
MAIN-PARA.
    STOP RUN.

*> -------------------------------------------------------
*> ACCT-MENU: Account Management Menu
*> -------------------------------------------------------
ACCT-MENU.
    DISPLAY " "
    DISPLAY "Account Management"
    DISPLAY "=================="
    DISPLAY "1. Open New Account"
    DISPLAY "2. View Account"
    DISPLAY "3. List Customer Accounts"
    DISPLAY "4. Close Account"
    DISPLAY "5. Account Balance Inquiry"
    DISPLAY "B. Back"
    DISPLAY " "
    DISPLAY "Select: " WITH NO ADVANCING
    ACCEPT WS-OPTION

    EVALUATE WS-OPTION
        WHEN "1" PERFORM OPEN-ACCOUNT
        WHEN "2" PERFORM VIEW-ACCOUNT
        WHEN "3" PERFORM LIST-BY-CUSTOMER
        WHEN "4" PERFORM CLOSE-ACCOUNT
        WHEN "5" PERFORM BALANCE-INQUIRY
        WHEN "B" CONTINUE
        WHEN "b" CONTINUE
        WHEN OTHER DISPLAY "Invalid option."
    END-EVALUATE.

*> -------------------------------------------------------
*> OPEN-ACCOUNT: Open a new account
*> -------------------------------------------------------
OPEN-ACCOUNT.
    DISPLAY " "
    DISPLAY "=== Open New Account ==="
    DISPLAY "Customer ID: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF
    MOVE WS-INPUT TO WS-OPEN-CID

    *> Verify customer exists and is active
    OPEN INPUT CUSTFILE
    IF WS-CUST-STATUS NOT = "00"
        DISPLAY "Customer database not found."
        EXIT PARAGRAPH
    END-IF
    MOVE WS-OPEN-CID TO CUST-ID
    READ CUSTFILE
        INVALID KEY
            DISPLAY "Customer not found."
            CLOSE CUSTFILE
            EXIT PARAGRAPH
    END-READ
    IF CUST-STATUS NOT = "ACTIVE"
        DISPLAY "Customer is not active."
        CLOSE CUSTFILE
        EXIT PARAGRAPH
    END-IF
    IF CUST-KYC NOT = "VERIFIED"
        DISPLAY "WARNING: KYC not verified for this "
            "customer."
        DISPLAY "Account will be restricted until KYC "
            "is complete."
    END-IF
    CLOSE CUSTFILE

    DISPLAY "Account Type:"
    DISPLAY "  SAV - Savings Account"
    DISPLAY "  CHK - Checking Account"
    DISPLAY "  FD  - Fixed Deposit"
    DISPLAY "Type: " WITH NO ADVANCING
    ACCEPT WS-OPEN-TYPE
    INSPECT WS-OPEN-TYPE CONVERTING
        "abcdefghijklmnopqrstuvwxyz"
        TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    IF WS-OPEN-TYPE NOT = "SAV"
        AND WS-OPEN-TYPE NOT = "CHK"
        AND WS-OPEN-TYPE NOT = "FD"
        DISPLAY "Invalid account type."
        EXIT PARAGRAPH
    END-IF

    *> Get rate from defaults
    EVALUATE WS-OPEN-TYPE
        WHEN "SAV" MOVE 2.50 TO WS-OPEN-RATE
        WHEN "CHK" MOVE 0.10 TO WS-OPEN-RATE
        WHEN "FD"  MOVE 5.00 TO WS-OPEN-RATE
    END-EVALUATE

    IF WS-OPEN-TYPE = "FD"
        DISPLAY "Fixed Deposit Term (months): "
            WITH NO ADVANCING
        ACCEPT WS-INPUT
        MOVE FUNCTION NUMVAL(WS-INPUT) TO WS-OPEN-TERM
        IF WS-OPEN-TERM < 3
            DISPLAY "Minimum term is 3 months."
            EXIT PARAGRAPH
        END-IF
        IF WS-OPEN-TERM > 120
            DISPLAY "Maximum term is 120 months."
            EXIT PARAGRAPH
        END-IF
    END-IF

    *> Minimum opening deposit
    EVALUATE WS-OPEN-TYPE
        WHEN "SAV" MOVE 100 TO WS-MIN-DEP
        WHEN "CHK" MOVE 50 TO WS-MIN-DEP
        WHEN "FD"  MOVE 1000 TO WS-MIN-DEP
    END-EVALUATE

    DISPLAY "Minimum opening deposit: $" WS-MIN-DEP
    DISPLAY "Initial deposit amount: $"
        WITH NO ADVANCING
    ACCEPT WS-INPUT
    MOVE FUNCTION NUMVAL(WS-INPUT) TO WS-OPEN-DEP
    IF WS-OPEN-DEP < WS-MIN-DEP
        DISPLAY "Deposit below minimum."
        EXIT PARAGRAPH
    END-IF

    *> Generate account number
    OPEN I-O ACCTFILE
    IF WS-FILE-STATUS NOT = "00"
        OPEN OUTPUT ACCTFILE
    END-IF

    MOVE 0 TO WS-EOF
    READ ACCTFILE LAST
        AT END MOVE 1 TO WS-EOF
    END-READ
    IF WS-EOF = 0
        MOVE ACCT-ID TO WS-ACCT-SEQ
    ELSE
        MOVE 100000 TO WS-ACCT-SEQ
    END-IF
    ADD 1 TO WS-ACCT-SEQ

    *> Build account record
    MOVE WS-ACCT-SEQ   TO ACCT-ID
    MOVE WS-OPEN-CID   TO ACCT-CUST-ID
    MOVE WS-OPEN-TYPE  TO ACCT-TYPE
    MOVE WS-OPEN-DEP   TO ACCT-BAL
    MOVE "ACTIVE"       TO ACCT-STATUS
    PERFORM BUILD-DATETIME
    MOVE WS-DATETIME-STR TO ACCT-OPENED
    MOVE WS-OPEN-RATE  TO ACCT-RATE
    MOVE "USD"          TO ACCT-CURRENCY
    MOVE 0              TO ACCT-OVERDRAFT
    MOVE 0              TO ACCT-TERM
    MOVE 0              TO ACCT-MATURITY
    MOVE 0              TO ACCT-ORIG-DEP
    MOVE 0              TO ACCT-ACCR-INT
    MOVE SPACES         TO ACCT-LAST-INT

    IF WS-OPEN-TYPE = "CHK"
        MOVE 0 TO ACCT-OVERDRAFT
    END-IF

    IF WS-OPEN-TYPE = "FD"
        MOVE WS-OPEN-TERM TO ACCT-TERM
        PERFORM CALCULATE-MATURITY
        MOVE WS-MATURITY-DATE TO ACCT-MATURITY
        MOVE WS-OPEN-DEP TO ACCT-ORIG-DEP
    END-IF

    WRITE ACCT-REC
    IF WS-FILE-STATUS = "00"
        DISPLAY " "
        DISPLAY "Account opened successfully."
        DISPLAY "Account Number: " WS-ACCT-SEQ
        DISPLAY "Type: " WS-OPEN-TYPE
        DISPLAY "Interest Rate: " WS-OPEN-RATE "%"
        IF WS-OPEN-TYPE = "FD"
            DISPLAY "Maturity Date: "
                WS-MATURITY-DATE(5:2) "/"
                WS-MATURITY-DATE(7:2) "/"
                WS-MATURITY-DATE(1:4)
        END-IF
        DISPLAY "Balance: $" WS-OPEN-DEP
    ELSE
        DISPLAY "Error creating account."
    END-IF

    CLOSE ACCTFILE.

*> -------------------------------------------------------
*> VIEW-ACCOUNT: View account details
*> -------------------------------------------------------
VIEW-ACCOUNT.
    DISPLAY "Account Number: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN INPUT ACCTFILE
    IF WS-FILE-STATUS NOT = "00"
        DISPLAY "No account data."
        EXIT PARAGRAPH
    END-IF

    MOVE WS-INPUT TO ACCT-ID
    READ ACCTFILE
        INVALID KEY
            DISPLAY "Account not found."
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-READ

    PERFORM DISPLAY-ACCOUNT
    CLOSE ACCTFILE.

*> -------------------------------------------------------
*> DISPLAY-ACCOUNT: Display full account details
*> -------------------------------------------------------
DISPLAY-ACCOUNT.
    DISPLAY " "
    DISPLAY "=== Account Details ==="
    DISPLAY "Account #:     " ACCT-ID
    DISPLAY "Customer ID:   " ACCT-CUST-ID
    DISPLAY "Type:          " ACCT-TYPE
    DISPLAY "Balance:       $" ACCT-BAL
    DISPLAY "Interest Rate: " ACCT-RATE "%"
    DISPLAY "Status:        " FUNCTION TRIM(ACCT-STATUS)
    DISPLAY "Opened:        " FUNCTION TRIM(ACCT-OPENED)
    DISPLAY "Currency:      " ACCT-CURRENCY

    IF ACCT-TYPE = "CHK"
        DISPLAY "Overdraft:     $" ACCT-OVERDRAFT
    END-IF

    IF ACCT-TYPE = "FD"
        DISPLAY "Original Dep:  $" ACCT-ORIG-DEP
        DISPLAY "Term:          " ACCT-TERM " months"
        DISPLAY "Maturity:      "
            ACCT-MATURITY
    END-IF.

*> -------------------------------------------------------
*> LIST-BY-CUSTOMER: List all accounts for a customer
*> -------------------------------------------------------
LIST-BY-CUSTOMER.
    DISPLAY "Customer ID: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN INPUT CUSTFILE
    IF WS-CUST-STATUS NOT = "00"
        DISPLAY "No customer data."
        EXIT PARAGRAPH
    END-IF
    MOVE WS-INPUT TO CUST-ID
    READ CUSTFILE
        INVALID KEY
            DISPLAY "Customer not found."
            CLOSE CUSTFILE
            EXIT PARAGRAPH
    END-READ
    CLOSE CUSTFILE

    OPEN INPUT ACCTFILE
    IF WS-FILE-STATUS NOT = "00"
        DISPLAY "No account data."
        EXIT PARAGRAPH
    END-IF

    DISPLAY " "
    DISPLAY "Acct #  Type   Balance          Status"
    DISPLAY "------  ----   ---------------  ----------"

    MOVE WS-INPUT TO ACCT-CUST-ID
    START ACCTFILE KEY IS = ACCT-CUST-ID
        INVALID KEY
            DISPLAY "(no accounts)"
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-START

    MOVE 0 TO WS-EOF
    PERFORM UNTIL WS-EOF = 1
        READ ACCTFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
        IF WS-EOF = 0
            IF ACCT-CUST-ID = WS-INPUT
                DISPLAY ACCT-ID "  "
                    ACCT-TYPE "    "
                    ACCT-BAL "  "
                    ACCT-STATUS
            ELSE
                MOVE 1 TO WS-EOF
            END-IF
        END-IF
    END-PERFORM

    CLOSE ACCTFILE.

*> -------------------------------------------------------
*> CLOSE-ACCOUNT: Close an account
*> -------------------------------------------------------
CLOSE-ACCOUNT.
    DISPLAY "Account Number to close: "
        WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN I-O ACCTFILE
    IF WS-FILE-STATUS NOT = "00"
        DISPLAY "No account data."
        EXIT PARAGRAPH
    END-IF

    MOVE WS-INPUT TO ACCT-ID
    READ ACCTFILE
        INVALID KEY
            DISPLAY "Account not found."
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-READ

    IF ACCT-STATUS NOT = "ACTIVE"
        DISPLAY "Account is already "
            FUNCTION TRIM(ACCT-STATUS) "."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF

    MOVE ACCT-BAL TO WS-CLOSE-BAL

    *> FD early closure penalty
    IF ACCT-TYPE = "FD"
        IF ACCT-MATURITY > 0
            PERFORM BUILD-TODAY
            IF ACCT-MATURITY > WS-TODAY-STR
                *> Penalty is 1% of balance for early withdrawal
                *> temporary fix - should be configurable
                *> (RKS 2012-03-15)
                COMPUTE WS-CLOSE-PEN =
                    WS-CLOSE-BAL * 0.01
                DISPLAY "Early closure penalty: $"
                    WS-CLOSE-PEN
                SUBTRACT WS-CLOSE-PEN FROM WS-CLOSE-BAL
                DISPLAY "Amount after penalty: $"
                    WS-CLOSE-BAL
            END-IF
        END-IF
    END-IF

    DISPLAY "Closing balance to disburse: $" WS-CLOSE-BAL
    DISPLAY "Confirm closure? (Y/N): " WITH NO ADVANCING
    ACCEPT WS-CONFIRM
    IF WS-CONFIRM NOT = "Y" AND WS-CONFIRM NOT = "y"
        DISPLAY "Closure cancelled."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF

    MOVE "CLOSED" TO ACCT-STATUS
    MOVE 0 TO ACCT-BAL
    REWRITE ACCT-REC
    DISPLAY "Account " FUNCTION TRIM(WS-INPUT) " closed."
    CLOSE ACCTFILE.

*> -------------------------------------------------------
*> BALANCE-INQUIRY: Quick balance inquiry
*> -------------------------------------------------------
BALANCE-INQUIRY.
    DISPLAY "Account Number: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN INPUT ACCTFILE
    IF WS-FILE-STATUS NOT = "00"
        DISPLAY "No account data."
        EXIT PARAGRAPH
    END-IF

    MOVE WS-INPUT TO ACCT-ID
    READ ACCTFILE
        INVALID KEY
            DISPLAY "Account not found."
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-READ

    DISPLAY "Account: " ACCT-ID
    DISPLAY "Type: " ACCT-TYPE
    DISPLAY "Balance: $" ACCT-BAL
    DISPLAY "Status: " FUNCTION TRIM(ACCT-STATUS)
    CLOSE ACCTFILE.

*> -------------------------------------------------------
*> CALCULATE-MATURITY: Add term months to today
*> -------------------------------------------------------
CALCULATE-MATURITY.
    PERFORM BUILD-TODAY
    MOVE WS-TODAY-STR(1:4) TO WS-NOW-YEAR
    MOVE WS-TODAY-STR(5:2) TO WS-NOW-MONTH
    MOVE WS-TODAY-STR(7:2) TO WS-NOW-DAY
    ADD WS-OPEN-TERM TO WS-NOW-MONTH
    PERFORM UNTIL WS-NOW-MONTH <= 12
        SUBTRACT 12 FROM WS-NOW-MONTH
        ADD 1 TO WS-NOW-YEAR
    END-PERFORM
    STRING WS-NOW-YEAR WS-NOW-MONTH WS-NOW-DAY
        DELIMITED BY SIZE INTO WS-MATURITY-DATE
    END-STRING.

*> -------------------------------------------------------
*> BUILD-TODAY / BUILD-DATETIME
*> -------------------------------------------------------
BUILD-TODAY.
    MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DT
    STRING WS-NOW-YEAR WS-NOW-MONTH WS-NOW-DAY
        DELIMITED BY SIZE INTO WS-TODAY-STR
    END-STRING.

BUILD-DATETIME.
    MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DT
    STRING WS-NOW-YEAR WS-NOW-MONTH WS-NOW-DAY
        " "
        WS-NOW-HOUR ":" WS-NOW-MIN ":" WS-NOW-SEC
        DELIMITED BY SIZE INTO WS-DATETIME-STR
    END-STRING.
