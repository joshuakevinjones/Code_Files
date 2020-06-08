
-- ============================================================
-- Author / Project		Josh / n/a
-- Create Date			2017/10/23
-- Description			
/*
	ways to append a new table onto an existing table
	
*/
-- ============================================================

/****************************************************************
change history


***************************************************************/

-- Into existing table / from existing table : INSERT INTO SELECT

INSERT INTO <target_table> (column1, column2) -- can also just use *
SELECT
	column1, column2
FROM 
	<source_table>
WHERE
	--where conditions

-- Into existing table / from values : INSERT INTO

INSERT INTO <target_table> (column1, column2)
VALUES ('value1', 'value2')

	-- You actually have to do it like this to make it work
	USE IAACE1
	GO
	INSERT INTO [TRN_PS].[A_KEYWORDS_TBL] (words, word_flag)
	VALUES ('Shortfall', 'Highlight')