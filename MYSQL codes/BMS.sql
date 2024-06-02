CREATE DATABASE BANK_MANAGEMENT_SYSTEM;
USE BANK_MANAGEMENT_SYSTEM;

-- Branch Table
CREATE TABLE Branch (
  Branch_Code INT PRIMARY KEY CHECK(length(Branch_Code)=4),
  Branch_Name VARCHAR(50) NOT NULL,
  Branch_Loc VARCHAR(100) NOT NULL
);


-- Customer Tables
CREATE TABLE Customer_Info (
  Cust_ID INT PRIMARY KEY CHECK(length(Cust_ID)=6),
  Name VARCHAR(50) NOT NULL,
  DOB DATE NOT NULL,
  Gender CHAR(1) NOT NULL
);
ALTER TABLE Customer_Info
ADD COLUMN Branch_Code INT,
ADD FOREIGN KEY (Branch_Code) REFERENCES Branch(Branch_Code);


CREATE TABLE Customer_Contact (
  Cust_ID INT PRIMARY KEY,
  Contact CHAR(10) NOT NULL,
  FOREIGN KEY (Cust_ID) REFERENCES Customer_Info(Cust_ID)
);

CREATE TABLE Age_Info (
  Cust_ID INT NOT NULL,
  DOB DATE NOT NULL,
  Age INT NOT NULL,
  PRIMARY KEY (Cust_ID, DOB),
  FOREIGN KEY (Cust_ID) REFERENCES Customer_Info(Cust_ID)
);
CREATE TABLE Address_Info (
  Cust_ID INT,
  Name VARCHAR(50) NOT NULL,
  Address VARCHAR(100) NOT NULL,
  PRIMARY KEY (Name),
  INDEX fk_cust_id (Cust_ID), -- Index on the foreign key column
  FOREIGN KEY (Cust_ID) REFERENCES Customer_Info(Cust_ID),
  CONSTRAINT fk_name_cust_id FOREIGN KEY (Name, Cust_ID) REFERENCES Customer_Info(Name, Cust_ID)
);

-- Add index on the referenced columns in Customer_Info
CREATE INDEX idx_customer_info_name_cust_id ON Customer_Info (Name, Cust_ID);

show tables;
desc Address_Info;

-- Employee Tables
CREATE TABLE Emp_Info (
  Emp_Ref INT PRIMARY KEY,
  Name VARCHAR(50) NOT NULL,
  Gender CHAR(1) NOT NULL,
  Address VARCHAR(100) NOT NULL,
  Branch_Code int, 
  FOREIGN KEY (Branch_Code) REFERENCES Branch(Branch_Code)
);

CREATE TABLE Emp_Contact (
  Emp_Ref INT PRIMARY KEY,
  Contact CHAR(10) NOT NULL,
  FOREIGN KEY (Emp_Ref) REFERENCES Emp_Info(Emp_Ref)
);

CREATE TABLE Emp_Age_Info (
Emp_ref INT NOT NULL,
  DOB DATE,
  Age INT NOT NULL,
  PRIMARY KEY (Emp_Ref, DOB),
  FOREIGN KEY (Emp_Ref) REFERENCES Emp_Contact(Emp_Ref)
);

CREATE TABLE Emp_Status (
  Emp_Ref INT PRIMARY KEY,
  Position VARCHAR(50) NOT NULL,
  Salary DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (Emp_Ref) REFERENCES Emp_Info(Emp_Ref)
);

-- Account Tables
CREATE TABLE Cust_Accounts (
  Cust_ID INT,
  Acc_No INT,
  Account_Type VARCHAR(20) NOT NULL,
  PRIMARY KEY (Cust_ID, Acc_No),
  FOREIGN KEY (Cust_ID) REFERENCES Customer_Info(Cust_ID)
);

	CREATE TABLE Account_Details (
	  Account_Type VARCHAR(20) PRIMARY KEY,
	  Status VARCHAR(20) NOT NULL,
	  Interest_Rate DECIMAL(5, 2) NOT NULL,
	  Balance DECIMAL(12, 2) NOT NULL
	);
	-- Loan Tables
	CREATE TABLE Loan_Type (
	  Loan_Type VARCHAR(20) PRIMARY KEY,
	  Interest DECIMAL(5, 2) NOT NULL
	);

CREATE TABLE Loan_Details (
  Acc_No INT,
  Loan_Type VARCHAR(20),
  Duration INT NOT NULL,
  Amount DECIMAL(12, 2) NOT NULL,
  Status VARCHAR(20) NOT NULL,
  PRIMARY KEY (Acc_No, Loan_Type),
  FOREIGN KEY (Loan_Type) REFERENCES Loan_Type(Loan_Type),
  FOREIGN KEY (Acc_No) REFERENCES Cust_Accounts(Acc_No)
);
-- Add index on referenced column in Loan_Type
CREATE INDEX idx_loan_type_loan_type ON Loan_Type (Loan_Type);

-- Add index on referenced column in Cust_Accounts
CREATE INDEX idx_cust_accounts_acc_no ON Cust_Accounts (Acc_No);

-- Transaction Table
CREATE TABLE Transaction (
  Transaction_Ref INT PRIMARY KEY,
  Tr_Date DATE NOT NULL,
  Tr_Amount DECIMAL(12, 2) NOT NULL,
  Tr_Type VARCHAR(20) NOT NULL,
  Tr_Desc VARCHAR(100) NOT NULL,
  Cust_ID INT NULL,
  Acc_No INT NULL,
  FOREIGN KEY (Cust_ID, Acc_No) REFERENCES Cust_Accounts(Cust_ID, Acc_No)
);

CREATE TABLE Repayment (
  Payment_Seqno INT PRIMARY KEY,
  Payment_Amt DECIMAL(12, 2) NOT NULL,
  Payment_Date DATE NOT NULL,
  Remaining_Amt DECIMAL(12, 2) NOT NULL,
  Acc_No INT NOT NULL,
  FOREIGN KEY (Acc_No) REFERENCES Loan_Details(Acc_No)
);

show tables;






