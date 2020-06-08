
-- ============================================================
-- Author / Project		General (Time Warner, Inc.)
-- Create Date			2017/11/07
-- Description			Test equivalency for names and data types
/*
	Compare equivalency for column names and data types
	across two tables
*/
-- ============================================================

/****************************************************************
change history


***************************************************************/

USE IAACE1
GO

SELECT
	c1.TABLE_NAME,
	c1.COLUMN_NAME,
	c1.DATA_TYPE,
	c2.TABLE_NAME,
	c2.DATA_TYPE,
	c2.COLUMN_NAME,
	IIF(c1.COLUMN_NAME = c2.COLUMN_NAME, 'TRUE', 'FALSE') AS 'Column_Name_Match',
	IIF(c1.DATA_TYPE = c2.DATA_TYPE, 'TRUE', 'FALSE') AS 'Data_Type_Match'

FROM 
	[INFORMATION_SCHEMA].[COLUMNS] c1

LEFT JOIN 
	[INFORMATION_SCHEMA].[COLUMNS] c2 
	ON 
	c1.COLUMN_NAME = c2.COLUMN_NAME

WHERE 
	c1.TABLE_NAME = 'JRNL_HDR_LN' --Name original table (table1) here
	and c2.TABLE_NAME = 'JRNL_HDR_LN_STAGE' --Name compare table (table2) here
	and c1.DATA_TYPE <> c2.DATA_TYPE