-- ============================================================
-- Author / Project		Josh (Time Warner, Inc.)
-- Create Date			2017/10/23
-- Description			add materialized column
/*
	Allows you to materialize a comparison-type column into an existing table
*/
-- ============================================================

/* Update [IAACE1].[TRN_LA_iB].[LA_Customers] with a new permanent column	
Logic for new column		
CASE WHEN [Primary Address Country] = [Reporting Country] THEN 'True' ELSE 'False' END AS [Address = Reporting]
*/

ALTER TABLE 
	[Database].[Schema].[Table] 

	ADD [<name of new column>] VARCHAR(5); --VARCHAR(5) is a data type specification

UPDATE [Database].[Schema].[Table]
SET [<name of new column>] = CASE WHEN [<field 1>] = [<field 2>] THEN 'True' ELSE 'False' END
FROM [Database].[Schema].[Table] 
;