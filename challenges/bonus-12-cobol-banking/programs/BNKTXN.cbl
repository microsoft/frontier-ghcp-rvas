>>SOURCE FORMAT IS FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. BNKTXN.
*> Transaction Processing Module
*> Handles deposits, withdrawals, transfers, and fee charging
*> This is the core transactional engine of the banking system

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT ACCTFILE ASSIGN TO "data/ACCTFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS ACCT-ID
        ALTERNATE RECORD KEY IS ACCT-CUST-ID
            WITH DUPLICATES
        FILE STATUS IS WS-ACCT-STATUS.

    SELECT TXNFILE ASSIGN TO "data/TXNFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS TXN-ID
        ALTERNATE RECORD KEY IS TXN-ACCT-ID
            WITH DUPLICATES
        FILE STATUS IS WS-TXN-STATUS.

DATA DIVISION.
FILE SECTION.
FD  ACCTFILE.
    COPY "copybooks/ACCTFLD.cpy".

FD  TXNFILE.
    COPY "copybooks/TXNFLD.cpy".

WORKING-STORAGE SECTION.
01  WS-ACCT-STATUS         PIC X(2).
01  WS-TXN-STATUS          PIC X(2).
01  WS-EOF                 PIC 9(1) VALUE 0.
01  WS-OPTION              PIC X(1).
01  WS-INPUT               PIC X(80).
01  WS-TXN-SEQ             PIC 9(8) VALUE 500000.
01  WS-CONFIRM             PIC X(1).

01  WS-BNKUSER             PIC X(20).
01  WS-BNKROLE             PIC X(10).

*> Transaction work fields
01  WS-ACCT-NUM            PIC 9(6).
01  WS-FROM-ACCT           PIC 9(6).
01  WS-TO-ACCT             PIC 9(6).
01  WS-AMOUNT              PIC S9(11)V99.
01  WS-OLD-BAL             PIC S9(11)V99.
01  WS-NEW-BAL             PIC S9(11)V99.
01  WS-AVAIL               PIC S9(11)V99.
01  WS-OVERDRAFT-AMT       PIC S9(11)V99.

*> Transfer work fields
01  WS-FROM-OLD-BAL        PIC S9(11)V99.
01  WS-FROM-NEW-BAL        PIC S9(11)V99.
01  WS-TO-OLD-BAL          PIC S9(11)V99.
01  WS-TO-NEW-BAL          PIC S9(11)V99.
01  WS-TRANSFER-LIMIT      PIC S9(11)V99 VALUE 50000.
01  WS-LOCK-FIRST          PIC 9(6).
01  WS-LOCK-SECOND         PIC 9(6).
01  WS-TXN-ID1             PIC 9(8).
01  WS-TXN-ID2             PIC 9(8).

*> Saved account record for transfer
01  WS-SAVE-ACCT-REC.
    05  WS-SAVE-ACCT-ID    PIC 9(6).
    05  WS-SAVE-CUST-ID    PIC 9(5).
    05  WS-SAVE-TYPE       PIC X(3).
    05  WS-SAVE-BAL        PIC S9(11)V99.
    05  WS-SAVE-STATUS     PIC X(10).

*> Daily limit check
01  WS-DAILY-LIMIT         PIC S9(11)V99 VALUE 10000.
01  WS-DAILY-TOTAL         PIC S9(11)V99 VALUE 0.
01  WS-LIMIT-OK            PIC 9(1).

*> Transaction history
01  WS-MAX-RECORDS         PIC 9(5) VALUE 20.
01  WS-DISPLAY-CNT         PIC 9(5) VALUE 0.
01  WS-FILTER-TYPE         PIC X(5).

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

PROCEDURE DIVISION.
MAIN-PARA.
    STOP RUN.

*> -------------------------------------------------------
*> TXN-MENU: Transaction Menu
*> -------------------------------------------------------
TXN-MENU.
    DISPLAY " "
    DISPLAY "Transactions"
    DISPLAY "============"
    DISPLAY "1. Deposit"
    DISPLAY "2. Withdrawal"
    DISPLAY "3. Transfer Between Accounts"
    DISPLAY "4. View Transaction History"
    DISPLAY "B. Back"
    DISPLAY " "
    DISPLAY "Select: " WITH NO ADVANCING
    ACCEPT WS-OPTION

    EVALUATE WS-OPTION
        WHEN "1" PERFORM PROCESS-DEPOSIT
        WHEN "2" PERFORM PROCESS-WITHDRAWAL
        WHEN "3" PERFORM PROCESS-TRANSFER
        WHEN "4" PERFORM VIEW-TXN-HISTORY
        WHEN "B" CONTINUE
        WHEN "b" CONTINUE
        WHEN OTHER DISPLAY "Invalid option."
    END-EVALUATE.

*> -------------------------------------------------------
*> PROCESS-DEPOSIT: Process a deposit
*> -------------------------------------------------------
PROCESS-DEPOSIT.
    DISPLAY " "
    DISPLAY "=== Deposit ==="
    DISPLAY "Account Number: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF
    MOVE WS-INPUT TO WS-ACCT-NUM

    OPEN I-O ACCTFILE
    IF WS-ACCT-STATUS NOT = "00"
        DISPLAY "Account file not found."
        EXIT PARAGRAPH
    END-IF

    MOVE WS-ACCT-NUM TO ACCT-ID
    READ ACCTFILE
        INVALID KEY
            DISPLAY "Account not found."
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-READ

    IF ACCT-STATUS NOT = "ACTIVE"
        DISPLAY "Account is not active."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF
    IF ACCT-TYPE = "FD"
        DISPLAY "Cannot deposit into a Fixed Deposit "
            "account."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Current Balance: $" ACCT-BAL
    DISPLAY "Deposit Amount: $" WITH NO ADVANCING
    ACCEPT WS-INPUT
    MOVE FUNCTION NUMVAL(WS-INPUT) TO WS-AMOUNT
    IF WS-AMOUNT <= 0
        DISPLAY "Amount must be positive."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF

    IF WS-AMOUNT > 100000
        DISPLAY "NOTE: Large deposit. CTR filing may "
            "be required."
    END-IF

    MOVE ACCT-BAL TO WS-OLD-BAL
    COMPUTE WS-NEW-BAL = WS-OLD-BAL + WS-AMOUNT
    MOVE WS-NEW-BAL TO ACCT-BAL

    REWRITE ACCT-REC
    CLOSE ACCTFILE

    *> Record transaction
    PERFORM RECORD-DEPOSIT-TXN

    DISPLAY "Deposit successful."
    DISPLAY "Previous Balance: $" WS-OLD-BAL
    DISPLAY "Deposited:        $" WS-AMOUNT
    DISPLAY "New Balance:      $" WS-NEW-BAL.

*> -------------------------------------------------------
*> PROCESS-WITHDRAWAL: Process a withdrawal
*> -------------------------------------------------------
PROCESS-WITHDRAWAL.
    DISPLAY " "
    DISPLAY "=== Withdrawal ==="
    DISPLAY "Account Number: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF
    MOVE WS-INPUT TO WS-ACCT-NUM

    OPEN I-O ACCTFILE
    IF WS-ACCT-STATUS NOT = "00"
        DISPLAY "Account file not found."
        EXIT PARAGRAPH
    END-IF

    MOVE WS-ACCT-NUM TO ACCT-ID
    READ ACCTFILE
        INVALID KEY
            DISPLAY "Account not found."
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-READ

    IF ACCT-STATUS NOT = "ACTIVE"
        DISPLAY "Account is not active."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF
    IF ACCT-TYPE = "FD"
        DISPLAY "Cannot withdraw from Fixed Deposit. "
            "Use account closure."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Current Balance: $" ACCT-BAL
    DISPLAY "Withdrawal Amount: $" WITH NO ADVANCING
    ACCEPT WS-INPUT
    MOVE FUNCTION NUMVAL(WS-INPUT) TO WS-AMOUNT
    IF WS-AMOUNT <= 0
        DISPLAY "Amount must be positive."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF

    *> Daily withdrawal limit check
    PERFORM CHECK-DAILY-LIMIT
    IF WS-LIMIT-OK = 0
        DISPLAY "Daily withdrawal limit exceeded."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF

    MOVE ACCT-BAL TO WS-OLD-BAL

    *> Overdraft logic for checking accounts
    IF ACCT-TYPE = "CHK"
        COMPUTE WS-AVAIL = WS-OLD-BAL + ACCT-OVERDRAFT
        IF WS-AMOUNT > WS-AVAIL
            DISPLAY "Insufficient funds "
                "(including overdraft)."
            CLOSE ACCTFILE
            EXIT PARAGRAPH
        END-IF
        IF WS-AMOUNT > WS-OLD-BAL
            COMPUTE WS-OVERDRAFT-AMT =
                WS-AMOUNT - WS-OLD-BAL
            DISPLAY "NOTE: This withdrawal will use "
                "overdraft protection."
            DISPLAY "Overdraft amount: $"
                WS-OVERDRAFT-AMT
        END-IF
    ELSE
        *> Savings - no overdraft
        IF WS-AMOUNT > WS-OLD-BAL
            DISPLAY "Insufficient funds."
            CLOSE ACCTFILE
            EXIT PARAGRAPH
        END-IF
    END-IF

    COMPUTE WS-NEW-BAL = WS-OLD-BAL - WS-AMOUNT
    MOVE WS-NEW-BAL TO ACCT-BAL

    REWRITE ACCT-REC
    CLOSE ACCTFILE

    *> Record transaction
    PERFORM RECORD-WITHDRAWAL-TXN

    DISPLAY "Withdrawal successful."
    DISPLAY "Previous Balance: $" WS-OLD-BAL
    DISPLAY "Withdrawn:        $" WS-AMOUNT
    DISPLAY "New Balance:      $" WS-NEW-BAL.

*> -------------------------------------------------------
*> PROCESS-TRANSFER: Transfer between two accounts
*> -------------------------------------------------------
PROCESS-TRANSFER.
    DISPLAY " "
    DISPLAY "=== Account Transfer ==="
    DISPLAY "From Account: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF
    MOVE WS-INPUT TO WS-FROM-ACCT

    DISPLAY "To Account: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF
    MOVE WS-INPUT TO WS-TO-ACCT

    IF WS-FROM-ACCT = WS-TO-ACCT
        DISPLAY "Source and destination cannot "
            "be the same."
        EXIT PARAGRAPH
    END-IF

    OPEN I-O ACCTFILE
    IF WS-ACCT-STATUS NOT = "00"
        DISPLAY "Account file not found."
        EXIT PARAGRAPH
    END-IF

    *> Validate source account
    MOVE WS-FROM-ACCT TO ACCT-ID
    READ ACCTFILE
        INVALID KEY
            DISPLAY "Source account not found."
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-READ
    IF ACCT-STATUS NOT = "ACTIVE"
        DISPLAY "Source account is not active."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF
    IF ACCT-TYPE = "FD"
        DISPLAY "Cannot transfer from Fixed Deposit."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF
    MOVE ACCT-BAL TO WS-FROM-OLD-BAL

    *> Save source info
    MOVE ACCT-ID      TO WS-SAVE-ACCT-ID
    MOVE ACCT-CUST-ID TO WS-SAVE-CUST-ID
    MOVE ACCT-TYPE    TO WS-SAVE-TYPE
    MOVE ACCT-BAL     TO WS-SAVE-BAL
    MOVE ACCT-STATUS  TO WS-SAVE-STATUS

    *> Validate destination account
    MOVE WS-TO-ACCT TO ACCT-ID
    READ ACCTFILE
        INVALID KEY
            DISPLAY "Destination account not found."
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-READ
    IF ACCT-STATUS NOT = "ACTIVE"
        DISPLAY "Destination account is not active."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF
    IF ACCT-TYPE = "FD"
        DISPLAY "Cannot transfer into Fixed Deposit."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF
    MOVE ACCT-BAL TO WS-TO-OLD-BAL

    DISPLAY "Source Balance: $" WS-FROM-OLD-BAL
    DISPLAY "Transfer Amount: $" WITH NO ADVANCING
    ACCEPT WS-INPUT
    MOVE FUNCTION NUMVAL(WS-INPUT) TO WS-AMOUNT
    IF WS-AMOUNT <= 0
        DISPLAY "Amount must be positive."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF

    *> Transfer limit
    IF WS-AMOUNT > WS-TRANSFER-LIMIT
        DISPLAY "Transfer exceeds limit of $"
            WS-TRANSFER-LIMIT "."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF

    IF WS-AMOUNT > WS-FROM-OLD-BAL
        DISPLAY "Insufficient funds."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF

    *> Lock lower account ID first to prevent deadlock
    *> BUG: The original code locked in arbitrary order
    *> (ticket #3887)
    *> Fixed 2018-06 by JBP - always lock lower account first
    IF WS-FROM-ACCT < WS-TO-ACCT
        MOVE WS-FROM-ACCT TO WS-LOCK-FIRST
        MOVE WS-TO-ACCT TO WS-LOCK-SECOND
    ELSE
        MOVE WS-TO-ACCT TO WS-LOCK-FIRST
        MOVE WS-FROM-ACCT TO WS-LOCK-SECOND
    END-IF

    *> Compute new balances
    COMPUTE WS-FROM-NEW-BAL =
        WS-FROM-OLD-BAL - WS-AMOUNT
    COMPUTE WS-TO-NEW-BAL =
        WS-TO-OLD-BAL + WS-AMOUNT

    *> Update source account
    MOVE WS-FROM-ACCT TO ACCT-ID
    READ ACCTFILE
        INVALID KEY
            DISPLAY "Error re-reading source."
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-READ
    MOVE WS-FROM-NEW-BAL TO ACCT-BAL
    REWRITE ACCT-REC

    *> Update destination account
    MOVE WS-TO-ACCT TO ACCT-ID
    READ ACCTFILE
        INVALID KEY
            DISPLAY "Error re-reading destination."
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-READ
    MOVE WS-TO-NEW-BAL TO ACCT-BAL
    REWRITE ACCT-REC

    CLOSE ACCTFILE

    *> Record both sides of the transfer
    PERFORM RECORD-TRANSFER-TXN

    DISPLAY "Transfer successful."
    DISPLAY "From " WS-FROM-ACCT ": $"
        WS-FROM-OLD-BAL " -> $" WS-FROM-NEW-BAL
    DISPLAY "To   " WS-TO-ACCT ": $"
        WS-TO-OLD-BAL " -> $" WS-TO-NEW-BAL.

*> -------------------------------------------------------
*> RECORD-DEPOSIT-TXN: Record deposit transaction
*> -------------------------------------------------------
RECORD-DEPOSIT-TXN.
    OPEN I-O TXNFILE
    IF WS-TXN-STATUS NOT = "00"
        OPEN OUTPUT TXNFILE
    END-IF

    PERFORM GET-NEXT-TXN-ID
    PERFORM BUILD-DATETIME

    MOVE WS-TXN-SEQ     TO TXN-ID
    MOVE WS-ACCT-NUM    TO TXN-ACCT-ID
    MOVE "DEP"           TO TXN-TYPE
    MOVE WS-AMOUNT      TO TXN-AMOUNT
    MOVE WS-OLD-BAL     TO TXN-BAL-BEFORE
    MOVE WS-NEW-BAL     TO TXN-BAL-AFTER
    MOVE "Cash deposit"  TO TXN-DESC
    MOVE WS-DATETIME-STR TO TXN-DATETIME
    MOVE WS-BNKUSER     TO TXN-TELLER
    MOVE 0               TO TXN-REF-ID
    MOVE WS-TODAY-STR    TO TXN-DATE-IDX

    WRITE TXN-REC
    CLOSE TXNFILE.

*> -------------------------------------------------------
*> RECORD-WITHDRAWAL-TXN: Record withdrawal transaction
*> -------------------------------------------------------
RECORD-WITHDRAWAL-TXN.
    OPEN I-O TXNFILE
    IF WS-TXN-STATUS NOT = "00"
        OPEN OUTPUT TXNFILE
    END-IF

    PERFORM GET-NEXT-TXN-ID
    PERFORM BUILD-DATETIME

    MOVE WS-TXN-SEQ        TO TXN-ID
    MOVE WS-ACCT-NUM       TO TXN-ACCT-ID
    MOVE "WDR"              TO TXN-TYPE
    MOVE WS-AMOUNT         TO TXN-AMOUNT
    MOVE WS-OLD-BAL        TO TXN-BAL-BEFORE
    MOVE WS-NEW-BAL        TO TXN-BAL-AFTER
    MOVE "Cash withdrawal"  TO TXN-DESC
    MOVE WS-DATETIME-STR   TO TXN-DATETIME
    MOVE WS-BNKUSER        TO TXN-TELLER
    MOVE 0                  TO TXN-REF-ID
    MOVE WS-TODAY-STR       TO TXN-DATE-IDX

    WRITE TXN-REC
    CLOSE TXNFILE.

*> -------------------------------------------------------
*> RECORD-TRANSFER-TXN: Record both sides of transfer
*> -------------------------------------------------------
RECORD-TRANSFER-TXN.
    OPEN I-O TXNFILE
    IF WS-TXN-STATUS NOT = "00"
        OPEN OUTPUT TXNFILE
    END-IF

    PERFORM BUILD-DATETIME

    *> Source side
    PERFORM GET-NEXT-TXN-ID
    MOVE WS-TXN-SEQ TO WS-TXN-ID1

    MOVE WS-TXN-SEQ        TO TXN-ID
    MOVE WS-FROM-ACCT      TO TXN-ACCT-ID
    MOVE "TRF"              TO TXN-TYPE
    MOVE WS-AMOUNT         TO TXN-AMOUNT
    MOVE WS-FROM-OLD-BAL   TO TXN-BAL-BEFORE
    MOVE WS-FROM-NEW-BAL   TO TXN-BAL-AFTER
    STRING "Transfer to " WS-TO-ACCT
        DELIMITED BY SIZE INTO TXN-DESC
    END-STRING
    MOVE WS-DATETIME-STR   TO TXN-DATETIME
    MOVE WS-BNKUSER        TO TXN-TELLER
    MOVE 0                  TO TXN-REF-ID
    MOVE WS-TODAY-STR       TO TXN-DATE-IDX
    WRITE TXN-REC

    *> Destination side
    PERFORM GET-NEXT-TXN-ID
    MOVE WS-TXN-SEQ TO WS-TXN-ID2

    MOVE WS-TXN-SEQ        TO TXN-ID
    MOVE WS-TO-ACCT        TO TXN-ACCT-ID
    MOVE "TRF"              TO TXN-TYPE
    MOVE WS-AMOUNT         TO TXN-AMOUNT
    MOVE WS-TO-OLD-BAL     TO TXN-BAL-BEFORE
    MOVE WS-TO-NEW-BAL     TO TXN-BAL-AFTER
    STRING "Transfer from " WS-FROM-ACCT
        DELIMITED BY SIZE INTO TXN-DESC
    END-STRING
    MOVE WS-DATETIME-STR   TO TXN-DATETIME
    MOVE WS-BNKUSER        TO TXN-TELLER
    MOVE WS-TXN-ID1        TO TXN-REF-ID
    MOVE WS-TODAY-STR       TO TXN-DATE-IDX
    WRITE TXN-REC

    *> Cross-reference the first txn
    MOVE WS-TXN-ID1 TO TXN-ID
    READ TXNFILE
        INVALID KEY CONTINUE
        NOT INVALID KEY
            MOVE WS-TXN-ID2 TO TXN-REF-ID
            REWRITE TXN-REC
    END-READ

    CLOSE TXNFILE.

*> -------------------------------------------------------
*> VIEW-TXN-HISTORY: View transaction history
*> -------------------------------------------------------
VIEW-TXN-HISTORY.
    DISPLAY "Account Number: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF
    MOVE WS-INPUT TO WS-ACCT-NUM

    DISPLAY "How many records? (default 20): "
        WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        MOVE 20 TO WS-MAX-RECORDS
    ELSE
        MOVE FUNCTION NUMVAL(WS-INPUT) TO WS-MAX-RECORDS
    END-IF

    DISPLAY "Filter by type (DEP/WDR/TRF/INT/FEE/"
        "ALL, default ALL): " WITH NO ADVANCING
    ACCEPT WS-FILTER-TYPE
    IF WS-FILTER-TYPE = SPACES
        MOVE "ALL" TO WS-FILTER-TYPE
    END-IF
    INSPECT WS-FILTER-TYPE CONVERTING
        "abcdefghijklmnopqrstuvwxyz"
        TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    OPEN INPUT TXNFILE
    IF WS-TXN-STATUS NOT = "00"
        DISPLAY "No transaction data found."
        EXIT PARAGRAPH
    END-IF

    DISPLAY " "
    DISPLAY "Transaction History for Account " WS-ACCT-NUM
    DISPLAY " "
    DISPLAY "TxnID    Type  Amount          "
        "Bal Before       Bal After        Description"
    DISPLAY "-------- ----- --------------- "
        "---------------- ---------------- "
        "-----------------------------"

    MOVE 0 TO WS-DISPLAY-CNT
    MOVE WS-ACCT-NUM TO TXN-ACCT-ID
    START TXNFILE KEY IS = TXN-ACCT-ID
        INVALID KEY
            DISPLAY "No transactions found."
            CLOSE TXNFILE
            EXIT PARAGRAPH
    END-START

    MOVE 0 TO WS-EOF
    PERFORM UNTIL WS-EOF = 1
        OR WS-DISPLAY-CNT >= WS-MAX-RECORDS
        READ TXNFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
        IF WS-EOF = 0
            IF TXN-ACCT-ID = WS-ACCT-NUM
                IF WS-FILTER-TYPE = "ALL"
                    OR TXN-TYPE = WS-FILTER-TYPE
                    ADD 1 TO WS-DISPLAY-CNT
                    DISPLAY TXN-ID " "
                        TXN-TYPE "   "
                        TXN-AMOUNT " "
                        TXN-BAL-BEFORE " "
                        TXN-BAL-AFTER " "
                        TXN-DESC(1:29)
                END-IF
            ELSE
                MOVE 1 TO WS-EOF
            END-IF
        END-IF
    END-PERFORM

    IF WS-DISPLAY-CNT = 0
        DISPLAY "No transactions found."
    ELSE
        DISPLAY " "
        DISPLAY "Showing " WS-DISPLAY-CNT
            " transaction(s)."
    END-IF

    CLOSE TXNFILE.

*> -------------------------------------------------------
*> CHECK-DAILY-LIMIT: Check daily withdrawal limit
*> Output: WS-LIMIT-OK = 1 if OK, 0 if exceeded
*> -------------------------------------------------------
CHECK-DAILY-LIMIT.
    MOVE 1 TO WS-LIMIT-OK
    MOVE 0 TO WS-DAILY-TOTAL
    PERFORM BUILD-TODAY

    OPEN INPUT TXNFILE
    IF WS-TXN-STATUS NOT = "00"
        EXIT PARAGRAPH
    END-IF

    MOVE WS-ACCT-NUM TO TXN-ACCT-ID
    START TXNFILE KEY IS = TXN-ACCT-ID
        INVALID KEY
            CLOSE TXNFILE
            EXIT PARAGRAPH
    END-START

    MOVE 0 TO WS-EOF
    PERFORM UNTIL WS-EOF = 1
        READ TXNFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
        IF WS-EOF = 0
            IF TXN-ACCT-ID = WS-ACCT-NUM
                IF TXN-TYPE = "WDR"
                    IF TXN-DATE-IDX = WS-TODAY-STR
                        ADD TXN-AMOUNT TO WS-DAILY-TOTAL
                    END-IF
                END-IF
            ELSE
                MOVE 1 TO WS-EOF
            END-IF
        END-IF
    END-PERFORM

    CLOSE TXNFILE

    COMPUTE WS-AVAIL = WS-DAILY-TOTAL + WS-AMOUNT
    IF WS-AVAIL > WS-DAILY-LIMIT
        DISPLAY "Today's withdrawals: $" WS-DAILY-TOTAL
        DISPLAY "Limit: $" WS-DAILY-LIMIT
        COMPUTE WS-AVAIL =
            WS-DAILY-LIMIT - WS-DAILY-TOTAL
        DISPLAY "Remaining: $" WS-AVAIL
        MOVE 0 TO WS-LIMIT-OK
    END-IF.

*> -------------------------------------------------------
*> CHARGE-FEE: Charge a fee to an account (batch use)
*> -------------------------------------------------------
CHARGE-FEE.
    OPEN I-O ACCTFILE
    IF WS-ACCT-STATUS NOT = "00"
        EXIT PARAGRAPH
    END-IF

    MOVE WS-ACCT-NUM TO ACCT-ID
    READ ACCTFILE
        INVALID KEY
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-READ

    IF ACCT-STATUS NOT = "ACTIVE"
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF

    MOVE ACCT-BAL TO WS-OLD-BAL
    COMPUTE WS-NEW-BAL = WS-OLD-BAL - WS-AMOUNT
    MOVE WS-NEW-BAL TO ACCT-BAL
    REWRITE ACCT-REC
    CLOSE ACCTFILE

    OPEN I-O TXNFILE
    IF WS-TXN-STATUS NOT = "00"
        OPEN OUTPUT TXNFILE
    END-IF
    PERFORM GET-NEXT-TXN-ID
    PERFORM BUILD-DATETIME

    MOVE WS-TXN-SEQ         TO TXN-ID
    MOVE WS-ACCT-NUM        TO TXN-ACCT-ID
    MOVE "FEE"               TO TXN-TYPE
    MOVE WS-AMOUNT          TO TXN-AMOUNT
    MOVE WS-OLD-BAL         TO TXN-BAL-BEFORE
    MOVE WS-NEW-BAL         TO TXN-BAL-AFTER
    MOVE "Service fee"       TO TXN-DESC
    MOVE WS-DATETIME-STR    TO TXN-DATETIME
    MOVE "SYSTEM"            TO TXN-TELLER
    MOVE 0                   TO TXN-REF-ID
    MOVE WS-TODAY-STR        TO TXN-DATE-IDX
    WRITE TXN-REC
    CLOSE TXNFILE.

*> -------------------------------------------------------
*> CREDIT-ACCOUNT: Credit an account (batch/loan use)
*> -------------------------------------------------------
CREDIT-ACCOUNT.
    OPEN I-O ACCTFILE
    IF WS-ACCT-STATUS NOT = "00"
        EXIT PARAGRAPH
    END-IF

    MOVE WS-ACCT-NUM TO ACCT-ID
    READ ACCTFILE
        INVALID KEY
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-READ

    IF ACCT-STATUS NOT = "ACTIVE"
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF

    MOVE ACCT-BAL TO WS-OLD-BAL
    COMPUTE WS-NEW-BAL = WS-OLD-BAL + WS-AMOUNT
    MOVE WS-NEW-BAL TO ACCT-BAL
    REWRITE ACCT-REC
    CLOSE ACCTFILE

    OPEN I-O TXNFILE
    IF WS-TXN-STATUS NOT = "00"
        OPEN OUTPUT TXNFILE
    END-IF
    PERFORM GET-NEXT-TXN-ID
    PERFORM BUILD-DATETIME

    MOVE WS-TXN-SEQ         TO TXN-ID
    MOVE WS-ACCT-NUM        TO TXN-ACCT-ID
    MOVE "INT"               TO TXN-TYPE
    MOVE WS-AMOUNT          TO TXN-AMOUNT
    MOVE WS-OLD-BAL         TO TXN-BAL-BEFORE
    MOVE WS-NEW-BAL         TO TXN-BAL-AFTER
    MOVE "Interest credit"   TO TXN-DESC
    MOVE WS-DATETIME-STR    TO TXN-DATETIME
    MOVE "SYSTEM"            TO TXN-TELLER
    MOVE 0                   TO TXN-REF-ID
    MOVE WS-TODAY-STR        TO TXN-DATE-IDX
    WRITE TXN-REC
    CLOSE TXNFILE.

*> -------------------------------------------------------
*> GET-NEXT-TXN-ID: Generate next transaction ID
*> -------------------------------------------------------
GET-NEXT-TXN-ID.
    MOVE 0 TO WS-EOF
    READ TXNFILE LAST
        AT END MOVE 1 TO WS-EOF
    END-READ
    IF WS-EOF = 0
        MOVE TXN-ID TO WS-TXN-SEQ
    ELSE
        MOVE 500000 TO WS-TXN-SEQ
    END-IF
    ADD 1 TO WS-TXN-SEQ.

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
    END-STRING
    STRING WS-NOW-YEAR WS-NOW-MONTH WS-NOW-DAY
        DELIMITED BY SIZE INTO WS-TODAY-STR
    END-STRING.
