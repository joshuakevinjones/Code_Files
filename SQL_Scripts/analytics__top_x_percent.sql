-- ============================================================
-- Author / Project		Josh (Time Warner, Inc.)
-- Create Date			2017/10/23
-- Description			sample a top X % from a table
/*

*/
-- ============================================================

DECLARE @Top FLOAT;
SET @Top = .01;
SELECT TOP(@Top) PERCENT * FROM <[DATABASE].[Schema].[Table]>
ORDER BY ABS([<COLUMN>]) DESC ; 
