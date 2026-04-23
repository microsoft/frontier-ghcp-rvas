      *> ACCTFLD.cpy - Account Record Layout
      *> Used by: BNKACCT, BNKTXN, BNKINTR, BNKBATCH, BNKRPT, BNKINIT
       01  ACCT-REC.
           05  ACCT-ID             PIC 9(6).
           05  ACCT-CUST-ID        PIC 9(5).
           05  ACCT-TYPE           PIC X(3).
           05  ACCT-BAL            PIC S9(11)V99.
           05  ACCT-STATUS         PIC X(10).
           05  ACCT-OPENED         PIC X(19).
           05  ACCT-RATE           PIC 9(3)V99.
           05  ACCT-CURRENCY       PIC X(3).
           05  ACCT-OVERDRAFT      PIC S9(9)V99.
           05  ACCT-TERM           PIC 9(3).
           05  ACCT-MATURITY       PIC 9(8).
           05  ACCT-ORIG-DEP       PIC S9(11)V99.
           05  ACCT-ACCR-INT       PIC S9(9)V9999.
           05  ACCT-LAST-INT       PIC X(19).
