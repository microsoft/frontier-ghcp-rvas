      *> TXNFLD.cpy - Transaction Record Layout
      *> Used by: BNKTXN, BNKRPT, BNKINIT
       01  TXN-REC.
           05  TXN-ID              PIC 9(8).
           05  TXN-ACCT-ID         PIC 9(6).
           05  TXN-TYPE            PIC X(5).
           05  TXN-AMOUNT          PIC S9(11)V99.
           05  TXN-BAL-BEFORE      PIC S9(11)V99.
           05  TXN-BAL-AFTER       PIC S9(11)V99.
           05  TXN-DESC            PIC X(50).
           05  TXN-DATETIME        PIC X(19).
           05  TXN-TELLER          PIC X(20).
           05  TXN-REF-ID          PIC 9(8).
           05  TXN-DATE-IDX        PIC 9(8).
