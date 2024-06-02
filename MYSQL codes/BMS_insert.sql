-- Inserting more records
INSERT INTO Customer_Info (Cust_ID, Name, DOB, Gender, Branch_Code) VALUES
(100007, 'Amita Sharma', '1993-11-12', 'F', 1001),
(100008, 'Sanjay Verma', '1980-06-25', 'M', 1002),
(100009, 'Anjali Singh', '1991-03-18', 'F', 1003),
(100010, 'Karan Gupta', '1987-09-30', 'M', 1004),
(100011, 'Shreya Kumar', '1996-04-07', 'F', 1005);

INSERT INTO Customer_Contact (Cust_ID, Contact) VALUES
(100007, '9876543216'),
(100008, '9876543217'),
(100009, '9876543218'),
(100010, '9876543219'),
(100011, '9876543220');

-- Age calculation for new customers
INSERT INTO Age_Info (Cust_ID, DOB, Age) VALUES
(100007, '1993-11-12', TIMESTAMPDIFF(YEAR, '1993-11-12', CURDATE())),
(100008, '1980-06-25', TIMESTAMPDIFF(YEAR, '1980-06-25', CURDATE())),
(100009, '1991-03-18', TIMESTAMPDIFF(YEAR, '1991-03-18', CURDATE())),
(100010, '1987-09-30', TIMESTAMPDIFF(YEAR, '1987-09-30', CURDATE())),
(100011, '1996-04-07', TIMESTAMPDIFF(YEAR, '1996-04-07', CURDATE()));

INSERT INTO Address_Info (Cust_ID, Name, Address) VALUES
(100007, 'Amita Sharma', '789, ABC Nagar, Bangalore'),
(100008, 'Sanjay Verma', '456, XYZ Colony, Delhi'),
(100009, 'Anjali Singh', '101, PQR Road, Jaipur'),
(100010, 'Karan Gupta', '222, MNO Street, Chennai'),
(100011, 'Shreya Kumar', '333, GHI Lane, Kolkata');

-- INSERT INTO Emp_Info (Emp_Ref, Name, Gender, Address, Branch_Code) VALUES
-- (20007, 'Arun Kumar', 'M', '789, RST Street, Mumbai', 1001),
-- (20008, 'Meera Singh', 'F', '101, UVW Street, Delhi', 1002),
-- (20009, 'Raj Patel', 'M', '111, XYZ Street, Jaipur', 1003),
-- (20010, 'Neha Gupta', 'F', '222, ABC Street, Chennai', 1004);

INSERT INTO Cust_Accounts (Cust_ID, Acc_No, Account_Type) VALUES
(100007, 1000007, 'Savings'),
(100008, 1000008, 'Current'),
(100009, 1000009, 'Fixed Deposit'),
(100010, 1000010, 'Savings'),
(100011, 1000011, 'Current');

INSERT INTO Loan_Details (Acc_No, Loan_Type, Duration, Amount, Status) VALUES
(1000007, 'Home Loan', 20, 8000000.00, 'Active'),
(1000010, 'Personal Loan', 5, 200000.00, 'Active');

INSERT INTO Transaction (Transaction_Ref, Tr_Date, Tr_Amount, Tr_Type, Tr_Desc, Cust_ID, Acc_No) VALUES
(500011, '2024-04-11', 7000.00, 'Deposit', 'Deposit for savings account', 100007, 1000007),
(500012, '2024-04-12', 3500.00, 'Withdrawal', 'Withdrawal for expenses', 100008, 1000008),
(500013, '2024-04-13', 12000.00, 'Deposit', 'Deposit for fixed deposit account', 100009,1000009);

INSERT INTO Transaction (Transaction_Ref, Tr_Date, Tr_Amount, Tr_Type, Tr_Desc, Cust_ID, Acc_No) VALUES
(500014, '2024-04-14', 3000.00, 'Withdrawal', 'Withdrawal for emergency', 100010, 1000010),
(500015, '2024-04-15', 8000.00, 'Deposit', 'Deposit for savings account', 100011, 1000011);

INSERT INTO Repayment (Payment_Seqno, Payment_Amt, Payment_Date, Remaining_Amt, Acc_No) VALUES
(600005, 1500.00, '2024-04-05', 6500.00, 1000007),
(600006, 2000.00, '2024-04-06', 1500.00, 1000009),
(600007, 3000.00, '2024-04-07', 5000.00, 1000007),
(600008, 500.00, '2024-04-08', 2500.00, 1000010),
(600009, 1500.00, '2024-04-09', 6500.00, 1000011);

-- Adding a foreign key constraint to Repayment referencing Loan_Details
ALTER TABLE Repayment
ADD FOREIGN KEY (Acc_No) REFERENCES Loan_Details(Acc_No);

desc repayment;
desc loan_details;











