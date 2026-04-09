-- seed data for Acme Bank demo environment

INSERT INTO CUSTOMERS (FIRST_NAME, LAST_NAME, EMAIL, PHONE, ADDRESS, CUST_TIER) VALUES
('Alice', 'Morgan', 'alice.morgan@example.com', '555-0101', '42 Oak Street, Springfield', 'GOLD'),
('Bob', 'Chen', 'bob.chen@example.com', '555-0102', '18 Pine Avenue, Riverside', 'STANDARD'),
('Carol', 'Santos', 'carol.santos@example.com', '555-0103', '7 Elm Drive, Lakewood', 'PLATINUM'),
('David', 'Kim', 'david.kim@example.com', '555-0104', '231 Maple Road, Brookside', 'STANDARD'),
('Eva', 'Nowak', 'eva.nowak@example.com', '555-0105', '95 Cedar Lane, Hilltop', 'GOLD');

INSERT INTO ACCOUNTS (ACCT_NUM, CUST_ID, ACCT_TYPE, BALANCE, INT_RATE, STATUS) VALUES
('ACB-100001', 1, 'CHK', 12500.00, 0.0000, 'ACTIVE'),
('ACB-100002', 1, 'SAV', 75000.00, 0.0350, 'ACTIVE'),
('ACB-100003', 2, 'CHK', 3200.00, 0.0000, 'ACTIVE'),
('ACB-100004', 2, 'SAV', 15000.00, 0.0250, 'ACTIVE'),
('ACB-100005', 3, 'CHK', 45000.00, 0.0000, 'ACTIVE'),
('ACB-100006', 3, 'SAV', 320000.00, 0.0450, 'ACTIVE'),
('ACB-100007', 3, 'SAV', 50000.00, 0.0350, 'CLOSED'),
('ACB-100008', 4, 'CHK', 890.00, 0.0000, 'ACTIVE'),
('ACB-100009', 5, 'CHK', 22000.00, 0.0000, 'ACTIVE'),
('ACB-100010', 5, 'SAV', 68000.00, 0.0350, 'ACTIVE');

INSERT INTO TXNLOG (ACCT_NUM, TXN_TYPE, AMOUNT, BAL_AFTER, DESCRIPTION) VALUES
('ACB-100001', 'DEP', 5000.00, 12500.00, 'Payroll deposit'),
('ACB-100002', 'INT', 218.75, 75000.00, 'Monthly interest at 3.5%'),
('ACB-100003', 'WDR', 800.00, 3200.00, 'ATM withdrawal'),
('ACB-100005', 'XFER_OUT', 10000.00, 45000.00, 'Transfer to ACB-100006'),
('ACB-100006', 'XFER_IN', 10000.00, 320000.00, 'Transfer from ACB-100005');
