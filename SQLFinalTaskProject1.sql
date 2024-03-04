CREATE DATABASE DWH;

USE DWH;

CREATE TABLE DimCustomer (
	CustomerID INT NOT NULL,
	CustomerName VARCHAR(100) NOT NULL,
	CityName VARCHAR(100) NOT NULL,
	StateName VARCHAR(100) NOT NULL,
	Address Varchar(100) NOT NULL,
	CityID INT NOT NULL,
	Age INT NOT NULL,
	Gender VARCHAR(100) NOT NULL,
	Email VARCHAR(100) NOT NULL,
	CONSTRAINT PKCustomerID PRIMARY KEY (CustomerID)
);

CREATE TABLE DimAccount (
	AccountID INT NOT NULL,
	CustomerID INT NOT NULL,
	AccountType VARCHAR(100) NOT NULL,
	Balance INT NOT NULL,
	DateOpened DATE NOT NULL,
	Status VARCHAR(100) NOT NULL,
	CONSTRAINT PKAccountID PRIMARY KEY (AccountID),
	CONSTRAINT FKCustomerID FOREIGN KEY (CustomerID) REFERENCES DimCustomer (CustomerID)
);

CREATE TABLE DimBranch (
	BranchID INT NOT NULL,
	BranchName VARCHAR(100) NOT NULL,
	BranchLocation VARCHAR(100) NOT NULL,
	CONSTRAINT PKBranchID PRIMARY KEY (BranchID)
);

CREATE TABLE FactTransaction (
	TransactionID INT NOT NULL,
	AccountID INT NOT NULL,
	TransactionDate DATE NOT NULL,
	Amount INT NOT NULL,
	TransactionType VARCHAR(100) NOT NULL,
	BranchID INT NOT NULL,
	CONSTRAINT PKTransactionID PRIMARY KEY (TransactionID),
	CONSTRAINT FKAccountID FOREIGN KEY (AccountID) REFERENCES DimAccount (AccountID),
	CONSTRAINT FKBranchID FOREIGN KEY (BranchID) REFERENCES DimBranch (BranchID)
);

SELECT * FROM DimCustomer
SELECT * FROM DimAccount
SELECT * FROM DimBranch
SELECT * FROM FactTransaction
