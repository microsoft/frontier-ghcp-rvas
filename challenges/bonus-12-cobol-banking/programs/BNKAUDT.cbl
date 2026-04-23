>>SOURCE FORMAT IS FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. BNKAUDT.
*> Audit Trail Module
*> All security-relevant and business actions are logged here
*> Append-only audit log with date indexing

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT AUDITFILE ASSIGN TO "data/AUDITFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS AUDIT-ID
        ALTERNATE RECORD KEY IS AUDIT-DATE-IDX
            WITH DUPLICATES
        FILE STATUS IS WS-FILE-STATUS.

DATA DIVISION.
FILE SECTION.
FD  AUDITFILE.
    COPY "copybooks/AUDITFLD.cpy".

WORKING-STORAGE SECTION.
01  WS-FILE-STATUS         PIC X(2).
01  WS-AUDIT-SEQ           PIC 9(8) VALUE 0.
01  WS-DISPLAY-CNT         PIC 9(5) VALUE 0.
01  WS-MAX-RECORDS         PIC 9(5) VALUE 25.
01  WS-OPTION              PIC X(1).
01  WS-SEARCH-USER         PIC X(20).
01  WS-SEARCH-ACTION       PIC X(15).
01  WS-SEARCH-DATE         PIC 9(8).
01  WS-EOF                 PIC 9(1) VALUE 0.
01  WS-INPUT               PIC X(80).

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
*> LOG-ENTRY: Write an audit log entry
*> Called by other programs with: user, action, detail
*> -------------------------------------------------------
LOG-ENTRY.
    OPEN I-O AUDITFILE
    IF WS-FILE-STATUS NOT = "00" AND "05"
        OPEN OUTPUT AUDITFILE
        IF WS-FILE-STATUS NOT = "00"
            EXIT PARAGRAPH
        END-IF
    END-IF

    PERFORM GET-NEXT-AUDIT-ID
    PERFORM GET-CURRENT-DATETIME

    MOVE WS-DATETIME-STR TO AUDIT-DATETIME
    MOVE WS-TODAY-STR    TO AUDIT-DATE-IDX
    *> Truncate long detail to 200 chars
    IF FUNCTION LENGTH(FUNCTION TRIM(AUDIT-DETAIL))
        > 200
        MOVE AUDIT-DETAIL(1:200) TO AUDIT-DETAIL
    END-IF

    WRITE AUDIT-REC
    IF WS-FILE-STATUS NOT = "00"
        CONTINUE
        *> silently fail - audit should not block operations
    END-IF

    CLOSE AUDITFILE.

*> -------------------------------------------------------
*> GET-NEXT-AUDIT-ID: Increment audit sequence
*> -------------------------------------------------------
GET-NEXT-AUDIT-ID.
    *> Read to end to find highest ID
    MOVE 0 TO WS-AUDIT-SEQ
    MOVE 0 TO WS-EOF

    READ AUDITFILE LAST
        AT END MOVE 1 TO WS-EOF
    END-READ

    IF WS-EOF = 0
        MOVE AUDIT-ID TO WS-AUDIT-SEQ
    END-IF

    ADD 1 TO WS-AUDIT-SEQ
    MOVE WS-AUDIT-SEQ TO AUDIT-ID.

*> -------------------------------------------------------
*> GET-CURRENT-DATETIME: Build datetime strings
*> -------------------------------------------------------
GET-CURRENT-DATETIME.
    MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DT
    STRING WS-NOW-YEAR WS-NOW-MONTH WS-NOW-DAY
        " "
        WS-NOW-HOUR ":" WS-NOW-MIN ":" WS-NOW-SEC
        DELIMITED BY SIZE INTO WS-DATETIME-STR
    END-STRING
    STRING WS-NOW-YEAR WS-NOW-MONTH WS-NOW-DAY
        DELIMITED BY SIZE INTO WS-TODAY-STR
    END-STRING.

*> -------------------------------------------------------
*> VIEW-LOG: View audit log entries (menu)
*> -------------------------------------------------------
VIEW-LOG.
    DISPLAY " "
    DISPLAY "Audit Log Viewer"
    DISPLAY "================"
    DISPLAY "1. View recent entries"
    DISPLAY "2. View by date"
    DISPLAY "3. View by user"
    DISPLAY "4. View by action type"
    DISPLAY "B. Back"
    DISPLAY " "
    DISPLAY "Select: " WITH NO ADVANCING
    ACCEPT WS-OPTION

    EVALUATE WS-OPTION
        WHEN "1" PERFORM VIEW-RECENT
        WHEN "2" PERFORM VIEW-BY-DATE
        WHEN "3" PERFORM VIEW-BY-USER
        WHEN "4" PERFORM VIEW-BY-ACTION
        WHEN "B" CONTINUE
        WHEN "b" CONTINUE
        WHEN OTHER DISPLAY "Invalid option."
    END-EVALUATE.

*> -------------------------------------------------------
*> VIEW-RECENT: Show last N audit entries
*> -------------------------------------------------------
VIEW-RECENT.
    DISPLAY "How many entries? (default 25): "
        WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        MOVE 25 TO WS-MAX-RECORDS
    ELSE
        MOVE FUNCTION NUMVAL(WS-INPUT) TO WS-MAX-RECORDS
    END-IF
    IF WS-MAX-RECORDS < 1
        MOVE 25 TO WS-MAX-RECORDS
    END-IF
    IF WS-MAX-RECORDS > 500
        MOVE 500 TO WS-MAX-RECORDS
    END-IF

    OPEN INPUT AUDITFILE
    IF WS-FILE-STATUS NOT = "00"
        DISPLAY "No audit data found."
        EXIT PARAGRAPH
    END-IF

    PERFORM DISPLAY-HEADER

    MOVE 0 TO WS-DISPLAY-CNT
    MOVE 0 TO WS-EOF

    READ AUDITFILE LAST
        AT END MOVE 1 TO WS-EOF
    END-READ

    PERFORM UNTIL WS-EOF = 1
        OR WS-DISPLAY-CNT >= WS-MAX-RECORDS
        ADD 1 TO WS-DISPLAY-CNT
        PERFORM DISPLAY-ENTRY
        READ AUDITFILE PREVIOUS
            AT END MOVE 1 TO WS-EOF
        END-READ
    END-PERFORM

    IF WS-DISPLAY-CNT = 0
        DISPLAY "No audit entries found."
    END-IF

    CLOSE AUDITFILE.

*> -------------------------------------------------------
*> VIEW-BY-DATE: Show entries for a specific date
*> -------------------------------------------------------
VIEW-BY-DATE.
    DISPLAY "Date (YYYYMMDD, blank for today): "
        WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DT
        STRING WS-NOW-YEAR WS-NOW-MONTH WS-NOW-DAY
            DELIMITED BY SIZE INTO WS-INPUT
        END-STRING
    END-IF
    MOVE WS-INPUT TO WS-SEARCH-DATE

    OPEN INPUT AUDITFILE
    IF WS-FILE-STATUS NOT = "00"
        DISPLAY "No audit data found."
        EXIT PARAGRAPH
    END-IF

    PERFORM DISPLAY-HEADER
    MOVE 0 TO WS-DISPLAY-CNT
    MOVE 0 TO WS-EOF

    MOVE WS-SEARCH-DATE TO AUDIT-DATE-IDX
    START AUDITFILE KEY IS = AUDIT-DATE-IDX
        INVALID KEY MOVE 1 TO WS-EOF
    END-START

    PERFORM UNTIL WS-EOF = 1
        READ AUDITFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
        IF WS-EOF = 0
            IF AUDIT-DATE-IDX = WS-SEARCH-DATE
                ADD 1 TO WS-DISPLAY-CNT
                PERFORM DISPLAY-ENTRY
            ELSE
                MOVE 1 TO WS-EOF
            END-IF
        END-IF
    END-PERFORM

    DISPLAY "Total entries for date: " WS-DISPLAY-CNT
    CLOSE AUDITFILE.

*> -------------------------------------------------------
*> VIEW-BY-USER: Filter by user ID
*> -------------------------------------------------------
VIEW-BY-USER.
    DISPLAY "User ID: " WITH NO ADVANCING
    ACCEPT WS-SEARCH-USER
    IF WS-SEARCH-USER = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN INPUT AUDITFILE
    IF WS-FILE-STATUS NOT = "00"
        DISPLAY "No audit data found."
        EXIT PARAGRAPH
    END-IF

    PERFORM DISPLAY-HEADER
    MOVE 0 TO WS-DISPLAY-CNT
    MOVE 100 TO WS-MAX-RECORDS
    MOVE 0 TO WS-EOF

    READ AUDITFILE LAST
        AT END MOVE 1 TO WS-EOF
    END-READ

    PERFORM UNTIL WS-EOF = 1
        OR WS-DISPLAY-CNT >= WS-MAX-RECORDS
        IF AUDIT-USER = WS-SEARCH-USER
            ADD 1 TO WS-DISPLAY-CNT
            PERFORM DISPLAY-ENTRY
        END-IF
        READ AUDITFILE PREVIOUS
            AT END MOVE 1 TO WS-EOF
        END-READ
    END-PERFORM

    DISPLAY "Total entries for user "
        FUNCTION TRIM(WS-SEARCH-USER) ": "
        WS-DISPLAY-CNT
    CLOSE AUDITFILE.

*> -------------------------------------------------------
*> VIEW-BY-ACTION: Filter by action type
*> -------------------------------------------------------
VIEW-BY-ACTION.
    DISPLAY "Action type (LOGIN/LOGOUT/NEWCUST/NEWACCT/"
        "TRANSFER/etc.): " WITH NO ADVANCING
    ACCEPT WS-SEARCH-ACTION
    IF WS-SEARCH-ACTION = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN INPUT AUDITFILE
    IF WS-FILE-STATUS NOT = "00"
        DISPLAY "No audit data found."
        EXIT PARAGRAPH
    END-IF

    PERFORM DISPLAY-HEADER
    MOVE 0 TO WS-DISPLAY-CNT
    MOVE 100 TO WS-MAX-RECORDS
    MOVE 0 TO WS-EOF

    READ AUDITFILE LAST
        AT END MOVE 1 TO WS-EOF
    END-READ

    PERFORM UNTIL WS-EOF = 1
        OR WS-DISPLAY-CNT >= WS-MAX-RECORDS
        IF AUDIT-ACTION = WS-SEARCH-ACTION
            ADD 1 TO WS-DISPLAY-CNT
            PERFORM DISPLAY-ENTRY
        END-IF
        READ AUDITFILE PREVIOUS
            AT END MOVE 1 TO WS-EOF
        END-READ
    END-PERFORM

    DISPLAY "Total entries for action "
        FUNCTION TRIM(WS-SEARCH-ACTION) ": "
        WS-DISPLAY-CNT
    CLOSE AUDITFILE.

*> -------------------------------------------------------
*> DISPLAY-HEADER: Print log header
*> -------------------------------------------------------
DISPLAY-HEADER.
    DISPLAY " "
    DISPLAY "ID       Date/Time            User"
        "                 Action          Detail"
    DISPLAY "-------- ------------------- "
        "-------------------- --------------- "
        "----------------------------------------".

*> -------------------------------------------------------
*> DISPLAY-ENTRY: Display a single audit entry
*> -------------------------------------------------------
DISPLAY-ENTRY.
    DISPLAY AUDIT-ID " "
        AUDIT-DATETIME " "
        AUDIT-USER " "
        AUDIT-ACTION " "
        AUDIT-DETAIL(1:40).
