      *> BATCHFLD.cpy - Batch Run Record Layout
      *> Used by: BNKBATCH, BNKINIT
       01  BATCH-REC.
           05  BATCH-RUN-ID        PIC 9(6).
           05  BATCH-START         PIC X(19).
           05  BATCH-END           PIC X(19).
           05  BATCH-STATUS        PIC X(10).
           05  BATCH-SAV-INT       PIC S9(9)V99.
           05  BATCH-CHK-INT       PIC S9(9)V99.
           05  BATCH-FD-MAT        PIC 9(5).
           05  BATCH-FEES          PIC S9(9)V99.
           05  BATCH-OVERDUE       PIC 9(5).
           05  BATCH-ERRORS        PIC 9(5).
           05  BATCH-LAST-RUN      PIC 9(8).
