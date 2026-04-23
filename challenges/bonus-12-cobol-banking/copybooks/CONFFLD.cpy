      *> CONFFLD.cpy - Configuration Record Layout
      *> Used by: BNKMAIN, BNKACCT, BNKTXN, BNKINTR, BNKBATCH, BNKINIT
       01  CONF-REC.
           05  CONF-KEY            PIC X(20).
           05  CONF-VALUE          PIC X(50).
           05  CONF-DESC           PIC X(80).
