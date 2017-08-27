-- SQL JOINS
	-- SQL joins combine rows from two or more tables
	
-- INNER JOIN ... returns all rows when there is >= 1 match in BOTH tables
-- LEFT JOIN ... returns all rows from the left table and the MATCHED rows from the right table
-- RIGHT JOIN ... returns all rows from the right table and the MATCH rows from the left table
-- FULL JOIN ... returns all rows when there is a match in one of the tables


-- INNER JOIN
	-- INNER JOIN = JOIN
	-- selects all rows from both tables as long as there is a match b/t columns in both tables
		-- returns all rows from multiple tables where the join condition is met
	
-- General

SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name=table2.column_name;
	
-- or

SELECT column_name(s)
FROM table1
JOIN table2
ON table1.column_name=table2.column_name;

-- Example
	-- returns all customers with orders

SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
ORDER BY Customers.CustomerName;

-- LEFT JOIN
	-- returns all rows from left table (table 1) with the matches from the right table (table 2)
	-- returns NULL in the right side when there is no match

-- General
	
SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name=table2.column_name;

-- or

SELECT column_name(s)
FROM table1
LEFT OUTER JOIN table2
ON table1.column_name=table2.column_name;

-- RIGHT JOIN
	-- returns all rows from the right table (table2) with the matching rows in the left table (table1)
	-- returns NULL in the left side when there is no match

-- General

SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name=table2.column_name;

-- or

SELECT column_name(s)
FROM table1
RIGHT OUTER JOIN table2
ON table1.column_name=table2.column_name;

-- FULL OUTER JOIN
	-- returns all rows from the left table (table1) and from the right table (table2)
	-- can be good for
		-- profiling data and revealing anomalies (orphaned data)
	
-- General

SELECT column_name(s)
FROM table1
FULL OUTER JOIN table2
ON table1.column_name=table2.column_name;

-- Example
	-- returns all customers and all orders
	-- either customers or orders can be NULL

SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
FULL OUTER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
ORDER BY Customers.CustomerName;	