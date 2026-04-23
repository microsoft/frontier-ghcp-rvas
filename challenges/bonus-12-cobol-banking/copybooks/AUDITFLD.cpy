      *> AUDITFLD.cpy - Audit Trail Record Layout
      *> Used by: BNKAUDT, BNKINIT
       01  AUDIT-REC.
           05  AUDIT-ID            PIC 9(8).
           05  AUDIT-USER          PIC X(20).
           05  AUDIT-ACTION        PIC X(15).
           05  AUDIT-DETAIL        PIC X(200).
           05  AUDIT-DATETIME      PIC X(19).
           05  AUDIT-DATE-IDX      PIC 9(8).
