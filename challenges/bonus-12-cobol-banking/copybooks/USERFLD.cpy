      *> USERFLD.cpy - User Record Layout
      *> Used by: BNKAUTH, BNKINIT
       01  USER-REC.
           05  USER-ID             PIC X(20).
           05  USER-NAME           PIC X(40).
           05  USER-HASH           PIC 9(18).
           05  USER-ROLE           PIC X(10).
           05  USER-STATUS         PIC X(10).
           05  USER-CREATED        PIC X(19).
           05  USER-LAST-LOGIN     PIC X(19).
