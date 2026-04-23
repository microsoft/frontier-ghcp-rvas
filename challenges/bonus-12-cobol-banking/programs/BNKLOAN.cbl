>>SOURCE FORMAT IS FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. BNKLOAN.
*> Loan Management Module
*> Loan origination, payments, payoff, and amortization

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT LOANFILE ASSIGN TO "data/LOANFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS LOAN-ID
        ALTERNATE RECORD KEY IS LOAN-CUST-ID
            WITH DUPLICATES
        FILE STATUS IS WS-LOAN-STATUS.

    SELECT CUSTFILE ASSIGN TO "data/CUSTFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS CUST-ID
        FILE STATUS IS WS-CUST-STATUS.

    SELECT ACCTFILE ASSIGN TO "data/ACCTFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS ACCT-ID
        FILE STATUS IS WS-ACCT-STATUS.

DATA DIVISION.
FILE SECTION.
FD  LOANFILE.
    COPY "copybooks/LOANFLD.cpy".

FD  CUSTFILE.
    COPY "copybooks/CUSTFLD.cpy".

FD  ACCTFILE.
    COPY "copybooks/ACCTFLD.cpy".

WORKING-STORAGE SECTION.
01  WS-LOAN-STATUS         PIC X(2).
01  WS-CUST-STATUS         PIC X(2).
01  WS-ACCT-STATUS         PIC X(2).
01  WS-EOF                 PIC 9(1) VALUE 0.
01  WS-OPTION              PIC X(1).
01  WS-INPUT               PIC X(80).
01  WS-CONFIRM             PIC X(1).
01  WS-LOAN-SEQ            PIC 9(6) VALUE 200000.

01  WS-BNKUSER             PIC X(20).
01  WS-BNKROLE             PIC X(10).

*> Loan application fields
01  WS-APP-CID             PIC 9(5).
01  WS-APP-AID             PIC 9(6).
01  WS-APP-PRINC           PIC S9(11)V99.
01  WS-APP-RATE            PIC 9(3)V99 VALUE 8.50.
01  WS-APP-TERM            PIC 9(3).
01  WS-APP-MONTHLY         PIC S9(9)V99.
01  WS-APP-TOTAL-INT       PIC S9(11)V99.
01  WS-APP-TOTAL-COST      PIC S9(11)V99.
01  WS-LOAN-COUNT          PIC 9(3) VALUE 0.

*> Payment fields
01  WS-PMT-LID             PIC 9(6).
01  WS-PMT-AMT             PIC S9(11)V99.
01  WS-PMT-INT             PIC S9(11)V99.
01  WS-PMT-PRINC           PIC S9(11)V99.
01  WS-PMT-OLD-BAL         PIC S9(11)V99.
01  WS-PMT-NEW-BAL         PIC S9(11)V99.
01  WS-PMT-DEFAULT         PIC S9(11)V99.

*> PMT formula fields
01  WS-PMT-P               PIC S9(11)V99.
01  WS-PMT-R               PIC 9(3)V99.
01  WS-PMT-N               PIC 9(3).
01  WS-PMT-MR              PIC 9V9(10).
01  WS-PMT-PN              PIC 9(15)V9(6).
01  WS-PMT-RESULT          PIC S9(9)V99.

*> Amortization fields
01  WS-AMORT-BAL           PIC S9(11)V99.
01  WS-AMORT-INT           PIC S9(11)V99.
01  WS-AMORT-PRINC         PIC S9(11)V99.
01  WS-AMORT-PMT           PIC S9(9)V99.
01  WS-AMORT-TOTAL-INT     PIC S9(11)V99 VALUE 0.
01  WS-AMORT-I             PIC 9(3).

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
01  WS-NEXT-PMT-DATE       PIC 9(8).

PROCEDURE DIVISION.
MAIN-PARA.
    STOP RUN.

*> -------------------------------------------------------
*> LOAN-MENU: Loan Management Menu
*> -------------------------------------------------------
LOAN-MENU.
    DISPLAY " "
    DISPLAY "Loan Management"
    DISPLAY "==============="
    DISPLAY "1. Apply for Loan"
    DISPLAY "2. Make Payment"
    DISPLAY "3. View Loan Details"
    DISPLAY "4. Loan Payoff Quote"
    DISPLAY "5. Amortization Schedule"
    DISPLAY "B. Back"
    DISPLAY " "
    DISPLAY "Select: " WITH NO ADVANCING
    ACCEPT WS-OPTION

    EVALUATE WS-OPTION
        WHEN "1" PERFORM APPLY-FOR-LOAN
        WHEN "2" PERFORM MAKE-PAYMENT
        WHEN "3" PERFORM VIEW-LOAN
        WHEN "4" PERFORM PAYOFF-QUOTE
        WHEN "5" PERFORM AMORTIZATION
        WHEN "B" CONTINUE
        WHEN "b" CONTINUE
        WHEN OTHER DISPLAY "Invalid option."
    END-EVALUATE.

*> -------------------------------------------------------
*> APPLY-FOR-LOAN: Loan application
*> -------------------------------------------------------
APPLY-FOR-LOAN.
    DISPLAY " "
    DISPLAY "=== Loan Application ==="
    DISPLAY "Customer ID: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF
    MOVE WS-INPUT TO WS-APP-CID

    *> Verify customer
    OPEN INPUT CUSTFILE
    MOVE WS-APP-CID TO CUST-ID
    READ CUSTFILE
        INVALID KEY
            DISPLAY "Customer not found."
            CLOSE CUSTFILE
            EXIT PARAGRAPH
    END-READ
    IF CUST-STATUS NOT = "ACTIVE"
        DISPLAY "Customer must be active."
        CLOSE CUSTFILE
        EXIT PARAGRAPH
    END-IF
    IF CUST-KYC NOT = "VERIFIED"
        DISPLAY "KYC must be verified for loans."
        CLOSE CUSTFILE
        EXIT PARAGRAPH
    END-IF
    CLOSE CUSTFILE

    *> Check existing loan count -- max 3 active
    MOVE 0 TO WS-LOAN-COUNT
    OPEN INPUT LOANFILE
    IF WS-LOAN-STATUS = "00"
        MOVE WS-APP-CID TO LOAN-CUST-ID
        START LOANFILE KEY IS = LOAN-CUST-ID
            INVALID KEY CONTINUE
            NOT INVALID KEY
                MOVE 0 TO WS-EOF
                PERFORM UNTIL WS-EOF = 1
                    READ LOANFILE NEXT
                        AT END MOVE 1 TO WS-EOF
                    END-READ
                    IF WS-EOF = 0
                        IF LOAN-CUST-ID = WS-APP-CID
                            IF LOAN-STATUS = "ACTIVE"
                                ADD 1 TO WS-LOAN-COUNT
                            END-IF
                        ELSE
                            MOVE 1 TO WS-EOF
                        END-IF
                    END-IF
                END-PERFORM
        END-START
    END-IF
    CLOSE LOANFILE

    IF WS-LOAN-COUNT >= 3
        DISPLAY "Customer already has 3 active loans. "
            "Maximum reached."
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Disbursement Account: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    MOVE WS-INPUT TO WS-APP-AID

    *> Verify account
    OPEN INPUT ACCTFILE
    MOVE WS-APP-AID TO ACCT-ID
    READ ACCTFILE
        INVALID KEY
            DISPLAY "Account not found."
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-READ
    IF ACCT-CUST-ID NOT = WS-APP-CID
        DISPLAY "Account does not belong to this "
            "customer."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF
    IF ACCT-STATUS NOT = "ACTIVE"
        DISPLAY "Account must be active."
        CLOSE ACCTFILE
        EXIT PARAGRAPH
    END-IF
    CLOSE ACCTFILE

    DISPLAY "Loan interest rate: " WS-APP-RATE "%"

    DISPLAY "Principal amount: $" WITH NO ADVANCING
    ACCEPT WS-INPUT
    MOVE FUNCTION NUMVAL(WS-INPUT) TO WS-APP-PRINC
    IF WS-APP-PRINC < 1000
        DISPLAY "Minimum loan amount is $1,000."
        EXIT PARAGRAPH
    END-IF
    IF WS-APP-PRINC > 500000
        DISPLAY "Maximum loan amount is $500,000."
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Term (months, 12-360): " WITH NO ADVANCING
    ACCEPT WS-INPUT
    MOVE FUNCTION NUMVAL(WS-INPUT) TO WS-APP-TERM
    IF WS-APP-TERM < 12 OR WS-APP-TERM > 360
        DISPLAY "Term must be between 12 and 360 "
            "months."
        EXIT PARAGRAPH
    END-IF

    *> Calculate monthly payment (PMT formula)
    MOVE WS-APP-PRINC TO WS-PMT-P
    MOVE WS-APP-RATE  TO WS-PMT-R
    MOVE WS-APP-TERM  TO WS-PMT-N
    PERFORM CALCULATE-PMT
    MOVE WS-PMT-RESULT TO WS-APP-MONTHLY

    COMPUTE WS-APP-TOTAL-COST =
        WS-APP-MONTHLY * WS-APP-TERM
    COMPUTE WS-APP-TOTAL-INT =
        WS-APP-TOTAL-COST - WS-APP-PRINC

    DISPLAY " "
    DISPLAY "--- Loan Summary ---"
    DISPLAY "Principal:       $" WS-APP-PRINC
    DISPLAY "Rate:            " WS-APP-RATE "%"
    DISPLAY "Term:            " WS-APP-TERM " months"
    DISPLAY "Monthly Payment: $" WS-APP-MONTHLY
    DISPLAY "Total Interest:  $" WS-APP-TOTAL-INT
    DISPLAY "Total Cost:      $" WS-APP-TOTAL-COST

    DISPLAY " "
    DISPLAY "Approve loan? (Y/N): " WITH NO ADVANCING
    ACCEPT WS-CONFIRM
    IF WS-CONFIRM NOT = "Y" AND WS-CONFIRM NOT = "y"
        DISPLAY "Loan application cancelled."
        EXIT PARAGRAPH
    END-IF

    *> Generate loan ID
    OPEN I-O LOANFILE
    IF WS-LOAN-STATUS NOT = "00"
        OPEN OUTPUT LOANFILE
    END-IF

    MOVE 0 TO WS-EOF
    READ LOANFILE LAST
        AT END MOVE 1 TO WS-EOF
    END-READ
    IF WS-EOF = 0
        MOVE LOAN-ID TO WS-LOAN-SEQ
    ELSE
        MOVE 200000 TO WS-LOAN-SEQ
    END-IF
    ADD 1 TO WS-LOAN-SEQ

    *> Create loan record
    PERFORM BUILD-DATETIME
    MOVE WS-LOAN-SEQ    TO LOAN-ID
    MOVE WS-APP-CID     TO LOAN-CUST-ID
    MOVE WS-APP-AID     TO LOAN-ACCT-ID
    MOVE WS-APP-PRINC   TO LOAN-PRINCIPAL
    MOVE WS-APP-RATE    TO LOAN-RATE
    MOVE WS-APP-TERM    TO LOAN-TERM
    MOVE WS-APP-MONTHLY TO LOAN-MONTHLY
    MOVE WS-APP-PRINC   TO LOAN-BALANCE
    MOVE "ACTIVE"        TO LOAN-STATUS
    MOVE WS-DATETIME-STR TO LOAN-DISB-DATE
    MOVE 0               TO LOAN-PAID-MONTHS
    PERFORM CALC-NEXT-PMT-DATE
    MOVE WS-NEXT-PMT-DATE TO LOAN-NEXT-PMT
    MOVE SPACES          TO LOAN-LAST-PMT
    MOVE SPACES          TO LOAN-PAID-DATE

    WRITE LOAN-REC
    CLOSE LOANFILE

    DISPLAY " "
    DISPLAY "Loan approved and disbursed."
    DISPLAY "Loan ID: " WS-LOAN-SEQ
    DISPLAY "Funds deposited to account " WS-APP-AID.

*> -------------------------------------------------------
*> MAKE-PAYMENT: Process a loan payment
*> -------------------------------------------------------
MAKE-PAYMENT.
    DISPLAY " "
    DISPLAY "=== Loan Payment ==="
    DISPLAY "Loan ID: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF
    MOVE WS-INPUT TO WS-PMT-LID

    OPEN I-O LOANFILE
    IF WS-LOAN-STATUS NOT = "00"
        DISPLAY "No loan data."
        EXIT PARAGRAPH
    END-IF

    MOVE WS-PMT-LID TO LOAN-ID
    READ LOANFILE
        INVALID KEY
            DISPLAY "Loan not found."
            CLOSE LOANFILE
            EXIT PARAGRAPH
    END-READ

    IF LOAN-STATUS NOT = "ACTIVE"
        DISPLAY "Loan is not active (status: "
            FUNCTION TRIM(LOAN-STATUS) ")."
        CLOSE LOANFILE
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Loan Balance:    $" LOAN-BALANCE
    DISPLAY "Monthly Payment: $" LOAN-MONTHLY

    MOVE LOAN-MONTHLY TO WS-PMT-DEFAULT
    IF WS-PMT-DEFAULT > LOAN-BALANCE
        MOVE LOAN-BALANCE TO WS-PMT-DEFAULT
    END-IF

    DISPLAY "Payment amount (default $"
        WS-PMT-DEFAULT "): $" WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        MOVE WS-PMT-DEFAULT TO WS-PMT-AMT
    ELSE
        MOVE FUNCTION NUMVAL(WS-INPUT) TO WS-PMT-AMT
    END-IF

    IF WS-PMT-AMT <= 0
        DISPLAY "Amount must be positive."
        CLOSE LOANFILE
        EXIT PARAGRAPH
    END-IF

    IF WS-PMT-AMT > LOAN-BALANCE
        DISPLAY "Payment exceeds loan balance. "
            "Adjusting to $" LOAN-BALANCE
        MOVE LOAN-BALANCE TO WS-PMT-AMT
    END-IF

    *> Split into interest and principal portions
    MOVE LOAN-BALANCE TO WS-PMT-OLD-BAL
    COMPUTE WS-PMT-INT =
        WS-PMT-OLD-BAL * (LOAN-RATE / 100 / 12)
    IF WS-PMT-INT > WS-PMT-AMT
        MOVE WS-PMT-AMT TO WS-PMT-INT
    END-IF
    COMPUTE WS-PMT-PRINC = WS-PMT-AMT - WS-PMT-INT

    *> Update loan balance
    COMPUTE WS-PMT-NEW-BAL =
        WS-PMT-OLD-BAL - WS-PMT-PRINC
    IF WS-PMT-NEW-BAL < 0.01
        MOVE 0 TO WS-PMT-NEW-BAL
    END-IF

    MOVE WS-PMT-NEW-BAL TO LOAN-BALANCE
    ADD 1 TO LOAN-PAID-MONTHS
    PERFORM BUILD-DATETIME
    MOVE WS-DATETIME-STR TO LOAN-LAST-PMT
    PERFORM CALC-NEXT-PMT-DATE
    MOVE WS-NEXT-PMT-DATE TO LOAN-NEXT-PMT

    *> Check if fully paid
    IF WS-PMT-NEW-BAL = 0
        MOVE "PAID" TO LOAN-STATUS
        MOVE WS-DATETIME-STR TO LOAN-PAID-DATE
        DISPLAY "*** LOAN FULLY PAID ***"
    END-IF

    REWRITE LOAN-REC
    CLOSE LOANFILE

    DISPLAY " "
    DISPLAY "Payment applied."
    DISPLAY "Total Payment:     $" WS-PMT-AMT
    DISPLAY "  Interest:        $" WS-PMT-INT
    DISPLAY "  Principal:       $" WS-PMT-PRINC
    DISPLAY "Remaining Balance: $" WS-PMT-NEW-BAL
    IF WS-PMT-NEW-BAL > 0
        DISPLAY "Payments Made:     "
            LOAN-PAID-MONTHS " of " LOAN-TERM
    END-IF.

*> -------------------------------------------------------
*> VIEW-LOAN: View loan details
*> -------------------------------------------------------
VIEW-LOAN.
    DISPLAY "Loan ID: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN INPUT LOANFILE
    IF WS-LOAN-STATUS NOT = "00"
        DISPLAY "No loan data."
        EXIT PARAGRAPH
    END-IF

    MOVE WS-INPUT TO LOAN-ID
    READ LOANFILE
        INVALID KEY
            DISPLAY "Loan not found."
            CLOSE LOANFILE
            EXIT PARAGRAPH
    END-READ

    DISPLAY " "
    DISPLAY "=== Loan Details ==="
    DISPLAY "Loan ID:       " LOAN-ID
    DISPLAY "Customer ID:   " LOAN-CUST-ID
    DISPLAY "Account:       " LOAN-ACCT-ID
    DISPLAY "Principal:     $" LOAN-PRINCIPAL
    DISPLAY "Rate:          " LOAN-RATE "%"
    DISPLAY "Term:          " LOAN-TERM " months"
    DISPLAY "Monthly Pmt:   $" LOAN-MONTHLY
    DISPLAY "Balance:       $" LOAN-BALANCE
    DISPLAY "Status:        " FUNCTION TRIM(LOAN-STATUS)
    DISPLAY "Disbursed:     "
        FUNCTION TRIM(LOAN-DISB-DATE)
    DISPLAY "Payments Made: " LOAN-PAID-MONTHS
    IF LOAN-LAST-PMT NOT = SPACES
        DISPLAY "Last Payment:  "
            FUNCTION TRIM(LOAN-LAST-PMT)
    END-IF
    IF LOAN-STATUS = "ACTIVE"
        DISPLAY "Next Payment:  " LOAN-NEXT-PMT
    END-IF
    IF LOAN-STATUS = "PAID"
        DISPLAY "Paid Off:      "
            FUNCTION TRIM(LOAN-PAID-DATE)
    END-IF

    CLOSE LOANFILE.

*> -------------------------------------------------------
*> PAYOFF-QUOTE: Calculate loan payoff amount
*> -------------------------------------------------------
PAYOFF-QUOTE.
    DISPLAY "Loan ID: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN INPUT LOANFILE
    MOVE WS-INPUT TO LOAN-ID
    READ LOANFILE
        INVALID KEY
            DISPLAY "Loan not found."
            CLOSE LOANFILE
            EXIT PARAGRAPH
    END-READ

    IF LOAN-STATUS NOT = "ACTIVE"
        DISPLAY "Loan is not active."
        CLOSE LOANFILE
        EXIT PARAGRAPH
    END-IF

    COMPUTE WS-PMT-INT =
        LOAN-BALANCE * (LOAN-RATE / 100 / 12)

    DISPLAY " "
    DISPLAY "=== Payoff Quote ==="
    DISPLAY "Outstanding Principal: $" LOAN-BALANCE
    DISPLAY "Accrued Interest:      $" WS-PMT-INT
    COMPUTE WS-PMT-AMT = LOAN-BALANCE + WS-PMT-INT
    DISPLAY "Payoff Amount:         $" WS-PMT-AMT
    PERFORM BUILD-TODAY
    DISPLAY "Quote valid through:   "
        WS-TODAY-STR(5:2) "/"
        WS-TODAY-STR(7:2) "/"
        WS-TODAY-STR(1:4)

    CLOSE LOANFILE.

*> -------------------------------------------------------
*> AMORTIZATION: Display amortization schedule
*> -------------------------------------------------------
AMORTIZATION.
    DISPLAY "Loan ID: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN INPUT LOANFILE
    MOVE WS-INPUT TO LOAN-ID
    READ LOANFILE
        INVALID KEY
            DISPLAY "Loan not found."
            CLOSE LOANFILE
            EXIT PARAGRAPH
    END-READ

    MOVE LOAN-PRINCIPAL TO WS-AMORT-BAL
    MOVE LOAN-MONTHLY   TO WS-AMORT-PMT
    MOVE 0 TO WS-AMORT-TOTAL-INT

    DISPLAY " "
    DISPLAY "=== Amortization Schedule ==="
    DISPLAY "Loan ID: " LOAN-ID
        "  Principal: $" LOAN-PRINCIPAL
    DISPLAY "Rate: " LOAN-RATE "%  Term: "
        LOAN-TERM " months  Monthly: $" LOAN-MONTHLY
    DISPLAY " "
    DISPLAY "Month  Payment         Interest"
        "        Principal       Balance"
    DISPLAY "-----  --------------- "
        "--------------- --------------- "
        "---------------"

    PERFORM VARYING WS-AMORT-I FROM 1 BY 1
        UNTIL WS-AMORT-I > LOAN-TERM
        OR WS-AMORT-BAL <= 0
        COMPUTE WS-AMORT-INT =
            WS-AMORT-BAL * (LOAN-RATE / 100 / 12)
        COMPUTE WS-AMORT-PRINC =
            WS-AMORT-PMT - WS-AMORT-INT
        IF WS-AMORT-PRINC > WS-AMORT-BAL
            MOVE WS-AMORT-BAL TO WS-AMORT-PRINC
            COMPUTE WS-AMORT-PMT =
                WS-AMORT-INT + WS-AMORT-PRINC
        END-IF
        SUBTRACT WS-AMORT-PRINC FROM WS-AMORT-BAL
        IF WS-AMORT-BAL < 0.01
            MOVE 0 TO WS-AMORT-BAL
        END-IF
        ADD WS-AMORT-INT TO WS-AMORT-TOTAL-INT
        DISPLAY WS-AMORT-I "    $"
            WS-AMORT-PMT "  $"
            WS-AMORT-INT "  $"
            WS-AMORT-PRINC "  $"
            WS-AMORT-BAL
    END-PERFORM

    DISPLAY " "
    DISPLAY "Total Interest Paid: $"
        WS-AMORT-TOTAL-INT

    CLOSE LOANFILE.

*> -------------------------------------------------------
*> CALCULATE-PMT: PMT formula for monthly payment
*> PMT = P * [r(1+r)^n] / [(1+r)^n - 1]
*> Input:  WS-PMT-P, WS-PMT-R, WS-PMT-N
*> Output: WS-PMT-RESULT
*> -------------------------------------------------------
CALCULATE-PMT.
    COMPUTE WS-PMT-MR = WS-PMT-R / 100 / 12
    IF WS-PMT-MR = 0
        COMPUTE WS-PMT-RESULT = WS-PMT-P / WS-PMT-N
    ELSE
        COMPUTE WS-PMT-PN =
            (1 + WS-PMT-MR) ** WS-PMT-N
        COMPUTE WS-PMT-RESULT =
            WS-PMT-P * (WS-PMT-MR * WS-PMT-PN)
            / (WS-PMT-PN - 1)
    END-IF.

*> -------------------------------------------------------
*> CALC-NEXT-PMT-DATE: 1 month from today
*> -------------------------------------------------------
CALC-NEXT-PMT-DATE.
    PERFORM BUILD-TODAY
    MOVE WS-TODAY-STR(1:4) TO WS-NOW-YEAR
    MOVE WS-TODAY-STR(5:2) TO WS-NOW-MONTH
    MOVE WS-TODAY-STR(7:2) TO WS-NOW-DAY
    ADD 1 TO WS-NOW-MONTH
    IF WS-NOW-MONTH > 12
        SUBTRACT 12 FROM WS-NOW-MONTH
        ADD 1 TO WS-NOW-YEAR
    END-IF
    STRING WS-NOW-YEAR WS-NOW-MONTH WS-NOW-DAY
        DELIMITED BY SIZE INTO WS-NEXT-PMT-DATE
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
