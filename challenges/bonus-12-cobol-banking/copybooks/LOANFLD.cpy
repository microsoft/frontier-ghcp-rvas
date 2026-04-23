      *> LOANFLD.cpy - Loan Record Layout
      *> Used by: BNKLOAN, BNKBATCH, BNKRPT, BNKINIT
       01  LOAN-REC.
           05  LOAN-ID             PIC 9(6).
           05  LOAN-CUST-ID        PIC 9(5).
           05  LOAN-ACCT-ID        PIC 9(6).
           05  LOAN-PRINCIPAL      PIC S9(11)V99.
           05  LOAN-RATE           PIC 9(3)V99.
           05  LOAN-TERM           PIC 9(3).
           05  LOAN-MONTHLY        PIC S9(9)V99.
           05  LOAN-BALANCE        PIC S9(11)V99.
           05  LOAN-STATUS         PIC X(10).
           05  LOAN-DISB-DATE      PIC X(19).
           05  LOAN-PAID-MONTHS    PIC 9(3).
           05  LOAN-NEXT-PMT       PIC 9(8).
           05  LOAN-LAST-PMT       PIC X(19).
           05  LOAN-PAID-DATE      PIC X(19).
