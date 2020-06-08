-- ============================================================
-- Author / Project		Josh (Time Warner, Inc.)
-- Create Date			2017/10/23
-- Description			read only 10 query rows at a time
/*
	helpful when dealing with a slow view, join, etc.
*/
-- ============================================================

-- adding OFFSET and FETCH clauses to the query's ORDER BY clause

SELECT ProductID, Name
FROM Production.Product
ORDER BY Name
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

--Results from this query will be the first 10 rows, as ordered by product name