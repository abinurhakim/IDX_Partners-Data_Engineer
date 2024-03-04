CREATE PROCEDURE DailyTransactions
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    SELECT
		TransactionDate AS [Date],
        COUNT(TransactionID) AS TotalTransactions,
        SUM(Amount) AS TotalAmount
    FROM
        FactTransaction 
    WHERE
        TransactionDate BETWEEN @start_date AND @end_date
	GROUP BY
		TransactionDate
END;

EXEC DailyTransactions @start_date ='2024-01-18', @end_date= '2024-01-21'


CREATE PROCEDURE BalancePerCustomers
    @name NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.CustomerName,
        a.AccountType,
        a.Balance,
        a.Balance - ISNULL(SUM(CASE WHEN t.TransactionType = 'Deposit' THEN t.Amount ELSE -t.Amount END), 0) AS CurrentBalance
    FROM 
        DimCustomer c
    INNER JOIN 
        DimAccount a ON c.CustomerID = a.CustomerID
    LEFT JOIN 
        FactTransaction t ON a.AccountID = t.AccountID
    WHERE 
        c.CustomerName = @name
        AND a.Status = 'active'
    GROUP BY 
        c.CustomerName, a.AccountType, a.Balance;
END

EXEC BalancePerCustomers @name = 'Shelly'