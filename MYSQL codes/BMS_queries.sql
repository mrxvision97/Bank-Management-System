
-- Customer Demographics Analysis:
-- Identify the average age of customers in each branch and gender distribution within each age group to understand the demographic profile of customers
SELECT Branch.Branch_Name,
    AVG(Age_Info.Age) AS Avg_Customer_Age,
    SUM(CASE WHEN Customer_Info.Gender = 'M' THEN 1 ELSE 0 END) AS Male_Customers,
    SUM(CASE WHEN Customer_Info.Gender = 'F' THEN 1 ELSE 0 END) AS Female_Customers
FROM Branch JOIN 
    Customer_Info ON Branch.Branch_Code = Customer_Info.Branch_Code
JOIN 
    Age_Info ON Customer_Info.Cust_ID = Age_Info.Cust_ID
GROUP BY 
    Branch.Branch_Name;
    
-- Identify the total outstanding loan amount for each loan type to assess the bank's exposure
SELECT Loan_Details.Loan_Type,
    SUM(Loan_Details.Amount) AS Total_Outstanding_Amount
FROM Loan_Details
GROUP BY Loan_Details.Loan_Type;

-- Identify customers with the highest transaction volumes and their transaction patterns to offer personalized banking services and incentives.
SELECT ci.Name,
    COUNT(t.Transaction_Ref) AS Total_Transactions,
    SUM(t.Tr_Amount) AS Total_Amount_Transacted
FROM Customer_Info ci
JOIN Transaction t ON ci.Cust_ID = t.Cust_ID
GROUP BY ci.Name
ORDER BY Total_Transactions DESC
LIMIT 10;

SELECT 
    b.Branch_Name,
    COUNT(e.Emp_Ref) AS Employee_Count
FROM 
    Branch b
LEFT JOIN 
    Emp_Info e ON b.Branch_Code = e.Branch_Code
GROUP BY 
    b.Branch_Name;
-- Retrieve the loan types with the highest interest rates.
SELECT lt.Loan_Type, lt.Interest
FROM Loan_Type lt
WHERE lt.Interest = (SELECT MAX(Interest) FROM Loan_Type);







