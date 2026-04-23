>>SOURCE FORMAT IS FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. BNKUTIL.
*> Utility Functions
*> Date handling, formatting, string operations
*> Shared by all modules via CALL statements

DATA DIVISION.
WORKING-STORAGE SECTION.

01  WS-CURRENT-DATE.
    05  WS-CD-YEAR         PIC 9(4).
    05  WS-CD-MONTH        PIC 9(2).
    05  WS-CD-DAY          PIC 9(2).
    05  WS-CD-HOUR         PIC 9(2).
    05  WS-CD-MIN          PIC 9(2).
    05  WS-CD-SEC          PIC 9(2).
    05  WS-CD-HSEC         PIC 9(2).

01  WS-WORK-FIELDS.
    05  WS-TEMP-NUM        PIC 9(18).
    05  WS-TEMP-STR        PIC X(256).
    05  WS-I               PIC 9(5).
    05  WS-J               PIC 9(5).
    05  WS-LEN             PIC 9(5).
    05  WS-CHAR            PIC X(1).
    05  WS-RESULT          PIC X(256).

01  WS-DATE-FIELDS.
    05  WS-DT-YEAR         PIC 9(4).
    05  WS-DT-MONTH        PIC 9(2).
    05  WS-DT-DAY          PIC 9(2).
    05  WS-DT-YEAR2        PIC 9(4).
    05  WS-DT-MONTH2       PIC 9(2).
    05  WS-DT-DAY2         PIC 9(2).
    05  WS-DIM             PIC 9(2).
    05  WS-LEAP            PIC 9(1).

01  WS-FMT-FIELDS.
    05  WS-FMT-INPUT       PIC X(20).
    05  WS-FMT-OUTPUT      PIC X(20).
    05  WS-FMT-AMT         PIC S9(13)V99.
    05  WS-FMT-INT-PART    PIC X(20).
    05  WS-FMT-DEC-PART    PIC X(2).
    05  WS-FMT-SIGN        PIC X(1).
    05  WS-FMT-POS         PIC 9(3).

PROCEDURE DIVISION.
MAIN-PARA.
    STOP RUN.

*> -------------------------------------------------------
*> GET-TODAY: Return today's date as YYYYMMDD
*> Input:  none
*> Output: WS-FMT-OUTPUT contains YYYYMMDD
*> -------------------------------------------------------
GET-TODAY.
    MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DATE
    STRING WS-CD-YEAR WS-CD-MONTH WS-CD-DAY
        DELIMITED BY SIZE INTO WS-FMT-OUTPUT
    END-STRING.

*> -------------------------------------------------------
*> GET-NOW: Return current datetime as "YYYYMMDD HH:MM:SS"
*> Input:  none
*> Output: WS-FMT-OUTPUT contains datetime string
*> -------------------------------------------------------
GET-NOW.
    MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DATE
    STRING WS-CD-YEAR WS-CD-MONTH WS-CD-DAY
        " "
        WS-CD-HOUR ":" WS-CD-MIN ":" WS-CD-SEC
        DELIMITED BY SIZE INTO WS-FMT-OUTPUT
    END-STRING.

*> -------------------------------------------------------
*> FORMAT-DATE: Convert YYYYMMDD to MM/DD/YYYY
*> Input:  WS-FMT-INPUT contains YYYYMMDD
*> Output: WS-FMT-OUTPUT contains MM/DD/YYYY
*> -------------------------------------------------------
FORMAT-DATE.
    IF FUNCTION LENGTH(FUNCTION TRIM(WS-FMT-INPUT))
        < 8
        MOVE WS-FMT-INPUT TO WS-FMT-OUTPUT
    ELSE
        STRING WS-FMT-INPUT(5:2) "/"
               WS-FMT-INPUT(7:2) "/"
               WS-FMT-INPUT(1:4)
            DELIMITED BY SIZE INTO WS-FMT-OUTPUT
        END-STRING
    END-IF.

*> -------------------------------------------------------
*> VALIDATE-DATE: Validate YYYYMMDD date string
*> Input:  WS-FMT-INPUT contains date to validate
*> Output: WS-TEMP-NUM = 1 if valid, 0 if not
*> -------------------------------------------------------
VALIDATE-DATE.
    MOVE 0 TO WS-TEMP-NUM
    IF FUNCTION LENGTH(FUNCTION TRIM(WS-FMT-INPUT)) NOT = 8
        EXIT PARAGRAPH
    END-IF
    IF WS-FMT-INPUT IS NOT NUMERIC
        EXIT PARAGRAPH
    END-IF

    MOVE WS-FMT-INPUT(1:4) TO WS-DT-YEAR
    MOVE WS-FMT-INPUT(5:2) TO WS-DT-MONTH
    MOVE WS-FMT-INPUT(7:2) TO WS-DT-DAY

    IF WS-DT-YEAR < 1900 OR WS-DT-YEAR > 2100
        EXIT PARAGRAPH
    END-IF
    IF WS-DT-MONTH < 1 OR WS-DT-MONTH > 12
        EXIT PARAGRAPH
    END-IF
    IF WS-DT-DAY < 1 OR WS-DT-DAY > 31
        EXIT PARAGRAPH
    END-IF

    PERFORM GET-DAYS-IN-MONTH
    IF WS-DT-DAY > WS-DIM
        EXIT PARAGRAPH
    END-IF

    MOVE 1 TO WS-TEMP-NUM.

*> -------------------------------------------------------
*> GET-DAYS-IN-MONTH: Get days in month for WS-DT-YEAR/MONTH
*> Output: WS-DIM
*> -------------------------------------------------------
GET-DAYS-IN-MONTH.
    MOVE 0 TO WS-LEAP
    IF FUNCTION MOD(WS-DT-YEAR, 4) = 0
        IF FUNCTION MOD(WS-DT-YEAR, 100) NOT = 0
            OR FUNCTION MOD(WS-DT-YEAR, 400) = 0
            MOVE 1 TO WS-LEAP
        END-IF
    END-IF

    EVALUATE WS-DT-MONTH
        WHEN 1 MOVE 31 TO WS-DIM
        WHEN 2
            IF WS-LEAP = 1
                MOVE 29 TO WS-DIM
            ELSE
                MOVE 28 TO WS-DIM
            END-IF
        WHEN 3 MOVE 31 TO WS-DIM
        WHEN 4 MOVE 30 TO WS-DIM
        WHEN 5 MOVE 31 TO WS-DIM
        WHEN 6 MOVE 30 TO WS-DIM
        WHEN 7 MOVE 31 TO WS-DIM
        WHEN 8 MOVE 31 TO WS-DIM
        WHEN 9 MOVE 30 TO WS-DIM
        WHEN 10 MOVE 31 TO WS-DIM
        WHEN 11 MOVE 30 TO WS-DIM
        WHEN 12 MOVE 31 TO WS-DIM
        WHEN OTHER MOVE 30 TO WS-DIM
    END-EVALUATE.

*> -------------------------------------------------------
*> ADD-MONTHS: Add N months to a YYYYMMDD date
*> Input:  WS-FMT-INPUT = YYYYMMDD, WS-TEMP-NUM = months
*> Output: WS-FMT-OUTPUT = new YYYYMMDD
*> -------------------------------------------------------
ADD-MONTHS.
    MOVE WS-FMT-INPUT(1:4) TO WS-DT-YEAR
    MOVE WS-FMT-INPUT(5:2) TO WS-DT-MONTH
    MOVE WS-FMT-INPUT(7:2) TO WS-DT-DAY

    ADD WS-TEMP-NUM TO WS-DT-MONTH

    PERFORM UNTIL WS-DT-MONTH <= 12
        SUBTRACT 12 FROM WS-DT-MONTH
        ADD 1 TO WS-DT-YEAR
    END-PERFORM

    PERFORM GET-DAYS-IN-MONTH
    IF WS-DT-DAY > WS-DIM
        MOVE WS-DIM TO WS-DT-DAY
    END-IF

    MOVE WS-DT-YEAR  TO WS-FMT-OUTPUT(1:4)
    MOVE WS-DT-MONTH TO WS-FMT-OUTPUT(5:2)
    MOVE WS-DT-DAY   TO WS-FMT-OUTPUT(7:2)
    MOVE SPACES       TO WS-FMT-OUTPUT(9:).

*> -------------------------------------------------------
*> DAYS-DIFF: Approximate days between two YYYYMMDD dates
*> Simplified -- treats all months as 30 days
*> Good enough for interest calculations
*> Input:  WS-FMT-INPUT = date1, WS-FMT-OUTPUT = date2
*> Output: WS-TEMP-NUM = days difference
*> -------------------------------------------------------
DAYS-DIFF.
    MOVE WS-FMT-INPUT(1:4)  TO WS-DT-YEAR
    MOVE WS-FMT-INPUT(5:2)  TO WS-DT-MONTH
    MOVE WS-FMT-INPUT(7:2)  TO WS-DT-DAY
    MOVE WS-FMT-OUTPUT(1:4) TO WS-DT-YEAR2
    MOVE WS-FMT-OUTPUT(5:2) TO WS-DT-MONTH2
    MOVE WS-FMT-OUTPUT(7:2) TO WS-DT-DAY2

    COMPUTE WS-TEMP-NUM =
        ((WS-DT-YEAR2 - WS-DT-YEAR) * 360)
        + ((WS-DT-MONTH2 - WS-DT-MONTH) * 30)
        + (WS-DT-DAY2 - WS-DT-DAY).

*> -------------------------------------------------------
*> FORMAT-CURRENCY: Format amount as $1,234.56
*> Input:  WS-FMT-AMT
*> Output: WS-FMT-OUTPUT
*> -------------------------------------------------------
FORMAT-CURRENCY.
    MOVE SPACES TO WS-FMT-OUTPUT
    IF WS-FMT-AMT < 0
        MOVE "-" TO WS-FMT-SIGN
        MULTIPLY -1 BY WS-FMT-AMT
    ELSE
        MOVE SPACE TO WS-FMT-SIGN
    END-IF

    MOVE WS-FMT-AMT TO WS-TEMP-NUM
    STRING WS-FMT-SIGN "$" WS-TEMP-NUM
        DELIMITED BY SIZE INTO WS-FMT-OUTPUT
    END-STRING.

*> -------------------------------------------------------
*> TO-UPPER: Convert string to uppercase
*> Input:  WS-TEMP-STR
*> Output: WS-TEMP-STR (modified in place)
*> -------------------------------------------------------
TO-UPPER.
    INSPECT WS-TEMP-STR
        CONVERTING "abcdefghijklmnopqrstuvwxyz"
        TO         "ABCDEFGHIJKLMNOPQRSTUVWXYZ".

*> -------------------------------------------------------
*> TRIM-STR: Trim leading/trailing spaces
*> Input:  WS-TEMP-STR
*> Output: WS-RESULT
*> -------------------------------------------------------
TRIM-STR.
    MOVE FUNCTION TRIM(WS-TEMP-STR) TO WS-RESULT.

*> -------------------------------------------------------
*> LEFT-PAD: Pad value on left with given character
*> Input:  WS-TEMP-STR = value, WS-I = target width,
*>         WS-CHAR = pad character
*> Output: WS-RESULT
*> -------------------------------------------------------
LEFT-PAD.
    MOVE SPACES TO WS-RESULT
    MOVE FUNCTION LENGTH(FUNCTION TRIM(WS-TEMP-STR))
        TO WS-LEN
    IF WS-LEN >= WS-I
        MOVE WS-TEMP-STR TO WS-RESULT
    ELSE
        COMPUTE WS-J = WS-I - WS-LEN
        PERFORM VARYING WS-FMT-POS FROM 1 BY 1
            UNTIL WS-FMT-POS > WS-J
            MOVE WS-CHAR TO WS-RESULT(WS-FMT-POS:1)
        END-PERFORM
        MOVE WS-TEMP-STR TO
            WS-RESULT(WS-J + 1:WS-LEN)
    END-IF.
