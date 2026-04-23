>>SOURCE FORMAT IS FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. BNKAUTH.
*> Authentication and User Management
*> Login, password hashing, role verification, user CRUD

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT USERFILE ASSIGN TO "data/USERFILE.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS USER-ID
        FILE STATUS IS WS-FILE-STATUS.

DATA DIVISION.
FILE SECTION.
FD  USERFILE.
    COPY "copybooks/USERFLD.cpy".

WORKING-STORAGE SECTION.
01  WS-FILE-STATUS         PIC X(2).
01  WS-EOF                 PIC 9(1) VALUE 0.
01  WS-INPUT-UID           PIC X(20).
01  WS-INPUT-PWD           PIC X(50).
01  WS-COMPUTED-HASH       PIC 9(18).
01  WS-TRIES               PIC 9(1) VALUE 0.
01  WS-OPTION              PIC X(1).
01  WS-INPUT               PIC X(80).

*> Session variables - shared across modules
01  WS-SESSION.
    05  WS-BNKUSER         PIC X(20).
    05  WS-BNKUSNM         PIC X(40).
    05  WS-BNKROLE         PIC X(10).
    05  WS-LOGGED-IN       PIC 9(1) VALUE 0.

*> Password hashing work fields
01  WS-HASH-FIELDS.
    05  WS-HASH-VAL        PIC 9(18) VALUE 0.
    05  WS-HASH-CHAR       PIC 9(3).
    05  WS-HASH-I          PIC 9(3).
    05  WS-HASH-LEN        PIC 9(3).
    05  WS-HASH-TEMP       PIC 9(18).

*> New user fields
01  WS-NEW-USER.
    05  WS-NEW-UID         PIC X(20).
    05  WS-NEW-NAME        PIC X(40).
    05  WS-NEW-ROLE        PIC X(10).
    05  WS-NEW-PWD         PIC X(50).
    05  WS-CONFIRM-PWD     PIC X(50).

01  WS-DATETIME-STR        PIC X(19).
01  WS-CURRENT-DT.
    05  WS-NOW-YEAR        PIC 9(4).
    05  WS-NOW-MONTH       PIC 9(2).
    05  WS-NOW-DAY         PIC 9(2).
    05  WS-NOW-HOUR        PIC 9(2).
    05  WS-NOW-MIN         PIC 9(2).
    05  WS-NOW-SEC         PIC 9(2).
    05  WS-NOW-HSEC        PIC 9(2).

*> Audit bridge fields
01  WS-AUDIT-USER          PIC X(20).
01  WS-AUDIT-ACTION        PIC X(15).
01  WS-AUDIT-DETAIL        PIC X(200).

PROCEDURE DIVISION.
MAIN-PARA.
    STOP RUN.

*> -------------------------------------------------------
*> LOGIN: Login procedure
*> Sets WS-BNKUSER, WS-BNKUSNM, WS-BNKROLE
*> -------------------------------------------------------
LOGIN.
    MOVE SPACES TO WS-BNKUSER
    MOVE SPACES TO WS-BNKUSNM
    MOVE SPACES TO WS-BNKROLE
    MOVE 0 TO WS-LOGGED-IN
    MOVE 0 TO WS-TRIES

    OPEN INPUT USERFILE
    IF WS-FILE-STATUS NOT = "00"
        DISPLAY "User database not found. Run BNKINIT first."
        EXIT PARAGRAPH
    END-IF

    PERFORM LOGIN-ATTEMPT UNTIL WS-LOGGED-IN = 1
        OR WS-TRIES >= 3

    CLOSE USERFILE.

LOGIN-ATTEMPT.
    DISPLAY " "
    DISPLAY "=== First National Bank - Login ==="
    DISPLAY "User ID: " WITH NO ADVANCING
    ACCEPT WS-INPUT-UID
    IF WS-INPUT-UID = SPACES
        MOVE 3 TO WS-TRIES
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Password: " WITH NO ADVANCING
    ACCEPT WS-INPUT-PWD

    *> Compute hash of entered password
    PERFORM HASH-PASSWORD

    *> Look up user
    MOVE WS-INPUT-UID TO USER-ID
    READ USERFILE
        INVALID KEY
            ADD 1 TO WS-TRIES
            DISPLAY "Invalid credentials. Attempt "
                WS-TRIES " of 3."
            MOVE "UNKNOWN" TO WS-AUDIT-USER
            MOVE "LOGINFAIL" TO WS-AUDIT-ACTION
            STRING "Failed login attempt for: "
                FUNCTION TRIM(WS-INPUT-UID)
                DELIMITED BY SIZE
                INTO WS-AUDIT-DETAIL
            END-STRING
            PERFORM WRITE-AUDIT
            EXIT PARAGRAPH
    END-READ

    IF USER-HASH NOT = WS-COMPUTED-HASH
        ADD 1 TO WS-TRIES
        DISPLAY "Invalid credentials. Attempt "
            WS-TRIES " of 3."
        MOVE WS-INPUT-UID TO WS-AUDIT-USER
        MOVE "LOGINFAIL" TO WS-AUDIT-ACTION
        STRING "Bad password for: "
            FUNCTION TRIM(WS-INPUT-UID)
            DELIMITED BY SIZE INTO WS-AUDIT-DETAIL
        END-STRING
        PERFORM WRITE-AUDIT
        EXIT PARAGRAPH
    END-IF

    IF USER-STATUS NOT = "ACTIVE"
        DISPLAY "Account is locked. Contact administrator."
        MOVE WS-INPUT-UID TO WS-AUDIT-USER
        MOVE "LOGINFAIL" TO WS-AUDIT-ACTION
        STRING "Disabled account attempt: "
            FUNCTION TRIM(WS-INPUT-UID)
            DELIMITED BY SIZE INTO WS-AUDIT-DETAIL
        END-STRING
        PERFORM WRITE-AUDIT
        MOVE 3 TO WS-TRIES
        EXIT PARAGRAPH
    END-IF

    *> Login successful
    MOVE USER-ID   TO WS-BNKUSER
    MOVE USER-NAME TO WS-BNKUSNM
    MOVE USER-ROLE TO WS-BNKROLE
    MOVE 1 TO WS-LOGGED-IN

    *> Update last login
    CLOSE USERFILE
    OPEN I-O USERFILE
    MOVE WS-INPUT-UID TO USER-ID
    READ USERFILE
        INVALID KEY CONTINUE
    END-READ
    PERFORM BUILD-DATETIME
    MOVE WS-DATETIME-STR TO USER-LAST-LOGIN
    REWRITE USER-REC
    CLOSE USERFILE
    OPEN INPUT USERFILE

    MOVE WS-BNKUSER TO WS-AUDIT-USER
    MOVE "LOGIN" TO WS-AUDIT-ACTION
    MOVE "Successful login" TO WS-AUDIT-DETAIL
    PERFORM WRITE-AUDIT.

*> -------------------------------------------------------
*> LOGOUT: Logout current user
*> -------------------------------------------------------
LOGOUT.
    MOVE WS-BNKUSER TO WS-AUDIT-USER
    MOVE "LOGOUT" TO WS-AUDIT-ACTION
    MOVE "User logged out" TO WS-AUDIT-DETAIL
    PERFORM WRITE-AUDIT
    DISPLAY "Goodbye, " FUNCTION TRIM(WS-BNKUSNM) "."
    MOVE SPACES TO WS-BNKUSER
    MOVE SPACES TO WS-BNKUSNM
    MOVE SPACES TO WS-BNKROLE
    MOVE 0 TO WS-LOGGED-IN.

*> -------------------------------------------------------
*> HASH-PASSWORD: djb2 hash variant
*> WARNING: NOT cryptographically secure
*> Production should use bcrypt or similar
*> Kept for backward compatibility (ticket #4491, 2012)
*> Input:  WS-INPUT-PWD
*> Output: WS-COMPUTED-HASH
*> -------------------------------------------------------
HASH-PASSWORD.
    MOVE 5381 TO WS-HASH-VAL
    MOVE FUNCTION LENGTH(FUNCTION TRIM(WS-INPUT-PWD))
        TO WS-HASH-LEN

    PERFORM VARYING WS-HASH-I FROM 1 BY 1
        UNTIL WS-HASH-I > WS-HASH-LEN
        MOVE FUNCTION ORD(WS-INPUT-PWD(WS-HASH-I:1))
            TO WS-HASH-CHAR
        SUBTRACT 1 FROM WS-HASH-CHAR
        COMPUTE WS-HASH-VAL =
            FUNCTION MOD(
                (WS-HASH-VAL * 33) + WS-HASH-CHAR,
                1000000007)
    END-PERFORM

    MOVE WS-HASH-VAL TO WS-COMPUTED-HASH.

*> -------------------------------------------------------
*> IS-ADMIN: Check if current user is ADMIN
*> Output: WS-OPTION = "Y" or "N"
*> -------------------------------------------------------
IS-ADMIN.
    IF WS-BNKROLE = "ADMIN"
        MOVE "Y" TO WS-OPTION
    ELSE
        MOVE "N" TO WS-OPTION
    END-IF.

*> -------------------------------------------------------
*> IS-TELLER: Check if user is TELLER or ADMIN
*> Output: WS-OPTION = "Y" or "N"
*> -------------------------------------------------------
IS-TELLER.
    IF WS-BNKROLE = "TELLER" OR WS-BNKROLE = "ADMIN"
        MOVE "Y" TO WS-OPTION
    ELSE
        MOVE "N" TO WS-OPTION
    END-IF.

*> -------------------------------------------------------
*> IS-AUDITOR: Check if user is AUDITOR or ADMIN
*> Output: WS-OPTION = "Y" or "N"
*> -------------------------------------------------------
IS-AUDITOR.
    IF WS-BNKROLE = "AUDITOR" OR WS-BNKROLE = "ADMIN"
        MOVE "Y" TO WS-OPTION
    ELSE
        MOVE "N" TO WS-OPTION
    END-IF.

*> -------------------------------------------------------
*> CHANGE-PASSWORD: Change own password
*> -------------------------------------------------------
CHANGE-PASSWORD.
    DISPLAY "Current password: " WITH NO ADVANCING
    ACCEPT WS-INPUT-PWD
    PERFORM HASH-PASSWORD

    OPEN INPUT USERFILE
    MOVE WS-BNKUSER TO USER-ID
    READ USERFILE
        INVALID KEY
            DISPLAY "User record not found."
            CLOSE USERFILE
            EXIT PARAGRAPH
    END-READ
    CLOSE USERFILE

    IF USER-HASH NOT = WS-COMPUTED-HASH
        DISPLAY "Incorrect password."
        EXIT PARAGRAPH
    END-IF

    DISPLAY "New password: " WITH NO ADVANCING
    ACCEPT WS-NEW-PWD
    IF FUNCTION LENGTH(FUNCTION TRIM(WS-NEW-PWD)) < 6
        DISPLAY "Password must be at least 6 characters."
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Confirm new password: " WITH NO ADVANCING
    ACCEPT WS-CONFIRM-PWD
    IF WS-NEW-PWD NOT = WS-CONFIRM-PWD
        DISPLAY "Passwords do not match."
        EXIT PARAGRAPH
    END-IF

    MOVE WS-NEW-PWD TO WS-INPUT-PWD
    PERFORM HASH-PASSWORD

    OPEN I-O USERFILE
    MOVE WS-BNKUSER TO USER-ID
    READ USERFILE
        INVALID KEY
            DISPLAY "Error reading user."
            CLOSE USERFILE
            EXIT PARAGRAPH
    END-READ
    MOVE WS-COMPUTED-HASH TO USER-HASH
    REWRITE USER-REC
    CLOSE USERFILE

    MOVE WS-BNKUSER TO WS-AUDIT-USER
    MOVE "PWDCHG" TO WS-AUDIT-ACTION
    MOVE "Password changed" TO WS-AUDIT-DETAIL
    PERFORM WRITE-AUDIT
    DISPLAY "Password updated.".

*> -------------------------------------------------------
*> USER-MANAGEMENT: User management submenu
*> -------------------------------------------------------
USER-MANAGEMENT.
    DISPLAY " "
    DISPLAY "User Management"
    DISPLAY "==============="
    DISPLAY "1. List Users"
    DISPLAY "2. Add User"
    DISPLAY "3. Disable User"
    DISPLAY "4. Reset Password"
    DISPLAY "5. Change My Password"
    DISPLAY "B. Back"
    DISPLAY " "
    DISPLAY "Select: " WITH NO ADVANCING
    ACCEPT WS-OPTION

    EVALUATE WS-OPTION
        WHEN "1" PERFORM LIST-USERS
        WHEN "2" PERFORM ADD-USER
        WHEN "3" PERFORM DISABLE-USER
        WHEN "4" PERFORM RESET-PASSWORD
        WHEN "5" PERFORM CHANGE-PASSWORD
        WHEN "B" CONTINUE
        WHEN "b" CONTINUE
        WHEN OTHER DISPLAY "Invalid option."
    END-EVALUATE.

*> -------------------------------------------------------
*> LIST-USERS: List all users
*> -------------------------------------------------------
LIST-USERS.
    OPEN INPUT USERFILE
    IF WS-FILE-STATUS NOT = "00"
        DISPLAY "No user data."
        EXIT PARAGRAPH
    END-IF

    DISPLAY " "
    DISPLAY "User ID              Name"
        "                     Role       Status"
        "     Last Login"
    DISPLAY "-------------------- "
        "-------------------- ---------- ----------"
        " -------------------"

    MOVE 0 TO WS-EOF
    READ USERFILE FIRST
        AT END MOVE 1 TO WS-EOF
    END-READ

    PERFORM UNTIL WS-EOF = 1
        DISPLAY USER-ID " "
            USER-NAME(1:20) " "
            USER-ROLE " "
            USER-STATUS " "
            USER-LAST-LOGIN
        READ USERFILE NEXT
            AT END MOVE 1 TO WS-EOF
        END-READ
    END-PERFORM

    CLOSE USERFILE.

*> -------------------------------------------------------
*> ADD-USER: Add new user (admin only)
*> -------------------------------------------------------
ADD-USER.
    DISPLAY "New User ID: " WITH NO ADVANCING
    ACCEPT WS-NEW-UID
    IF WS-NEW-UID = SPACES
        EXIT PARAGRAPH
    END-IF

    *> Check if already exists
    OPEN INPUT USERFILE
    MOVE WS-NEW-UID TO USER-ID
    READ USERFILE
        INVALID KEY CONTINUE
        NOT INVALID KEY
            DISPLAY "User ID already exists."
            CLOSE USERFILE
            EXIT PARAGRAPH
    END-READ
    CLOSE USERFILE

    DISPLAY "Full Name: " WITH NO ADVANCING
    ACCEPT WS-NEW-NAME
    IF WS-NEW-NAME = SPACES
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Role (ADMIN/TELLER/AUDITOR): "
        WITH NO ADVANCING
    ACCEPT WS-NEW-ROLE
    IF WS-NEW-ROLE NOT = "ADMIN"
        AND WS-NEW-ROLE NOT = "TELLER"
        AND WS-NEW-ROLE NOT = "AUDITOR"
        DISPLAY "Invalid role."
        EXIT PARAGRAPH
    END-IF

    DISPLAY "Initial Password: " WITH NO ADVANCING
    ACCEPT WS-NEW-PWD
    IF FUNCTION LENGTH(FUNCTION TRIM(WS-NEW-PWD)) < 6
        DISPLAY "Password must be at least 6 characters."
        EXIT PARAGRAPH
    END-IF

    MOVE WS-NEW-PWD TO WS-INPUT-PWD
    PERFORM HASH-PASSWORD

    OPEN I-O USERFILE
    IF WS-FILE-STATUS NOT = "00"
        OPEN OUTPUT USERFILE
    END-IF

    MOVE WS-NEW-UID      TO USER-ID
    MOVE WS-NEW-NAME     TO USER-NAME
    MOVE WS-COMPUTED-HASH TO USER-HASH
    MOVE WS-NEW-ROLE     TO USER-ROLE
    MOVE "ACTIVE"         TO USER-STATUS
    PERFORM BUILD-DATETIME
    MOVE WS-DATETIME-STR TO USER-CREATED
    MOVE SPACES          TO USER-LAST-LOGIN

    WRITE USER-REC
    IF WS-FILE-STATUS = "00"
        DISPLAY "User " FUNCTION TRIM(WS-NEW-UID)
            " created successfully."
        MOVE WS-BNKUSER TO WS-AUDIT-USER
        MOVE "ADDUSER" TO WS-AUDIT-ACTION
        STRING "Created user: "
            FUNCTION TRIM(WS-NEW-UID) " role: "
            FUNCTION TRIM(WS-NEW-ROLE)
            DELIMITED BY SIZE INTO WS-AUDIT-DETAIL
        END-STRING
        PERFORM WRITE-AUDIT
    ELSE
        DISPLAY "Error creating user."
    END-IF

    CLOSE USERFILE.

*> -------------------------------------------------------
*> DISABLE-USER: Disable a user account
*> -------------------------------------------------------
DISABLE-USER.
    DISPLAY "User ID to disable: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN I-O USERFILE
    MOVE WS-INPUT TO USER-ID
    READ USERFILE
        INVALID KEY
            DISPLAY "User not found."
            CLOSE USERFILE
            EXIT PARAGRAPH
    END-READ

    IF USER-ID = WS-BNKUSER
        DISPLAY "Cannot disable your own account."
        CLOSE USERFILE
        EXIT PARAGRAPH
    END-IF

    MOVE "DISABLED" TO USER-STATUS
    REWRITE USER-REC

    MOVE WS-BNKUSER TO WS-AUDIT-USER
    MOVE "DISUSR" TO WS-AUDIT-ACTION
    STRING "Disabled user: " FUNCTION TRIM(WS-INPUT)
        DELIMITED BY SIZE INTO WS-AUDIT-DETAIL
    END-STRING
    PERFORM WRITE-AUDIT

    DISPLAY "User " FUNCTION TRIM(WS-INPUT)
        " has been disabled."
    CLOSE USERFILE.

*> -------------------------------------------------------
*> RESET-PASSWORD: Reset another user's password
*> -------------------------------------------------------
RESET-PASSWORD.
    DISPLAY "User ID: " WITH NO ADVANCING
    ACCEPT WS-INPUT
    IF WS-INPUT = SPACES
        EXIT PARAGRAPH
    END-IF

    OPEN I-O USERFILE
    MOVE WS-INPUT TO USER-ID
    READ USERFILE
        INVALID KEY
            DISPLAY "User not found."
            CLOSE USERFILE
            EXIT PARAGRAPH
    END-READ

    DISPLAY "New password: " WITH NO ADVANCING
    ACCEPT WS-NEW-PWD
    IF FUNCTION LENGTH(FUNCTION TRIM(WS-NEW-PWD)) < 6
        DISPLAY "Minimum 6 characters."
        CLOSE USERFILE
        EXIT PARAGRAPH
    END-IF

    MOVE WS-NEW-PWD TO WS-INPUT-PWD
    PERFORM HASH-PASSWORD
    MOVE WS-COMPUTED-HASH TO USER-HASH

    *> Reactivate if disabled
    IF USER-STATUS = "DISABLED"
        MOVE "ACTIVE" TO USER-STATUS
    END-IF

    REWRITE USER-REC

    MOVE WS-BNKUSER TO WS-AUDIT-USER
    MOVE "RSTPWD" TO WS-AUDIT-ACTION
    STRING "Reset password for: "
        FUNCTION TRIM(WS-INPUT)
        DELIMITED BY SIZE INTO WS-AUDIT-DETAIL
    END-STRING
    PERFORM WRITE-AUDIT

    DISPLAY "Password reset for "
        FUNCTION TRIM(WS-INPUT) "."
    CLOSE USERFILE.

*> -------------------------------------------------------
*> BUILD-DATETIME: Create datetime string
*> -------------------------------------------------------
BUILD-DATETIME.
    MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DT
    STRING WS-NOW-YEAR WS-NOW-MONTH WS-NOW-DAY
        " "
        WS-NOW-HOUR ":" WS-NOW-MIN ":" WS-NOW-SEC
        DELIMITED BY SIZE INTO WS-DATETIME-STR
    END-STRING.

*> -------------------------------------------------------
*> WRITE-AUDIT: Bridge to audit module
*> -------------------------------------------------------
WRITE-AUDIT.
    CONTINUE.
    *> In integrated build, this calls BNKAUDT LOG-ENTRY
    *> For now, display to console as fallback
    *> CALL "BNKAUDT" USING WS-AUDIT-USER
    *>     WS-AUDIT-ACTION WS-AUDIT-DETAIL
