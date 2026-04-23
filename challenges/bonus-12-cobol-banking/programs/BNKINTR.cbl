>>SOURCE FORMAT IS FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. BNKINTR.
*> Interest Calculation Module
*> Calculates and applies interest for savings, checking, and FD
*> Called by BNKBATCH during end-of-day processing

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

DATA DIVISION.
FILE SECTION.
FD  ACCTFILE.
    COPY "copybooks/ACCTFLD.cpy".

WORKING-STORAGE SECTION.
01  WS-FILE-STATUS         PIC X(2).
01  WS-EOF                 PIC 9(1) VALUE 0.

01  WS-DAILY-INT           PIC S9(9)V9999 VALUE 0.
01  WS-ACCR-AMT            PIC S9(9)V9999 VALUE 0.
01  WS-POST-AMT            PIC S9(9)V99 VALUE 0.
01  WS-TOTAL-POSTED        PIC S9(11)V99 VALUE 0.
01  WS-MATURED-CNT         PIC 9(5) VALUE 0.

01  WS-FD-INTEREST         PIC S9(11)V99.
01  WS-FD-ORIG             PIC S9(11)V99.
01  WS-FD-RATE             PIC 9(3)V99.
01  WS-FD-TERM             PIC 9(3).

01  WS-DAY-OF-MONTH        PIC 9(2).

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
*> CALC-SAVINGS-INT: Daily interest for savings accounts
*> Uses actual/365 day count convention
*> Interest accrues daily, posts monthly on last biz day
*> Returns: WS-TOTAL-POSTED
*> -------------------------------------------------------
CALC-SAVINGS-INT.
    MOVE 0 TO WS-TOTAL-POSTED
    PERFORM BUILD-TODAY

    OPEN I-O ACCTFILE
    IF WS-FILE-STATUS NOT = "00"
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
            *> Daily interest = balance * (annual rate / 365)
            COMPUTE WS-DAILY-INT =
                ACCT-BAL * (ACCT-RATE / 100 / 365)
            *> Accumulate in accrual bucket
            MOVE ACCT-ACCR-INT TO WS-ACCR-AMT
            ADD WS-DAILY-INT TO WS-ACCR-AMT
            MOVE WS-ACCR-AMT TO ACCT-ACCR-INT

            *> Post interest on month end (day 28+)
            *> NOTE: this is an intentional simplification
            *> -- real systems use actual calendar
            *> month-end dates
            MOVE WS-NOW-DAY TO WS-DAY-OF-MONTH
            IF WS-DAY-OF-MONTH >= 28
                IF WS-ACCR-AMT > 0.01
                    MOVE WS-ACCR-AMT TO WS-POST-AMT
                    ADD WS-POST-AMT TO ACCT-BAL
                    MOVE 0 TO ACCT-ACCR-INT
                    PERFORM BUILD-DATETIME
                    MOVE WS-DATETIME-STR TO ACCT-LAST-INT
                    ADD WS-POST-AMT TO WS-TOTAL-POSTED
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
*> CALC-CHECKING-INT: Daily interest for checking accounts
*> Same structure as savings but lower rate
*> Checking accounts earn interest only above $1000
*> Returns: WS-TOTAL-POSTED
*> -------------------------------------------------------
CALC-CHECKING-INT.
    MOVE 0 TO WS-TOTAL-POSTED
    PERFORM BUILD-TODAY

    OPEN I-O ACCTFILE
    IF WS-FILE-STATUS NOT = "00"
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
                    ADD WS-POST-AMT TO WS-TOTAL-POSTED
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
*> CALC-FD-MATURITY: Check for matured fixed deposits
*> FD interest is calculated at maturity, not daily
*> Returns: WS-MATURED-CNT
*> -------------------------------------------------------
CALC-FD-MATURITY.
    MOVE 0 TO WS-MATURED-CNT
    PERFORM BUILD-TODAY

    OPEN I-O ACCTFILE
    IF WS-FILE-STATUS NOT = "00"
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
            *> Check if FD has matured
            IF ACCT-MATURITY <= WS-TODAY-STR
                *> Simple interest for FD: P * R * T / 12
                *> (compound interest was proposed in 2016
                *>  but never implemented)
                MOVE ACCT-ORIG-DEP TO WS-FD-ORIG
                MOVE ACCT-RATE TO WS-FD-RATE
                MOVE ACCT-TERM TO WS-FD-TERM
                COMPUTE WS-FD-INTEREST =
                    WS-FD-ORIG
                    * (WS-FD-RATE / 100)
                    * (WS-FD-TERM / 12)

                ADD WS-FD-INTEREST TO ACCT-BAL
                MOVE "MATURED" TO ACCT-STATUS
                REWRITE ACCT-REC
                ADD 1 TO WS-MATURED-CNT
            END-IF
        END-IF

        READ ACCTFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
    END-PERFORM

    CLOSE ACCTFILE.

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
