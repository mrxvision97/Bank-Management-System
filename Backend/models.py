from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Branch(db.Model):
    __tablename__ = 'Branch'
    Branch_Code = db.Column(db.Integer, primary_key=True)
    Branch_Name = db.Column(db.String(50), nullable=False)
    Branch_Loc = db.Column(db.String(100), nullable=False)

class CustomerInfo(db.Model):
    __tablename__ = 'Customer_Info'
    Cust_ID = db.Column(db.Integer, primary_key=True)
    Name = db.Column(db.String(50), nullable=False)
    DOB = db.Column(db.Date, nullable=False)
    Gender = db.Column(db.String(1), nullable=False)
    Branch_Code = db.Column(db.Integer, db.ForeignKey('Branch.Branch_Code'))

class EmpInfo(db.Model):
    __tablename__ = 'Emp_Info'
    Emp_Ref = db.Column(db.Integer, primary_key=True)
    Name = db.Column(db.String(50), nullable=False)
    Gender = db.Column(db.String(1), nullable=False)
    Address = db.Column(db.String(100), nullable=False)
    Branch_Code = db.Column(db.Integer, db.ForeignKey('Branch.Branch_Code'))

class EmpContact(db.Model):
    __tablename__ = 'Emp_Contact'
    Emp_Ref = db.Column(db.Integer, primary_key=True)
    Contact = db.Column(db.String(10), nullable=False)
    db.ForeignKeyConstraint(['Emp_Ref'], ['Emp_Info.Emp_Ref'])

class EmpAgeInfo(db.Model):
    __tablename__ = 'Emp_Age_Info'
    Emp_Ref = db.Column(db.Integer, primary_key=True)
    DOB = db.Column(db.Date, primary_key=True)
    Age = db.Column(db.Integer, nullable=False)
    db.ForeignKeyConstraint(['Emp_Ref'], ['Emp_Contact.Emp_Ref'])

class EmpStatus(db.Model):
    __tablename__ = 'Emp_Status'
    Emp_Ref = db.Column(db.Integer, primary_key=True)
    Position = db.Column(db.String(50), nullable=False)
    Salary = db.Column(db.Numeric(10, 2), nullable=False)
    db.ForeignKeyConstraint(['Emp_Ref'], ['Emp_Info.Emp_Ref'])

class CustAccounts(db.Model):
    __tablename__ = 'Cust_Accounts'
    Cust_ID = db.Column(db.Integer, primary_key=True)
    Acc_No = db.Column(db.Integer, primary_key=True)
    Account_Type = db.Column(db.String(20), nullable=False)
    db.ForeignKeyConstraint(['Cust_ID'], ['Customer_Info.Cust_ID'])

class AccountDetails(db.Model):
    __tablename__ = 'Account_Details'
    Account_Type = db.Column(db.String(20), primary_key=True)
    Status = db.Column(db.String(20), nullable=False)
    Interest_Rate = db.Column(db.Numeric(5, 2), nullable=False)
    Balance = db.Column(db.Numeric(12, 2), nullable=False)

class LoanType(db.Model):
    __tablename__ = 'Loan_Type'
    Loan_Type = db.Column(db.String(20), primary_key=True)
    Interest = db.Column(db.Numeric(5, 2), nullable=False)

class LoanDetails(db.Model):
    __tablename__ = 'Loan_Details'
    Acc_No = db.Column(db.Integer, primary_key=True)
    Loan_Type = db.Column(db.String(20), primary_key=True)
    Duration = db.Column(db.Integer, nullable=False)
    Amount = db.Column(db.Numeric(12, 2), nullable=False)
    Status = db.Column(db.String(20), nullable=False)
    db.ForeignKeyConstraint(['Loan_Type'], ['Loan_Type.Loan_Type'])
    db.ForeignKeyConstraint(['Acc_No'], ['Cust_Accounts.Acc_No'])

class Transaction(db.Model):
    __tablename__ = 'Transaction'
    Transaction_Ref = db.Column(db.Integer, primary_key=True)
    Tr_Date = db.Column(db.Date, nullable=False)
    Tr_Amount = db.Column(db.Numeric(12, 2), nullable=False)
    Tr_Type = db.Column(db.String(20), nullable=False)
    Tr_Desc = db.Column(db.String(100), nullable=False)
    Cust_ID = db.Column(db.Integer, nullable=True)
    Acc_No = db.Column(db.Integer, nullable=True)
    db.ForeignKeyConstraint(['Cust_ID', 'Acc_No'], ['Cust_Accounts.Cust_ID', 'Cust_Accounts.Acc_No'])

class Repayment(db.Model):
    __tablename__ = 'Repayment'
    Payment_Seqno = db.Column(db.Integer, primary_key=True)
    Payment_Amt = db.Column(db.Numeric(12, 2), nullable=False)
    Payment_Date = db.Column(db.Date, nullable=False)
    Remaining_Amt = db.Column(db.Numeric(12, 2), nullable=False)
    Acc_No = db.Column(db.Integer, nullable=False)
    db.ForeignKeyConstraint(['Acc_No'], ['Loan_Details.Acc_No'])
