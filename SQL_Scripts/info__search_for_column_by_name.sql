
-- ============================================================
-- Josh / No Project		
-- 2018/09/28			
-- Search the whole db for a column using that column's name			
/*
	This script searches the database and returns the dbs.schemas.tables
	that contain the column.
*/
-- ============================================================

/* ============================================================
change history


============================================================ */

SELECT t.name AS table_name
	,SCHEMA_NAME(schema_id) AS schema_name
	,c.name AS column_name
FROM sys.tables AS t
INNER JOIN sys.columns c ON t.OBJECT_ID = c.OBJECT_ID
WHERE c.name LIKE '%FSCL_WK_END_DT%'
ORDER BY schema_name
	,table_name;

/*
Alternate version that searches views as well

*/
SELECT      COLUMN_NAME AS 'ColumnName'
            ,TABLE_NAME AS  'TableName'
FROM        INFORMATION_SCHEMA.COLUMNS
WHERE       COLUMN_NAME LIKE '%COST_DST_CD_VAL%'
ORDER BY    TableName
            ,ColumnName;
