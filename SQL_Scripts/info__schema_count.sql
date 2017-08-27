/*

*/

/*
Setup steps
specifiy database
*/

USE AdventureWorks2008R2;
GO

/* Code */

SELECT  
	DISTINCT s.name AS schema_name
/*	, t.name as table_name */
/*	, c.name as column_name */

FROM sys.columns c 
   INNER JOIN sys.tables t 
		ON c.object_id = t.object_id
   INNER JOIN sys.schemas AS s 
		ON t.[schema_id] = s.[schema_id]

ORDER BY
	schema_name