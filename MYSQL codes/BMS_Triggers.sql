DELIMITER $$
CREATE TRIGGER Emp_Ref BEFORE INSERT ON Emp_Info
FOR EACH ROW
BEGIN
    DECLARE len INT;
    SET len = CHAR_LENGTH(CAST(NEW.Emp_Ref AS CHAR));
    IF len != 5 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Emp_Ref length must be 5 digits';
    END IF;
END$$
DELIMITER ;

-- Trigger for audit logging
-- for insert
DELIMITER $$
CREATE TRIGGER Emp_insert_Audit
AFTER INSERT ON Emp_Info
FOR EACH ROW
BEGIN
    INSERT INTO Emp_Info_Audit_Log (Emp_Ref, New_Name, Change_Date)
    VALUES (NEW.Emp_Ref, NEW.Name, NOW());
END$$
DELIMITER ;

-- for update
DELIMITER $$
CREATE TRIGGER Emp_Update_Audit
AFTER UPDATE ON Emp_Info
FOR EACH ROW
BEGIN
    INSERT INTO Emp_Info_Audit_Log (Emp_Ref, Old_Name, New_Name, Change_Date)
    VALUES (OLD.Emp_Ref, OLD.Name, NEW.Name, NOW());
END$$
DELIMITER ;

-- for delete
DELIMITER $$
CREATE TRIGGER Emp_Info_Audit_Delete
AFTER DELETE ON Emp_Info
FOR EACH ROW
BEGIN
    INSERT INTO Emp_Info_Audit_Log (Emp_Ref, Old_Name, Change_Date)
    VALUES (OLD.Emp_Ref, OLD.Name, NOW());
END$$
DELIMITER ;

-- Trigger for address updation

DELIMITER $$
CREATE TRIGGER Emp_Info_Add
AFTER INSERT ON Emp_Info
FOR EACH ROW
BEGIN
    INSERT INTO Address_Info (Emp_Ref, Name, Address)
    VALUES (NEW.Emp_Ref, NEW.Name, NEW.Address);
END$$
DELIMITER ;

-- Trigger for address updation
DELIMITER $$
CREATE TRIGGER Customer_Info_Up_Add
AFTER INSERT ON Customer_Info
FOR EACH ROW
BEGIN
    UPDATE Address_Info
    SET Address = NEW.Address
    WHERE Cust_ID = NEW.Cust_ID;
END$$
DELIMITER ;

-- Implement a trigger to automatically update the age of customers 
-- whenever a new customer is added or the date of birth is updated.

DELIMITER $$
CREATE TRIGGER Update_Customer_Age
AFTER INSERT ON Customer_Info
FOR EACH ROW
BEGIN
    INSERT INTO Age_Info (Cust_ID, DOB, Age)
    VALUES (NEW.Cust_ID, NEW.DOB, TIMESTAMPDIFF(YEAR, NEW.DOB, CURDATE()));
END$$
DELIMITER ;

-- Create a stored procedure to generate a report of all the loan repayments made by a specific customer.

DELIMITER $$
CREATE PROCEDURE GetCustomerLoanRepayments(IN customer_id INT)
BEGIN
    SELECT r.Payment_Seqno, r.Payment_Amt, r.Payment_Date, r.Remaining_Amt, ld.Loan_Type
    FROM Repayment r
    JOIN Loan_Details ld ON r.Acc_No = ld.Acc_No
    JOIN Cust_Accounts ca ON ld.Acc_No = ca.Acc_No
    WHERE ca.Cust_ID = customer_id
    ORDER BY r.Payment_Date;
END$$
DELIMITER ;

CALL GetCustomerLoanRepayments(100003);






