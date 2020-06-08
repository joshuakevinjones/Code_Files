
-- ============================================================
-- Author / Project		(General) Time Warner, Inc.
-- Create Date			2017/11/07
-- Description			Update a lookup list with no values, 
--						while avoiding dupes
/*
	Ways to create a new table by copying an existing table	
	or copying the results of a subset on an existing table
*/
-- ============================================================

/****************************************************************
change history


***************************************************************/

INSERT INTO dbo.names_table ( name )
SELECT wt.name
FROM dbo.work_table wt
LEFT OUTER JOIN dbo.names_tables nt ON
    nt.name = wt.name
WHERE
    nt.name IS NULL --true only if name doesn't already exist in dbo.names_table