use bank_management_system;

-- Creating Views 

-- Employee details view
CREATE VIEW Employee_Details AS
SELECT e.*, b.Branch_Name, b.Branch_Loc
FROM Emp_Info e
JOIN Branch b ON e.Branch_Code = b.Branch_Code;

select* from Employee_Details;

-- Customer summary view
CREATE VIEW Customer_Summary AS
SELECT ci.Cust_ID, ci.Name, ci.DOB, cc.Contact, ai.Address, b.Branch_Name, b.Branch_Loc
FROM Customer_Info ci
JOIN Customer_Contact cc ON ci.Cust_ID = cc.Cust_ID
JOIN Address_Info ai ON ci.Cust_ID = ai.Cust_ID
JOIN Branch b ON ci.Branch_Code = b.Branch_Code;

select* from Customer_Summary;

-- Loan Summary View

CREATE VIEW Loan_Summary AS
SELECT ld.Acc_No, ld.Loan_Type, lt.Interest, ld.Amount, ld.Duration, ld.Status
FROM Loan_Details ld
JOIN Loan_Type lt ON ld.Loan_Type = lt.Loan_Type;
select * from Loan_Summary;






