>>SOURCE FORMAT IS FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. BNKBATCH.
*> End-of-Day Batch Processing
*> Runs interest accrual, fee charges, loan checks, FD maturity
*> Should be run once daily after business hours

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT BATCHFILE ASSIGN TO "data/BATCHFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS BATCH-RUN-ID
        FILE STATUS IS WS-BATCH-STATUS.

    SELECT ACCTFILE ASSIGN TO "data/ACCTFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS ACCT-ID
        ALTERNATE RECORD KEY IS ACCT-CUST-ID
            WITH DUPLICATES
        FILE STATUS IS WS-ACCT-STATUS.

    SELECT LOANFILE ASSIGN TO "data/LOANFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS LOAN-ID
        ALTERNATE RECORD KEY IS LOAN-CUST-ID
            WITH DUPLICATES
        FILE STATUS IS WS-LOAN-STATUS.

DATA DIVISION.
FILE SECTION.
FD  BATCHFILE.
    COPY "copybooks/BATCHFLD.cpy".

FD  ACCTFILE.
    COPY "copybooks/ACCTFLD.cpy".

FD  LOANFILE.
    COPY "copybooks/LOANFLD.cpy".

WORKING-STORAGE SECTION.
01  WS-BATCH-STATUS        PIC X(2).
01  WS-ACCT-STATUS         PIC X(2).
01  WS-LOAN-STATUS         PIC X(2).
01  WS-EOF                 PIC 9(1) VALUE 0.

01  WS-RUN-ID              PIC 9(6) VALUE 0.
01  WS-SAV-INT             PIC S9(9)V99 VALUE 0.
01  WS-CHK-INT             PIC S9(9)V99 VALUE 0.
01  WS-FD-MAT-CNT          PIC 9(5) VALUE 0.
01  WS-TOTAL-FEES          PIC S9(9)V99 VALUE 0.
01  WS-OVERDUE-CNT         PIC 9(5) VALUE 0.
01  WS-ERR-CNT             PIC 9(5) VALUE 0.
01  WS-FEE-AMT             PIC S9(9)V99 VALUE 12.
01  WS-DAY-OF-MONTH        PIC 9(2).
01  WS-DAYS-OVERDUE        PIC 9(5).
01  WS-LAST-RUN            PIC 9(8).

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
01  WS-START-TIME          PIC X(19).
01  WS-END-TIME            PIC X(19).

*> For days-diff calculation
01  WS-DIFF-Y1             PIC 9(4).
01  WS-DIFF-M1             PIC 9(2).
01  WS-DIFF-D1             PIC 9(2).
01  WS-DIFF-Y2             PIC 9(4).
01  WS-DIFF-M2             PIC 9(2).
01  WS-DIFF-D2             PIC 9(2).

*> Daily interest work fields
01  WS-DAILY-INT           PIC S9(9)V9999 VALUE 0.
01  WS-ACCR-AMT            PIC S9(9)V9999 VALUE 0.
01  WS-POST-AMT            PIC S9(9)V99 VALUE 0.

*> FD maturity work fields
01  WS-FD-INTEREST         PIC S9(11)V99.

PROCEDURE DIVISION.
MAIN-PARA.
    STOP RUN.

*> -------------------------------------------------------
*> RUN-BATCH: Main batch entry point
*> -------------------------------------------------------
RUN-BATCH.
    PERFORM BUILD-TODAY
    PERFORM BUILD-DATETIME
    MOVE WS-DATETIME-STR TO WS-START-TIME

    *> Check if batch already ran today (idempotent)
    OPEN I-O BATCHFILE
    IF WS-BATCH-STATUS NOT = "00"
        OPEN OUTPUT BATCHFILE
        CLOSE BATCHFILE
        OPEN I-O BATCHFILE
    END-IF

    MOVE 0 TO WS-EOF
    READ BATCHFILE LAST
        AT END MOVE 1 TO WS-EOF
    END-READ

    IF WS-EOF = 0
        IF BATCH-LAST-RUN = WS-TODAY-STR
            DISPLAY "Batch already ran today ("
                WS-TODAY-STR(5:2) "/"
                WS-TODAY-STR(7:2) "/"
                WS-TODAY-STR(1:4) ")."
            DISPLAY "Cannot run twice in same day."
            CLOSE BATCHFILE
            EXIT PARAGRAPH
        END-IF
        MOVE BATCH-RUN-ID TO WS-RUN-ID
    END-IF
    ADD 1 TO WS-RUN-ID
    CLOSE BATCHFILE

    DISPLAY " "
    DISPLAY "=== END-OF-DAY BATCH PROCESSING ==="
    DISPLAY "Date: " WS-TODAY-STR(5:2) "/"
        WS-TODAY-STR(7:2) "/" WS-TODAY-STR(1:4)
    DISPLAY "Starting..."

    *> Step 1: Savings interest
    DISPLAY "  [1/4] Calculating savings interest..."
    PERFORM PROCESS-SAVINGS-INT
    DISPLAY "        $" WS-SAV-INT " posted"

    *> Step 2: Checking interest
    DISPLAY "  [2/4] Calculating checking interest..."
    PERFORM PROCESS-CHECKING-INT
    DISPLAY "        $" WS-CHK-INT " posted"

    *> Step 3: FD maturity
    DISPLAY "  [3/4] Processing Fixed Deposit "
        "maturities..."
    PERFORM PROCESS-FD-MATURITY
    DISPLAY "        " WS-FD-MAT-CNT " FD(s) matured"

    *> Step 4: Maintenance fees
    DISPLAY "  [4/4] Processing maintenance fees..."
    PERFORM CHARGE-MAINTENANCE-FEES
    DISPLAY "        $" WS-TOTAL-FEES " in fees charged"

    *> Step 5: Loan overdue check
    PERFORM CHECK-OVERDUE-LOANS
    IF WS-OVERDUE-CNT > 0
        DISPLAY "  Overdue loans: " WS-OVERDUE-CNT
    END-IF

    *> Finalize batch record
    PERFORM BUILD-DATETIME
    MOVE WS-DATETIME-STR TO WS-END-TIME

    OPEN I-O BATCHFILE
    IF WS-BATCH-STATUS NOT = "00"
        OPEN OUTPUT BATCHFILE
    END-IF

    MOVE WS-RUN-ID       TO BATCH-RUN-ID
    MOVE WS-START-TIME   TO BATCH-START
    MOVE WS-END-TIME     TO BATCH-END
    MOVE "COMPLETE"       TO BATCH-STATUS
    MOVE WS-SAV-INT      TO BATCH-SAV-INT
    MOVE WS-CHK-INT      TO BATCH-CHK-INT
    MOVE WS-FD-MAT-CNT   TO BATCH-FD-MAT
    MOVE WS-TOTAL-FEES   TO BATCH-FEES
    MOVE WS-OVERDUE-CNT  TO BATCH-OVERDUE
    MOVE WS-ERR-CNT      TO BATCH-ERRORS
    MOVE WS-TODAY-STR    TO BATCH-LAST-RUN

    WRITE BATCH-REC
    CLOSE BATCHFILE

    DISPLAY " "
    DISPLAY "Batch complete."
    DISPLAY "Run ID:     " WS-RUN-ID
    DISPLAY "Started:    " WS-START-TIME
    DISPLAY "Finished:   " WS-END-TIME
    DISPLAY "Errors:     " WS-ERR-CNT.

*> -------------------------------------------------------
*> PROCESS-SAVINGS-INT: Calculate daily savings interest
*> -------------------------------------------------------
PROCESS-SAVINGS-INT.
    MOVE 0 TO WS-SAV-INT

    OPEN I-O ACCTFILE
    IF WS-ACCT-STATUS NOT = "00"
        EXIT PARAGRAPH
    END-IF

    MOVE 0 TO WS-EOF
    READ ACCTFILE FIRST
        AT END MOVE 1 TO WS-EOF
    END-READ

    PERFORM UNTIL WS-EOF = 1
        IF ACCT-TYPE = "SAV"
            AND ACCT-STATUS = "ACTIVE"
            AND ACCT-BAL > 0
            AND ACCT-RATE > 0
            COMPUTE WS-DAILY-INT =
                ACCT-BAL * (ACCT-RATE / 100 / 365)
            MOVE ACCT-ACCR-INT TO WS-ACCR-AMT
            ADD WS-DAILY-INT TO WS-ACCR-AMT
            MOVE WS-ACCR-AMT TO ACCT-ACCR-INT

            MOVE WS-NOW-DAY TO WS-DAY-OF-MONTH
            IF WS-DAY-OF-MONTH >= 28
                IF WS-ACCR-AMT > 0.01
                    MOVE WS-ACCR-AMT TO WS-POST-AMT
                    ADD WS-POST-AMT TO ACCT-BAL
                    MOVE 0 TO ACCT-ACCR-INT
                    ADD WS-POST-AMT TO WS-SAV-INT
                END-IF
            END-IF
            REWRITE ACCT-REC
        END-IF
        READ ACCTFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
    END-PERFORM

    CLOSE ACCTFILE.

*> -------------------------------------------------------
*> PROCESS-CHECKING-INT
*> -------------------------------------------------------
PROCESS-CHECKING-INT.
    MOVE 0 TO WS-CHK-INT

    OPEN I-O ACCTFILE
    IF WS-ACCT-STATUS NOT = "00"
        EXIT PARAGRAPH
    END-IF

    MOVE 0 TO WS-EOF
    READ ACCTFILE FIRST
        AT END MOVE 1 TO WS-EOF
    END-READ

    PERFORM UNTIL WS-EOF = 1
        IF ACCT-TYPE = "CHK"
            AND ACCT-STATUS = "ACTIVE"
            AND ACCT-BAL >= 1000
            AND ACCT-RATE > 0
            COMPUTE WS-DAILY-INT =
                ACCT-BAL * (ACCT-RATE / 100 / 365)
            MOVE ACCT-ACCR-INT TO WS-ACCR-AMT
            ADD WS-DAILY-INT TO WS-ACCR-AMT
            MOVE WS-ACCR-AMT TO ACCT-ACCR-INT

            MOVE WS-NOW-DAY TO WS-DAY-OF-MONTH
            IF WS-DAY-OF-MONTH >= 28
                IF WS-ACCR-AMT > 0.01
                    MOVE WS-ACCR-AMT TO WS-POST-AMT
                    ADD WS-POST-AMT TO ACCT-BAL
                    MOVE 0 TO ACCT-ACCR-INT
                    ADD WS-POST-AMT TO WS-CHK-INT
                END-IF
            END-IF
            REWRITE ACCT-REC
        END-IF
        READ ACCTFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
    END-PERFORM

    CLOSE ACCTFILE.

*> -------------------------------------------------------
*> PROCESS-FD-MATURITY
*> -------------------------------------------------------
PROCESS-FD-MATURITY.
    MOVE 0 TO WS-FD-MAT-CNT

    OPEN I-O ACCTFILE
    IF WS-ACCT-STATUS NOT = "00"
        EXIT PARAGRAPH
    END-IF

    MOVE 0 TO WS-EOF
    READ ACCTFILE FIRST
        AT END MOVE 1 TO WS-EOF
    END-READ

    PERFORM UNTIL WS-EOF = 1
        IF ACCT-TYPE = "FD"
            AND ACCT-STATUS = "ACTIVE"
            AND ACCT-MATURITY > 0
            IF ACCT-MATURITY <= WS-TODAY-STR
                *> Simple interest: P * R * T / 12
                *> (compound interest was proposed in 2016
                *>  but never implemented)
                COMPUTE WS-FD-INTEREST =
                    ACCT-ORIG-DEP
                    * (ACCT-RATE / 100)
                    * (ACCT-TERM / 12)
                ADD WS-FD-INTEREST TO ACCT-BAL
                MOVE "MATURED" TO ACCT-STATUS
                REWRITE ACCT-REC
                ADD 1 TO WS-FD-MAT-CNT
            END-IF
        END-IF
        READ ACCTFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
    END-PERFORM

    CLOSE ACCTFILE.

*> -------------------------------------------------------
*> CHARGE-MAINTENANCE-FEES: $12/mo for low-bal checking
*> Only charges on the 1st of the month
*> -------------------------------------------------------
CHARGE-MAINTENANCE-FEES.
    MOVE 0 TO WS-TOTAL-FEES
    MOVE WS-NOW-DAY TO WS-DAY-OF-MONTH
    IF WS-DAY-OF-MONTH NOT = 1
        EXIT PARAGRAPH
    END-IF

    *> Fee: $12/month if checking balance < $500
    MOVE 12 TO WS-FEE-AMT
    *> hardcoded -- should read from config (noted 2017)

    OPEN I-O ACCTFILE
    IF WS-ACCT-STATUS NOT = "00"
        EXIT PARAGRAPH
    END-IF

    MOVE 0 TO WS-EOF
    READ ACCTFILE FIRST
        AT END MOVE 1 TO WS-EOF
    END-READ

    PERFORM UNTIL WS-EOF = 1
        IF ACCT-TYPE = "CHK"
            AND ACCT-STATUS = "ACTIVE"
            AND ACCT-BAL < 500
            SUBTRACT WS-FEE-AMT FROM ACCT-BAL
            REWRITE ACCT-REC
            ADD WS-FEE-AMT TO WS-TOTAL-FEES
        END-IF
        READ ACCTFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
    END-PERFORM

    CLOSE ACCTFILE.

*> -------------------------------------------------------
*> CHECK-OVERDUE-LOANS
*> -------------------------------------------------------
CHECK-OVERDUE-LOANS.
    MOVE 0 TO WS-OVERDUE-CNT

    OPEN I-O LOANFILE
    IF WS-LOAN-STATUS NOT = "00"
        EXIT PARAGRAPH
    END-IF

    MOVE 0 TO WS-EOF
    READ LOANFILE FIRST
        AT END MOVE 1 TO WS-EOF
    END-READ

    PERFORM UNTIL WS-EOF = 1
        IF LOAN-STATUS = "ACTIVE"
            AND LOAN-NEXT-PMT > 0
            *> Calculate days overdue (simplified 30-day)
            MOVE LOAN-NEXT-PMT(1:4) TO WS-DIFF-Y1
            MOVE LOAN-NEXT-PMT(5:2) TO WS-DIFF-M1
            MOVE LOAN-NEXT-PMT(7:2) TO WS-DIFF-D1
            MOVE WS-TODAY-STR(1:4)  TO WS-DIFF-Y2
            MOVE WS-TODAY-STR(5:2)  TO WS-DIFF-M2
            MOVE WS-TODAY-STR(7:2)  TO WS-DIFF-D2
            COMPUTE WS-DAYS-OVERDUE =
                ((WS-DIFF-Y2 - WS-DIFF-Y1) * 360)
                + ((WS-DIFF-M2 - WS-DIFF-M1) * 30)
                + (WS-DIFF-D2 - WS-DIFF-D1)

            IF WS-DAYS-OVERDUE > 30
                ADD 1 TO WS-OVERDUE-CNT
                *> Default after 90 days
                IF WS-DAYS-OVERDUE > 90
                    MOVE "DEFAULT" TO LOAN-STATUS
                    REWRITE LOAN-REC
                    DISPLAY "  WARNING: Loan "
                        LOAN-ID " marked as DEFAULT"
                END-IF
            END-IF
        END-IF
        READ LOANFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
    END-PERFORM

    CLOSE LOANFILE.

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
