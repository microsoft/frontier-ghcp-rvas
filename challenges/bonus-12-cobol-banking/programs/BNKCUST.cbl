>>SOURCE FORMAT IS FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. BNKCUST.
*> Customer Management Module
*> CRUD operations, search, and customer-account summary

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT CUSTFILE ASSIGN TO "data/CUSTFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS CUST-ID
        ALTERNATE RECORD KEY IS CUST-SSN WITH DUPLICATES
        ALTERNATE RECORD KEY IS CUST-LAST-NAME
            WITH DUPLICATES
        FILE STATUS IS WS-FILE-STATUS.

    SELECT ACCTFILE ASSIGN TO "data/ACCTFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS ACCT-ID
        ALTERNATE RECORD KEY IS ACCT-CUST-ID
            WITH DUPLICATES
        FILE STATUS IS WS-ACCT-STATUS.

DATA DIVISION.
FILE SECTION.
FD  CUSTFILE.
    COPY "copybooks/CUSTFLD.cpy".

FD  ACCTFILE.
    COPY "copybooks/ACCTFLD.cpy".

WORKING-STORAGE SECTION.
01  WS-FILE-STATUS         PIC X(2).
01  WS-ACCT-STATUS         PIC X(2).
01  WS-EOF                 PIC 9(1) VALUE 0.
01  WS-OPTION              PIC X(1).
01  WS-INPUT               PIC X(80).
01  WS-CUST-SEQ            PIC 9(5) VALUE 10000.
01  WS-FOUND               PIC 9(1) VALUE 0.
01  WS-COUNT               PIC 9(5) VALUE 0.

*> Session (passed from main)
01  WS-BNKUSER             PIC X(20).
01  WS-BNKROLE             PIC X(10).

*> Input fields for registration
01  WS-REG.
    05  WS-REG-FIRST       PIC X(30).
    05  WS-REG-LAST        PIC X(30).
    05  WS-REG-DOB         PIC X(8).
    05  WS-REG-SSN         PIC X(11).
    05  WS-REG-ADDR1       PIC X(50).
    05  WS-REG-ADDR2       PIC X(50).
    05  WS-REG-CITY        PIC X(30).
    05  WS-REG-STATE       PIC X(2).
    05  WS-REG-ZIP         PIC X(10).
    05  WS-REG-PHONE       PIC X(15).
    05  WS-REG-EMAIL       PIC X(50).

01  WS-SEARCH-ID           PIC 9(5).
01  WS-SEARCH-SSN          PIC X(11).
01  WS-SEARCH-NAME         PIC X(30).
01  WS-TOTAL-BAL           PIC S9(13)V99 VALUE 0.
01  WS-MASKED-SSN          PIC X(11).
01  WS-AGE                 PIC 9(3).
01  WS-VALID               PIC 9(1).

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
*> CUST-MENU: Customer Management Menu
*> -------------------------------------------------------
CUST-MENU.
    DISPLAY " "
    DISPLAY "Customer Management"
    DISPLAY "==================="
    DISPLAY "1. Register New Customer"
    DISPLAY "2. Search Customer"
    DISPLAY "3. View Customer Details"
    DISPLAY "4. Update Customer"
    DISPLAY "5. Customer Account Summary"
    DISPLAY "B. Back"
    DISPLAY " "
    DISPLAY "Select: " WITH NO ADVANCING
    ACCEPT WS-OPTION

    EVALUATE WS-OPTION
        WHEN "1" PERFORM REGISTER-CUSTOMER
        WHEN "2" PERFORM SEARCH-CUSTOMER
        WHEN "3" PERFORM VIEW-CUSTOMER
        WHEN "4" PERFORM UPDATE-CUSTOMER
        WHEN "5" PERFORM ACCOUNT-SUMMARY
        WHEN "B" CONTINUE
        WHEN "b" CONTINUE
        WHEN OTHER DISPLAY "Invalid option."
    END-EVALUATE.

*> -------------------------------------------------------
*> REGISTER-CUSTOMER: Register a new customer
*> -------------------------------------------------------
REGISTER-CUSTOMER.
    DISPLAY " "
    DISPLAY "=== New Customer Registration ==="
    DISPLAY "First Name: " WITH NO ADVANCING
    ACCEPT WS-REG-FIRST
    IF WS-REG-FIRST = SPACES
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Last Name: " WITH NO ADVANCING
    ACCEPT WS-REG-LAST
    IF WS-REG-LAST = SPACES
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Date of Birth (YYYYMMDD): " WITH NO ADVANCING
    ACCEPT WS-REG-DOB
    PERFORM VALIDATE-DATE-INPUT
    IF WS-VALID = 0
        DISPLAY "Invalid date."
        EXIT PARAGRAPH
    END-IF

    PERFORM CHECK-ADULT
    IF WS-VALID = 0
        DISPLAY "Customer must be 18 or older."
        EXIT PARAGRAPH
    END-IF

    DISPLAY "SSN (XXX-XX-XXXX): " WITH NO ADVANCING
    ACCEPT WS-REG-SSN
    PERFORM VALIDATE-SSN
    IF WS-VALID = 0
        DISPLAY "Invalid SSN format."
        EXIT PARAGRAPH
    END-IF

    *> Duplicate SSN check
    OPEN INPUT CUSTFILE
    IF WS-FILE-STATUS = "00"
        MOVE WS-REG-SSN TO CUST-SSN
        START CUSTFILE KEY IS = CUST-SSN
            INVALID KEY CONTINUE
            NOT INVALID KEY
                READ CUSTFILE NEXT
                    AT END CONTINUE
                END-READ
                IF CUST-SSN = WS-REG-SSN
                    DISPLAY "A customer with this SSN "
                        "already exists."
                    DISPLAY "Existing Customer ID: "
                        CUST-ID
                    CLOSE CUSTFILE
                    EXIT PARAGRAPH
                END-IF
        END-START
        CLOSE CUSTFILE
    END-IF

    DISPLAY "Address Line 1: " WITH NO ADVANCING
    ACCEPT WS-REG-ADDR1
    IF WS-REG-ADDR1 = SPACES
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Address Line 2 (optional): " WITH NO ADVANCING
    ACCEPT WS-REG-ADDR2

    DISPLAY "City: " WITH NO ADVANCING
    ACCEPT WS-REG-CITY
    IF WS-REG-CITY = SPACES
        EXIT PARAGRAPH
    END-IF

    DISPLAY "State (2-letter): " WITH NO ADVANCING
    ACCEPT WS-REG-STATE
    IF FUNCTION LENGTH(FUNCTION TRIM(WS-REG-STATE))
        NOT = 2
        DISPLAY "Invalid state code."
        EXIT PARAGRAPH
    END-IF
    INSPECT WS-REG-STATE CONVERTING
        "abcdefghijklmnopqrstuvwxyz"
        TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    DISPLAY "ZIP Code: " WITH NO ADVANCING
    ACCEPT WS-REG-ZIP
    PERFORM VALIDATE-ZIP
    IF WS-VALID = 0
        DISPLAY "Invalid ZIP code."
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Phone: " WITH NO ADVANCING
    ACCEPT WS-REG-PHONE
    DISPLAY "Email: " WITH NO ADVANCING
    ACCEPT WS-REG-EMAIL

    *> Generate customer ID
    OPEN I-O CUSTFILE
    IF WS-FILE-STATUS NOT = "00"
        OPEN OUTPUT CUSTFILE
    END-IF

    *> Find next available ID
    MOVE 0 TO WS-EOF
    READ CUSTFILE LAST
        AT END MOVE 1 TO WS-EOF
    END-READ
    IF WS-EOF = 0
        MOVE CUST-ID TO WS-CUST-SEQ
    ELSE
        MOVE 10000 TO WS-CUST-SEQ
    END-IF
    ADD 1 TO WS-CUST-SEQ

    *> Build record
    MOVE WS-CUST-SEQ   TO CUST-ID
    INSPECT WS-REG-FIRST CONVERTING
        "abcdefghijklmnopqrstuvwxyz"
        TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    MOVE WS-REG-FIRST  TO CUST-FIRST-NAME
    INSPECT WS-REG-LAST CONVERTING
        "abcdefghijklmnopqrstuvwxyz"
        TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    MOVE WS-REG-LAST   TO CUST-LAST-NAME
    MOVE WS-REG-DOB    TO CUST-DOB
    MOVE WS-REG-SSN    TO CUST-SSN
    MOVE WS-REG-ADDR1  TO CUST-ADDR-LINE1
    MOVE WS-REG-ADDR2  TO CUST-ADDR-LINE2
    MOVE WS-REG-CITY   TO CUST-ADDR-CITY
    MOVE WS-REG-STATE  TO CUST-ADDR-STATE
    MOVE WS-REG-ZIP    TO CUST-ADDR-ZIP
    MOVE WS-REG-PHONE  TO CUST-PHONE
    MOVE WS-REG-EMAIL  TO CUST-EMAIL
    MOVE "ACTIVE"       TO CUST-STATUS
    PERFORM BUILD-DATETIME
    MOVE WS-DATETIME-STR TO CUST-CREATED
    MOVE "PENDING"      TO CUST-KYC

    WRITE CUST-REC
    IF WS-FILE-STATUS = "00"
        DISPLAY " "
        DISPLAY "Customer registered successfully."
        DISPLAY "Customer ID: " WS-CUST-SEQ
    ELSE
        DISPLAY "Error creating customer record."
    END-IF

    CLOSE CUSTFILE.

*> -------------------------------------------------------
*> SEARCH-CUSTOMER: Search for a customer
*> -------------------------------------------------------
SEARCH-CUSTOMER.
    DISPLAY " "
    DISPLAY "Search by:"
    DISPLAY "1. SSN"
    DISPLAY "2. Last Name"
    DISPLAY "3. Customer ID"
    DISPLAY "Select: " WITH NO ADVANCING
    ACCEPT WS-OPTION

    OPEN INPUT CUSTFILE
    IF WS-FILE-STATUS NOT = "00"
        DISPLAY "No customer data found."
        EXIT PARAGRAPH
    END-IF

    EVALUATE WS-OPTION
        WHEN "1" PERFORM SEARCH-BY-SSN
        WHEN "2" PERFORM SEARCH-BY-NAME
        WHEN "3" PERFORM SEARCH-BY-ID
        WHEN OTHER DISPLAY "Invalid search type."
    END-EVALUATE

    CLOSE CUSTFILE.

SEARCH-BY-SSN.
    DISPLAY "Enter SSN: " WITH NO ADVANCING
    ACCEPT WS-SEARCH-SSN
    IF WS-SEARCH-SSN = SPACES
        EXIT PARAGRAPH
    END-IF

    MOVE WS-SEARCH-SSN TO CUST-SSN
    START CUSTFILE KEY IS = CUST-SSN
        INVALID KEY
            DISPLAY "No customer found."
            EXIT PARAGRAPH
    END-START

    READ CUSTFILE NEXT
        AT END
            DISPLAY "No customer found."
            EXIT PARAGRAPH
    END-READ

    IF CUST-SSN = WS-SEARCH-SSN
        PERFORM DISPLAY-CUSTOMER
    ELSE
        DISPLAY "No customer found."
    END-IF.

SEARCH-BY-NAME.
    DISPLAY "Last Name: " WITH NO ADVANCING
    ACCEPT WS-SEARCH-NAME
    IF WS-SEARCH-NAME = SPACES
        EXIT PARAGRAPH
    END-IF
    INSPECT WS-SEARCH-NAME CONVERTING
        "abcdefghijklmnopqrstuvwxyz"
        TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    DISPLAY " "
    DISPLAY "ID    Name                     "
        "SSN          Status"
    DISPLAY "----- ------------------------ "
        "------------ ----------"

    MOVE 0 TO WS-COUNT
    MOVE 0 TO WS-EOF

    MOVE WS-SEARCH-NAME TO CUST-LAST-NAME
    START CUSTFILE KEY IS = CUST-LAST-NAME
        INVALID KEY MOVE 1 TO WS-EOF
    END-START

    PERFORM UNTIL WS-EOF = 1
        READ CUSTFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
        IF WS-EOF = 0
            IF CUST-LAST-NAME = WS-SEARCH-NAME
                ADD 1 TO WS-COUNT
                PERFORM MASK-SSN
                DISPLAY CUST-ID " "
                    CUST-FIRST-NAME(1:12) " "
                    CUST-LAST-NAME(1:12) " "
                    WS-MASKED-SSN " "
                    CUST-STATUS
            ELSE
                MOVE 1 TO WS-EOF
            END-IF
        END-IF
    END-PERFORM

    IF WS-COUNT = 0
        DISPLAY "No customers found with that name."
    END-IF.

SEARCH-BY-ID.
    DISPLAY "Customer ID: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF
    MOVE WS-INPUT TO WS-SEARCH-ID
    MOVE WS-SEARCH-ID TO CUST-ID

    READ CUSTFILE
        INVALID KEY
            DISPLAY "Customer not found."
            EXIT PARAGRAPH
    END-READ

    PERFORM DISPLAY-CUSTOMER.

*> -------------------------------------------------------
*> DISPLAY-CUSTOMER: Display full customer details
*> -------------------------------------------------------
DISPLAY-CUSTOMER.
    PERFORM MASK-SSN
    DISPLAY " "
    DISPLAY "=== Customer Details ==="
    DISPLAY "Customer ID:   " CUST-ID
    DISPLAY "Name:          "
        FUNCTION TRIM(CUST-FIRST-NAME) " "
        FUNCTION TRIM(CUST-LAST-NAME)
    DISPLAY "Date of Birth: "
        CUST-DOB(5:2) "/" CUST-DOB(7:2) "/"
        CUST-DOB(1:4)
    DISPLAY "SSN:           " WS-MASKED-SSN
    DISPLAY "Address:       "
        FUNCTION TRIM(CUST-ADDR-LINE1)
    IF CUST-ADDR-LINE2 NOT = SPACES
        DISPLAY "               "
            FUNCTION TRIM(CUST-ADDR-LINE2)
    END-IF
    DISPLAY "               "
        FUNCTION TRIM(CUST-ADDR-CITY) ", "
        CUST-ADDR-STATE " "
        FUNCTION TRIM(CUST-ADDR-ZIP)
    DISPLAY "Phone:         "
        FUNCTION TRIM(CUST-PHONE)
    DISPLAY "Email:         "
        FUNCTION TRIM(CUST-EMAIL)
    DISPLAY "Status:        "
        FUNCTION TRIM(CUST-STATUS)
    DISPLAY "KYC:           "
        FUNCTION TRIM(CUST-KYC)
    DISPLAY "Registered:    "
        FUNCTION TRIM(CUST-CREATED).

*> -------------------------------------------------------
*> VIEW-CUSTOMER: View customer by ID prompt
*> -------------------------------------------------------
VIEW-CUSTOMER.
    DISPLAY "Customer ID: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN INPUT CUSTFILE
    IF WS-FILE-STATUS NOT = "00"
        DISPLAY "No customer data found."
        EXIT PARAGRAPH
    END-IF

    MOVE WS-INPUT TO CUST-ID
    READ CUSTFILE
        INVALID KEY
            DISPLAY "Customer not found."
            CLOSE CUSTFILE
            EXIT PARAGRAPH
    END-READ

    PERFORM DISPLAY-CUSTOMER
    CLOSE CUSTFILE.

*> -------------------------------------------------------
*> UPDATE-CUSTOMER: Update customer fields
*> -------------------------------------------------------
UPDATE-CUSTOMER.
    DISPLAY "Customer ID: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN I-O CUSTFILE
    IF WS-FILE-STATUS NOT = "00"
        DISPLAY "No customer data."
        EXIT PARAGRAPH
    END-IF

    MOVE WS-INPUT TO CUST-ID
    READ CUSTFILE
        INVALID KEY
            DISPLAY "Customer not found."
            CLOSE CUSTFILE
            EXIT PARAGRAPH
    END-READ

    PERFORM DISPLAY-CUSTOMER

    DISPLAY " "
    DISPLAY "Update field:"
    DISPLAY "1. Phone"
    DISPLAY "2. Email"
    DISPLAY "3. Address"
    DISPLAY "4. KYC Status"
    DISPLAY "5. Account Status"
    DISPLAY "B. Cancel"
    DISPLAY "Select: " WITH NO ADVANCING
    ACCEPT WS-OPTION

    EVALUATE WS-OPTION
        WHEN "1"
            DISPLAY "New Phone: " WITH NO ADVANCING
            ACCEPT WS-INPUT
            IF WS-INPUT NOT = SPACES
                MOVE WS-INPUT TO CUST-PHONE
                REWRITE CUST-REC
                DISPLAY "Updated."
            END-IF
        WHEN "2"
            DISPLAY "New Email: " WITH NO ADVANCING
            ACCEPT WS-INPUT
            IF WS-INPUT NOT = SPACES
                MOVE WS-INPUT TO CUST-EMAIL
                REWRITE CUST-REC
                DISPLAY "Updated."
            END-IF
        WHEN "3"
            DISPLAY "Address Line 1: " WITH NO ADVANCING
            ACCEPT WS-REG-ADDR1
            DISPLAY "Address Line 2: " WITH NO ADVANCING
            ACCEPT WS-REG-ADDR2
            DISPLAY "City: " WITH NO ADVANCING
            ACCEPT WS-REG-CITY
            DISPLAY "State: " WITH NO ADVANCING
            ACCEPT WS-REG-STATE
            DISPLAY "ZIP: " WITH NO ADVANCING
            ACCEPT WS-REG-ZIP
            PERFORM VALIDATE-ZIP
            IF WS-VALID = 0
                DISPLAY "Invalid ZIP."
            ELSE
                MOVE WS-REG-ADDR1 TO CUST-ADDR-LINE1
                MOVE WS-REG-ADDR2 TO CUST-ADDR-LINE2
                MOVE WS-REG-CITY  TO CUST-ADDR-CITY
                INSPECT WS-REG-STATE CONVERTING
                    "abcdefghijklmnopqrstuvwxyz"
                    TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                MOVE WS-REG-STATE TO CUST-ADDR-STATE
                MOVE WS-REG-ZIP   TO CUST-ADDR-ZIP
                REWRITE CUST-REC
                DISPLAY "Updated."
            END-IF
        WHEN "4"
            DISPLAY "KYC Status (PENDING/VERIFIED/"
                "REJECTED): " WITH NO ADVANCING
            ACCEPT WS-INPUT
            IF WS-INPUT = "PENDING"
                OR WS-INPUT = "VERIFIED"
                OR WS-INPUT = "REJECTED"
                MOVE WS-INPUT TO CUST-KYC
                REWRITE CUST-REC
                DISPLAY "Updated."
            ELSE
                DISPLAY "Invalid."
            END-IF
        WHEN "5"
            IF WS-BNKROLE NOT = "ADMIN"
                DISPLAY "Only admins can change "
                    "account status."
            ELSE
                DISPLAY "Status (ACTIVE/SUSPENDED/"
                    "CLOSED): " WITH NO ADVANCING
                ACCEPT WS-INPUT
                IF WS-INPUT = "ACTIVE"
                    OR WS-INPUT = "SUSPENDED"
                    OR WS-INPUT = "CLOSED"
                    MOVE WS-INPUT TO CUST-STATUS
                    REWRITE CUST-REC
                    DISPLAY "Updated."
                ELSE
                    DISPLAY "Invalid."
                END-IF
            END-IF
        WHEN "B" CONTINUE
        WHEN "b" CONTINUE
        WHEN OTHER DISPLAY "Invalid option."
    END-EVALUATE

    CLOSE CUSTFILE.

*> -------------------------------------------------------
*> ACCOUNT-SUMMARY: Show all accounts for a customer
*> -------------------------------------------------------
ACCOUNT-SUMMARY.
    DISPLAY "Customer ID: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN INPUT CUSTFILE
    IF WS-FILE-STATUS NOT = "00"
        DISPLAY "No customer data."
        EXIT PARAGRAPH
    END-IF

    MOVE WS-INPUT TO CUST-ID
    READ CUSTFILE
        INVALID KEY
            DISPLAY "Customer not found."
            CLOSE CUSTFILE
            EXIT PARAGRAPH
    END-READ

    DISPLAY " "
    DISPLAY "=== Account Summary ==="
    DISPLAY "Customer: "
        FUNCTION TRIM(CUST-FIRST-NAME) " "
        FUNCTION TRIM(CUST-LAST-NAME)
    DISPLAY "ID: " CUST-ID "   Status: "
        FUNCTION TRIM(CUST-STATUS)

    CLOSE CUSTFILE

    OPEN INPUT ACCTFILE
    IF WS-ACCT-STATUS NOT = "00"
        DISPLAY "No account data."
        EXIT PARAGRAPH
    END-IF

    DISPLAY " "
    DISPLAY "Acct #  Type       Balance         "
        "Status     Opened"
    DISPLAY "------  ---------  --------------- "
        "---------- -------------------"

    MOVE 0 TO WS-TOTAL-BAL
    MOVE WS-INPUT TO ACCT-CUST-ID
    START ACCTFILE KEY IS = ACCT-CUST-ID
        INVALID KEY
            DISPLAY "(no accounts)"
            CLOSE ACCTFILE
            EXIT PARAGRAPH
    END-START

    MOVE 0 TO WS-EOF
    PERFORM UNTIL WS-EOF = 1
        READ ACCTFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
        IF WS-EOF = 0
            IF ACCT-CUST-ID = WS-INPUT
                ADD ACCT-BAL TO WS-TOTAL-BAL
                DISPLAY ACCT-ID "  "
                    ACCT-TYPE "        "
                    ACCT-BAL "  "
                    ACCT-STATUS " "
                    ACCT-OPENED
            ELSE
                MOVE 1 TO WS-EOF
            END-IF
        END-IF
    END-PERFORM

    DISPLAY " "
    DISPLAY "Total Deposits: " WS-TOTAL-BAL

    CLOSE ACCTFILE.

*> -------------------------------------------------------
*> MASK-SSN: Mask SSN for display (***-**-XXXX)
*> -------------------------------------------------------
MASK-SSN.
    IF FUNCTION LENGTH(FUNCTION TRIM(CUST-SSN)) < 4
        MOVE "***-**-****" TO WS-MASKED-SSN
    ELSE
        STRING "***-**-" CUST-SSN(8:4)
            DELIMITED BY SIZE INTO WS-MASKED-SSN
        END-STRING
    END-IF.

*> -------------------------------------------------------
*> CHECK-ADULT: Verify customer is 18+
*> Input: WS-REG-DOB, Output: WS-VALID
*> -------------------------------------------------------
CHECK-ADULT.
    MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DT
    COMPUTE WS-AGE =
        WS-NOW-YEAR - FUNCTION NUMVAL(WS-REG-DOB(1:4))
    IF WS-NOW-MONTH < FUNCTION NUMVAL(WS-REG-DOB(5:2))
        OR (WS-NOW-MONTH = FUNCTION NUMVAL(WS-REG-DOB(5:2))
            AND WS-NOW-DAY <
                FUNCTION NUMVAL(WS-REG-DOB(7:2)))
        SUBTRACT 1 FROM WS-AGE
    END-IF
    IF WS-AGE >= 18
        MOVE 1 TO WS-VALID
    ELSE
        MOVE 0 TO WS-VALID
    END-IF.

*> -------------------------------------------------------
*> VALIDATE-SSN: Validate SSN format XXX-XX-XXXX
*> -------------------------------------------------------
VALIDATE-SSN.
    MOVE 1 TO WS-VALID
    IF FUNCTION LENGTH(FUNCTION TRIM(WS-REG-SSN))
        NOT = 11
        MOVE 0 TO WS-VALID
        EXIT PARAGRAPH
    END-IF
    IF WS-REG-SSN(4:1) NOT = "-"
        OR WS-REG-SSN(7:1) NOT = "-"
        MOVE 0 TO WS-VALID
        EXIT PARAGRAPH
    END-IF
    IF WS-REG-SSN(1:3) IS NOT NUMERIC
        OR WS-REG-SSN(5:2) IS NOT NUMERIC
        OR WS-REG-SSN(8:4) IS NOT NUMERIC
        MOVE 0 TO WS-VALID
    END-IF.

*> -------------------------------------------------------
*> VALIDATE-ZIP: Validate US ZIP code
*> -------------------------------------------------------
VALIDATE-ZIP.
    MOVE 0 TO WS-VALID
    IF WS-REG-ZIP(1:5) IS NUMERIC
        IF FUNCTION LENGTH(FUNCTION TRIM(WS-REG-ZIP)) = 5
            MOVE 1 TO WS-VALID
        ELSE
            IF WS-REG-ZIP(6:1) = "-"
                AND WS-REG-ZIP(7:4) IS NUMERIC
                MOVE 1 TO WS-VALID
            END-IF
        END-IF
    END-IF.

*> -------------------------------------------------------
*> VALIDATE-DATE-INPUT: Basic date validation
*> -------------------------------------------------------
VALIDATE-DATE-INPUT.
    MOVE 1 TO WS-VALID
    IF WS-REG-DOB IS NOT NUMERIC
        MOVE 0 TO WS-VALID
        EXIT PARAGRAPH
    END-IF
    IF FUNCTION LENGTH(FUNCTION TRIM(WS-REG-DOB)) NOT = 8
        MOVE 0 TO WS-VALID
        EXIT PARAGRAPH
    END-IF
    IF FUNCTION NUMVAL(WS-REG-DOB(5:2)) < 1
        OR FUNCTION NUMVAL(WS-REG-DOB(5:2)) > 12
        MOVE 0 TO WS-VALID
    END-IF
    IF FUNCTION NUMVAL(WS-REG-DOB(7:2)) < 1
        OR FUNCTION NUMVAL(WS-REG-DOB(7:2)) > 31
        MOVE 0 TO WS-VALID
    END-IF.

*> -------------------------------------------------------
*> ACCT-TYPE-NAME: Map type code to readable name
*> -------------------------------------------------------
ACCT-TYPE-NAME.
    EVALUATE ACCT-TYPE
        WHEN "SAV" MOVE "Savings" TO WS-INPUT
        WHEN "CHK" MOVE "Checking" TO WS-INPUT
        WHEN "FD"  MOVE "Fixed Dep" TO WS-INPUT
        WHEN "GOLD" MOVE "Gold Savings" TO WS-INPUT
            *> discontinued 2014, code path retained
        WHEN OTHER MOVE ACCT-TYPE TO WS-INPUT
    END-EVALUATE.

*> -------------------------------------------------------
*> BUILD-DATETIME
*> -------------------------------------------------------
BUILD-DATETIME.
    MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DT
    STRING WS-NOW-YEAR WS-NOW-MONTH WS-NOW-DAY
        " "
        WS-NOW-HOUR ":" WS-NOW-MIN ":" WS-NOW-SEC
        DELIMITED BY SIZE INTO WS-DATETIME-STR
    END-STRING.
