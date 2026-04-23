      *> CUSTFLD.cpy - Customer Record Layout
      *> Used by: BNKCUST, BNKACCT, BNKLOAN, BNKRPT, BNKINIT
       01  CUST-REC.
           05  CUST-ID             PIC 9(5).
           05  CUST-FIRST-NAME     PIC X(30).
           05  CUST-LAST-NAME      PIC X(30).
           05  CUST-DOB            PIC 9(8).
           05  CUST-SSN            PIC X(11).
           05  CUST-ADDR-LINE1     PIC X(50).
           05  CUST-ADDR-LINE2     PIC X(50).
           05  CUST-ADDR-CITY      PIC X(30).
           05  CUST-ADDR-STATE     PIC X(2).
           05  CUST-ADDR-ZIP       PIC X(10).
           05  CUST-PHONE          PIC X(15).
           05  CUST-EMAIL          PIC X(50).
           05  CUST-STATUS         PIC X(10).
           05  CUST-CREATED        PIC X(19).
           05  CUST-KYC            PIC X(10).
