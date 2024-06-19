/*
This file contains a script of Transact SQL (T-SQL) command to interact with a database named 'Inventory'.
Requirements:
- SQL Server 2022 is installed and running
- database 'Inventory' already exists.
Errors:
- if the database 'Inventory' does not exist, the script will print an error message and exit.
Details:
- Sets the default database to 'Inventory'.
- Creates a 'categories' table and related 'products' table, if they do not already exist.
- Remove all rows from the tables (in case they already existed).
- Populates the 'Categories' table with sample data.
- Populates the 'Products' table with sample data.
*/

-- Check if the database 'Inventory' exists
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Inventory')
BEGIN
    PRINT 'Error: The database Inventory does not exist. Please create the database first.'
    RETURN
END

-- set the default database to 'Inventory'
USE Inventory

-- Create the 'Categories' table if it does not already exist. 
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Categories') 
BEGIN
    CREATE TABLE Categories (
        CategoryID INT PRIMARY KEY,
        CategoryName NVARCHAR(50) NOT NULL
    )
END

-- Create the 'Products' table if it does not already exist.
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Products')
BEGIN
    CREATE TABLE Products (
        ProductID INT PRIMARY KEY,
        ProductName NVARCHAR(50) NOT NULL,
        CategoryID INT,
        Price DECIMAL(10, 2),
        -- add a created date column
        CreatedDate DATETIME DEFAULT GETDATE(),
        -- add an updated date column
        UpdatedDate DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
    )
END

-- Remove all rows from the 'Products' table (in case it already existed)
TRUNCATE TABLE Products

-- Remove all rows from the 'Categories' table (in case it already existed)
TRUNCATE TABLE Categories

-- Populate the 'Categories' table with sample data
INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books')

-- Populate the 'Products' table with sample data
INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES
(1, 'Laptop', 1, 999.99),
(2, 'T-shirt', 2, 19.99),
(3, 'Book', 3, 29.99)

-- Verify the data in the 'Categories' table
SELECT * FROM Categories

-- Verify the data in the 'Products' table
SELECT * FROM Products


