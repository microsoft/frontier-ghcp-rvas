>>SOURCE FORMAT IS FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. BNKRPT.
*> Reports Module
*> Account statements, transaction reports, loan reports,
*> portfolio summary

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

    SELECT CUSTFILE ASSIGN TO "data/CUSTFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS CUST-ID
        FILE STATUS IS WS-CUST-STATUS.

    SELECT LOANFILE ASSIGN TO "data/LOANFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS LOAN-ID
        ALTERNATE RECORD KEY IS LOAN-CUST-ID
            WITH DUPLICATES
        FILE STATUS IS WS-LOAN-STATUS.

DATA DIVISION.
FILE SECTION.
FD  ACCTFILE.
    COPY "copybooks/ACCTFLD.cpy".
FD  TXNFILE.
    COPY "copybooks/TXNFLD.cpy".
FD  CUSTFILE.
    COPY "copybooks/CUSTFLD.cpy".
FD  LOANFILE.
    COPY "copybooks/LOANFLD.cpy".

WORKING-STORAGE SECTION.
01  WS-ACCT-STATUS         PIC X(2).
01  WS-TXN-STATUS          PIC X(2).
01  WS-CUST-STATUS         PIC X(2).
01  WS-LOAN-STATUS         PIC X(2).
01  WS-EOF                 PIC 9(1) VALUE 0.
01  WS-OPTION              PIC X(1).
01  WS-INPUT               PIC X(80).
01  WS-FROM-DATE           PIC X(8).
01  WS-TO-DATE             PIC X(8).
01  WS-COUNT               PIC 9(5) VALUE 0.
01  WS-BNKUSER             PIC X(20).

*> Report totals
01  WS-TOTAL-DEP           PIC S9(13)V99 VALUE 0.
01  WS-TOTAL-WDR           PIC S9(13)V99 VALUE 0.
01  WS-TOTAL-TRF           PIC S9(13)V99 VALUE 0.
01  WS-TOTAL-BAL           PIC S9(13)V99 VALUE 0.
01  WS-TOTAL-LOAN          PIC S9(13)V99 VALUE 0.
01  WS-NET-VALUE           PIC S9(13)V99 VALUE 0.

*> Account type summary
01  WS-SAV-CNT             PIC 9(5) VALUE 0.
01  WS-SAV-BAL             PIC S9(13)V99 VALUE 0.
01  WS-CHK-CNT             PIC 9(5) VALUE 0.
01  WS-CHK-BAL             PIC S9(13)V99 VALUE 0.
01  WS-FD-CNT              PIC 9(5) VALUE 0.
01  WS-FD-BAL              PIC S9(13)V99 VALUE 0.

*> Loan summary
01  WS-ACTIVE-CNT          PIC 9(5) VALUE 0.
01  WS-ACTIVE-BAL          PIC S9(13)V99 VALUE 0.
01  WS-PAID-CNT            PIC 9(5) VALUE 0.
01  WS-PAID-TOTAL          PIC S9(13)V99 VALUE 0.
01  WS-DEFAULT-CNT         PIC 9(5) VALUE 0.
01  WS-DEFAULT-BAL         PIC S9(13)V99 VALUE 0.
01  WS-AVG-RATE            PIC 9(3)V99.
01  WS-RATE-SUM            PIC S9(9)V99 VALUE 0.

01  WS-CURRENT-DT.
    05  WS-NOW-YEAR        PIC 9(4).
    05  WS-NOW-MONTH       PIC 9(2).
    05  WS-NOW-DAY         PIC 9(2).
    05  WS-NOW-HOUR        PIC 9(2).
    05  WS-NOW-MIN         PIC 9(2).
    05  WS-NOW-SEC         PIC 9(2).
    05  WS-NOW-HSEC        PIC 9(2).
01  WS-TODAY-STR            PIC 9(8).

PROCEDURE DIVISION.
MAIN-PARA.
    STOP RUN.

*> -------------------------------------------------------
*> REPORT-MENU: Reports Menu
*> -------------------------------------------------------
REPORT-MENU.
    DISPLAY " "
    DISPLAY "Reports"
    DISPLAY "======="
    DISPLAY "1. Account Statement"
    DISPLAY "2. Daily Transaction Report"
    DISPLAY "3. Customer Portfolio Report"
    DISPLAY "4. Loan Portfolio Summary"
    DISPLAY "5. Account Type Summary"
    DISPLAY "B. Back"
    DISPLAY " "
    DISPLAY "Select: " WITH NO ADVANCING
    ACCEPT WS-OPTION

    EVALUATE WS-OPTION
        WHEN "1" PERFORM ACCOUNT-STATEMENT
        WHEN "2" PERFORM DAILY-TXN-REPORT
        WHEN "3" PERFORM CUSTOMER-PORTFOLIO
        WHEN "4" PERFORM LOAN-PORTFOLIO
        WHEN "5" PERFORM TYPE-SUMMARY
        WHEN "B" CONTINUE
        WHEN "b" CONTINUE
        WHEN OTHER DISPLAY "Invalid option."
    END-EVALUATE.

*> -------------------------------------------------------
*> ACCOUNT-STATEMENT: Generate account statement
*> -------------------------------------------------------
ACCOUNT-STATEMENT.
    DISPLAY "Account Number: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN INPUT ACCTFILE
    MOVE WS-INPUT TO ACCT-ID
    READ ACCTFILE
        INVALID KEY
            DISPLAY "Account not found."
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-READ
    CLOSE ACCTFILE

    DISPLAY "From date (YYYYMMDD, blank for all): "
        WITH NO ADVANCING
    ACCEPT WS-FROM-DATE
    DISPLAY "To date (YYYYMMDD, blank for today): "
        WITH NO ADVANCING
    ACCEPT WS-TO-DATE
    IF WS-TO-DATE = SPACES
        PERFORM BUILD-TODAY
        MOVE WS-TODAY-STR TO WS-TO-DATE
    END-IF

    DISPLAY " "
    DISPLAY "========================================="
        "========================"
    DISPLAY "                    ACCOUNT STATEMENT"
    DISPLAY "========================================="
        "========================"
    DISPLAY "Account:  " ACCT-ID "          Type: "
        ACCT-TYPE
    DISPLAY "Period:   "
        WS-FROM-DATE " to " WS-TO-DATE
    DISPLAY "========================================="
        "========================"
    DISPLAY " "
    DISPLAY "TxnID    Type  Amount          "
        "Balance         Description"
    DISPLAY "-------- ----- --------------- "
        "--------------- "
        "-------------------------"

    OPEN INPUT TXNFILE
    IF WS-TXN-STATUS NOT = "00"
        DISPLAY "No transaction data."
        EXIT PARAGRAPH
    END-IF

    MOVE 0 TO WS-COUNT
    MOVE WS-INPUT TO TXN-ACCT-ID
    START TXNFILE KEY IS = TXN-ACCT-ID
        INVALID KEY
            DISPLAY "No transactions found."
            CLOSE TXNFILE
            EXIT PARAGRAPH
    END-START

    MOVE 0 TO WS-EOF
    PERFORM UNTIL WS-EOF = 1
        READ TXNFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
        IF WS-EOF = 0
            IF TXN-ACCT-ID = WS-INPUT
                IF WS-FROM-DATE NOT = SPACES
                    IF TXN-DATE-IDX < WS-FROM-DATE
                        CONTINUE
                    END-IF
                END-IF
                IF TXN-DATE-IDX > WS-TO-DATE
                    CONTINUE
                END-IF
                ADD 1 TO WS-COUNT
                DISPLAY TXN-ID " "
                    TXN-TYPE "   "
                    TXN-AMOUNT " "
                    TXN-BAL-AFTER " "
                    TXN-DESC(1:25)
            ELSE
                MOVE 1 TO WS-EOF
            END-IF
        END-IF
    END-PERFORM

    DISPLAY " "
    DISPLAY "Current Balance: $" ACCT-BAL
    DISPLAY "Total Transactions: " WS-COUNT
    DISPLAY "========================================="
        "========================"

    CLOSE TXNFILE.

*> -------------------------------------------------------
*> DAILY-TXN-REPORT: Daily transaction report
*> -------------------------------------------------------
DAILY-TXN-REPORT.
    DISPLAY "Report date (YYYYMMDD, blank for today): "
        WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        PERFORM BUILD-TODAY
        MOVE WS-TODAY-STR TO WS-INPUT
    END-IF

    MOVE 0 TO WS-COUNT
    MOVE 0 TO WS-TOTAL-DEP
    MOVE 0 TO WS-TOTAL-WDR
    MOVE 0 TO WS-TOTAL-TRF

    DISPLAY " "
    DISPLAY "========================================="
        "========================"
    DISPLAY "              DAILY TRANSACTION REPORT"
    DISPLAY "              Date: "
        WS-INPUT(5:2) "/" WS-INPUT(7:2) "/"
        WS-INPUT(1:4)
    DISPLAY "========================================="
        "========================"
    DISPLAY " "
    DISPLAY "TxnID    Account Type  Amount          "
        "Teller     Description"
    DISPLAY "-------- ------- ----- --------------- "
        "---------- "
        "-------------------------"

    OPEN INPUT TXNFILE
    IF WS-TXN-STATUS NOT = "00"
        DISPLAY "No transaction data."
        EXIT PARAGRAPH
    END-IF

    MOVE 0 TO WS-EOF
    READ TXNFILE FIRST
        AT END MOVE 1 TO WS-EOF
    END-READ

    PERFORM UNTIL WS-EOF = 1
        IF TXN-DATE-IDX = WS-INPUT
            ADD 1 TO WS-COUNT
            EVALUATE TXN-TYPE
                WHEN "DEP"
                    ADD TXN-AMOUNT TO WS-TOTAL-DEP
                WHEN "WDR"
                    ADD TXN-AMOUNT TO WS-TOTAL-WDR
                WHEN "TRF"
                    ADD TXN-AMOUNT TO WS-TOTAL-TRF
            END-EVALUATE
            DISPLAY TXN-ID " "
                TXN-ACCT-ID " "
                TXN-TYPE "   "
                TXN-AMOUNT " "
                TXN-TELLER(1:10) " "
                TXN-DESC(1:25)
        END-IF
        READ TXNFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
    END-PERFORM

    DISPLAY " "
    DISPLAY "Summary:"
    DISPLAY "  Total Deposits:    $" WS-TOTAL-DEP
    DISPLAY "  Total Withdrawals: $" WS-TOTAL-WDR
    DISPLAY "  Total Transfers:   $" WS-TOTAL-TRF
    DISPLAY "  Transaction Count: " WS-COUNT
    COMPUTE WS-NET-VALUE = WS-TOTAL-DEP - WS-TOTAL-WDR
    DISPLAY "  Net Flow:          $" WS-NET-VALUE

    CLOSE TXNFILE.

*> -------------------------------------------------------
*> CUSTOMER-PORTFOLIO: Customer portfolio report
*> -------------------------------------------------------
CUSTOMER-PORTFOLIO.
    DISPLAY "Customer ID: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN INPUT CUSTFILE
    MOVE WS-INPUT TO CUST-ID
    READ CUSTFILE
        INVALID KEY
            DISPLAY "Customer not found."
            CLOSE CUSTFILE
            EXIT PARAGRAPH
    END-READ
    CLOSE CUSTFILE

    MOVE 0 TO WS-TOTAL-BAL
    MOVE 0 TO WS-TOTAL-LOAN

    DISPLAY " "
    DISPLAY "========================================="
        "========================"
    DISPLAY "              CUSTOMER PORTFOLIO REPORT"
    DISPLAY "========================================="
        "========================"
    DISPLAY "Customer: "
        FUNCTION TRIM(CUST-FIRST-NAME) " "
        FUNCTION TRIM(CUST-LAST-NAME)
    DISPLAY "ID: " CUST-ID "  Status: "
        FUNCTION TRIM(CUST-STATUS) "  KYC: "
        FUNCTION TRIM(CUST-KYC)
    DISPLAY " "

    *> Deposit accounts
    DISPLAY "--- Deposit Accounts ---"
    DISPLAY "Account Type   Balance         "
        "Rate    Status"
    DISPLAY "------- ----   --------------- "
        "------  ----------"

    OPEN INPUT ACCTFILE
    IF WS-ACCT-STATUS = "00"
        MOVE WS-INPUT TO ACCT-CUST-ID
        START ACCTFILE KEY IS = ACCT-CUST-ID
            INVALID KEY CONTINUE
            NOT INVALID KEY
                MOVE 0 TO WS-EOF
                PERFORM UNTIL WS-EOF = 1
                    READ ACCTFILE NEXT
                        AT END MOVE 1 TO WS-EOF
                    END-READ
                    IF WS-EOF = 0
                        IF ACCT-CUST-ID = WS-INPUT
                            ADD ACCT-BAL TO WS-TOTAL-BAL
                            DISPLAY ACCT-ID " "
                                ACCT-TYPE "    "
                                ACCT-BAL " "
                                ACCT-RATE "%  "
                                ACCT-STATUS
                        ELSE
                            MOVE 1 TO WS-EOF
                        END-IF
                    END-IF
                END-PERFORM
        END-START
    END-IF
    CLOSE ACCTFILE
    DISPLAY "Total Deposits: $" WS-TOTAL-BAL

    *> Loans
    DISPLAY " "
    DISPLAY "--- Loans ---"
    DISPLAY "Loan ID Principal       Balance"
        "         Rate    Status"
    DISPLAY "------- --------------- "
        "--------------- ------  ----------"

    OPEN INPUT LOANFILE
    IF WS-LOAN-STATUS = "00"
        MOVE WS-INPUT TO LOAN-CUST-ID
        START LOANFILE KEY IS = LOAN-CUST-ID
            INVALID KEY CONTINUE
            NOT INVALID KEY
                MOVE 0 TO WS-EOF
                PERFORM UNTIL WS-EOF = 1
                    READ LOANFILE NEXT
                        AT END MOVE 1 TO WS-EOF
                    END-READ
                    IF WS-EOF = 0
                        IF LOAN-CUST-ID = WS-INPUT
                            IF LOAN-STATUS = "ACTIVE"
                                ADD LOAN-BALANCE
                                    TO WS-TOTAL-LOAN
                            END-IF
                            DISPLAY LOAN-ID " "
                                LOAN-PRINCIPAL " "
                                LOAN-BALANCE " "
                                LOAN-RATE "%  "
                                LOAN-STATUS
                        ELSE
                            MOVE 1 TO WS-EOF
                        END-IF
                    END-IF
                END-PERFORM
        END-START
    END-IF
    CLOSE LOANFILE

    DISPLAY " "
    DISPLAY "Total Deposits:     $" WS-TOTAL-BAL
    DISPLAY "Total Active Loans: $" WS-TOTAL-LOAN
    COMPUTE WS-NET-VALUE = WS-TOTAL-BAL - WS-TOTAL-LOAN
    DISPLAY "Net Customer Value: $" WS-NET-VALUE.

*> -------------------------------------------------------
*> LOAN-PORTFOLIO: Loan portfolio summary (all loans)
*> -------------------------------------------------------
LOAN-PORTFOLIO.
    MOVE 0 TO WS-ACTIVE-CNT
    MOVE 0 TO WS-ACTIVE-BAL
    MOVE 0 TO WS-PAID-CNT
    MOVE 0 TO WS-PAID-TOTAL
    MOVE 0 TO WS-DEFAULT-CNT
    MOVE 0 TO WS-DEFAULT-BAL
    MOVE 0 TO WS-RATE-SUM

    PERFORM BUILD-TODAY

    DISPLAY " "
    DISPLAY "========================================="
        "========================"
    DISPLAY "              LOAN PORTFOLIO SUMMARY"
    DISPLAY "========================================="
        "========================"
    DISPLAY " "
    DISPLAY "LoanID Customer     Principal       "
        "Balance         Rate    Status"
    DISPLAY "------ ------------ --------------- "
        "--------------- ------  ----------"

    OPEN INPUT LOANFILE
    IF WS-LOAN-STATUS NOT = "00"
        DISPLAY "No loan data."
        EXIT PARAGRAPH
    END-IF

    MOVE 0 TO WS-EOF
    READ LOANFILE FIRST
        AT END MOVE 1 TO WS-EOF
    END-READ

    PERFORM UNTIL WS-EOF = 1
        EVALUATE LOAN-STATUS
            WHEN "ACTIVE"
                ADD 1 TO WS-ACTIVE-CNT
                ADD LOAN-BALANCE TO WS-ACTIVE-BAL
                ADD LOAN-RATE TO WS-RATE-SUM
            WHEN "PAID"
                ADD 1 TO WS-PAID-CNT
                ADD LOAN-PRINCIPAL TO WS-PAID-TOTAL
            WHEN "DEFAULT"
                ADD 1 TO WS-DEFAULT-CNT
                ADD LOAN-BALANCE TO WS-DEFAULT-BAL
        END-EVALUATE

        DISPLAY LOAN-ID " "
            LOAN-CUST-ID "        "
            LOAN-PRINCIPAL " "
            LOAN-BALANCE " "
            LOAN-RATE "%  "
            LOAN-STATUS

        READ LOANFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
    END-PERFORM

    DISPLAY " "
    DISPLAY "Active Loans:    " WS-ACTIVE-CNT
        "  Outstanding: $" WS-ACTIVE-BAL
    IF WS-ACTIVE-CNT > 0
        COMPUTE WS-AVG-RATE =
            WS-RATE-SUM / WS-ACTIVE-CNT
        DISPLAY "Avg Rate:        " WS-AVG-RATE "%"
    END-IF
    DISPLAY "Paid Off:        " WS-PAID-CNT
        "  Total Originated: $" WS-PAID-TOTAL
    DISPLAY "Defaulted:       " WS-DEFAULT-CNT
        "  At Risk: $" WS-DEFAULT-BAL

    CLOSE LOANFILE.

*> -------------------------------------------------------
*> TYPE-SUMMARY: Summary by account type
*> -------------------------------------------------------
TYPE-SUMMARY.
    MOVE 0 TO WS-SAV-CNT
    MOVE 0 TO WS-SAV-BAL
    MOVE 0 TO WS-CHK-CNT
    MOVE 0 TO WS-CHK-BAL
    MOVE 0 TO WS-FD-CNT
    MOVE 0 TO WS-FD-BAL

    OPEN INPUT ACCTFILE
    IF WS-ACCT-STATUS NOT = "00"
        DISPLAY "No account data."
        EXIT PARAGRAPH
    END-IF

    MOVE 0 TO WS-EOF
    READ ACCTFILE FIRST
        AT END MOVE 1 TO WS-EOF
    END-READ

    PERFORM UNTIL WS-EOF = 1
        IF ACCT-STATUS = "ACTIVE"
            EVALUATE ACCT-TYPE
                WHEN "SAV"
                    ADD 1 TO WS-SAV-CNT
                    ADD ACCT-BAL TO WS-SAV-BAL
                WHEN "CHK"
                    ADD 1 TO WS-CHK-CNT
                    ADD ACCT-BAL TO WS-CHK-BAL
                WHEN "FD"
                    ADD 1 TO WS-FD-CNT
                    ADD ACCT-BAL TO WS-FD-BAL
            END-EVALUATE
        END-IF
        READ ACCTFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
    END-PERFORM

    COMPUTE WS-TOTAL-BAL =
        WS-SAV-BAL + WS-CHK-BAL + WS-FD-BAL

    DISPLAY " "
    DISPLAY "========================================="
        "========================"
    DISPLAY "              DEPOSIT PORTFOLIO BY TYPE"
    DISPLAY "========================================="
        "========================"
    DISPLAY " "
    DISPLAY "Type         Count   Total Balance"
    DISPLAY "------------ -----   ---------------"
    DISPLAY "Savings      " WS-SAV-CNT "     $"
        WS-SAV-BAL
    DISPLAY "Checking     " WS-CHK-CNT "     $"
        WS-CHK-BAL
    DISPLAY "Fixed Dep    " WS-FD-CNT "     $"
        WS-FD-BAL
    DISPLAY " "
    DISPLAY "TOTAL DEPOSITS:       $" WS-TOTAL-BAL

    CLOSE ACCTFILE.

*> -------------------------------------------------------
*> BUILD-TODAY
*> -------------------------------------------------------
BUILD-TODAY.
    MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DT
    STRING WS-NOW-YEAR WS-NOW-MONTH WS-NOW-DAY
        DELIMITED BY SIZE INTO WS-TODAY-STR
    END-STRING.
