--strings__CONCAT

-- Method 1: Concatenating two strings
SELECT 'FirstName' + ' ' + 'LastName' AS FullName


-- Method 2: Concatenating two Numbers
SELECT CAST(1 AS VARCHAR(10)) + ' ' + CAST(2 AS VARCHAR(10))


-- Method 3: Concatenating values of table columns
SELECT FirstName + ' ' + LastName AS FullName
FROM AdventureWorks2012.Person.Person


-- Method 4: SQL Server 2012 CONCAT function
SELECT CONCAT('FirstName' , ' ' , 'LastName') AS FullName


-- Method 5: SQL Server 2012 CONCAT function
SELECT CONCAT('FirstName' , ' ' , 1) AS FullName