document.addEventListener("DOMContentLoaded", () => {
    fetch("/branches")
        .then(response => response.json())
        .then(data => {
            const branchList = document.getElementById("branches");
            data.forEach(branch => {
                const li = document.createElement("li");
                li.textContent = `${branch.Branch_Code} - ${branch.Branch_Name} - ${branch.Branch_Loc}`;
                branchList.appendChild(li);
            });
        });

    fetch("/customers")
        .then(response => response.json())
        .then(data => {
            const customerList = document.getElementById("customers");
            data.forEach(customer => {
                const li = document.createElement("li");
                li.textContent = `${customer.Cust_ID} - ${customer.Name} - ${customer.DOB} - ${customer.Gender} - ${customer.Branch_Code}`;
                customerList.appendChild(li);
            });
        });

    fetch("/employees")
        .then(response => response.json())
        .then(data => {
            const employeeList = document.getElementById("employees");
            data.forEach(employee => {
                const li = document.createElement("li");
                li.textContent = `${employee.Emp_Ref} - ${employee.Name} - ${employee.Gender} - ${employee.Address} - ${employee.Branch_Code}`;
                employeeList.appendChild(li);
            });
        });

    fetch("/accounts")
        .then(response => response.json())
        .then(data => {
            const accountList = document.getElementById("accounts");
            data.forEach(account => {
                const li = document.createElement("li");
                li.textContent = `${account.Cust_ID} - ${account.Acc_No} - ${account.Account_Type}`;
                accountList.appendChild(li);
            });
        });

    fetch("/loans")
        .then(response => response.json())
        .then(data => {
            const loanList = document.getElementById("loans");
            data.forEach(loan => {
                const li = document.createElement("li");
                li.textContent = `${loan.Acc_No} - ${loan.Loan_Type} - ${loan.Duration} - ${loan.Amount} - ${loan.Status}`;
                loanList.appendChild(li);
            });
        });

    fetch("/transactions")
        .then(response => response.json())
        .then(data => {
            const transactionList = document.getElementById("transactions");
            data.forEach(transaction => {
                const li = document.createElement("li");
                li.textContent = `${transaction.Transaction_Ref} - ${transaction.Tr_Date} - ${transaction.Tr_Amount} - ${transaction.Tr_Type} - ${transaction.Tr_Desc} - ${transaction.Cust_ID} - ${transaction.Acc_No}`;
                transactionList.appendChild(li);
            });
        });

    fetch("/repayments")
        .then(response => response.json())
        .then(data => {
            const repaymentList = document.getElementById("repayments");
            data.forEach(repayment => {
                const li = document.createElement("li");
                li.textContent = `${repayment.Payment_Seqno} - ${repayment.Payment_Amt} - ${repayment.Payment_Date} - ${repayment.Remaining_Amt} - ${repayment.Acc_No}`;
                repaymentList.appendChild(li);
            });
        });
});
