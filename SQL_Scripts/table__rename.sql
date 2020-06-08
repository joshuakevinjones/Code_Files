
-- ============================================================
-- Author / Project		Josh / Misc
-- Create Date			10/30/2017
-- Description			Rename column
/*
	Rename a column
*/
-- ============================================================

-- Rename a table

EXEC sp_rename 'OldTableName', 'NewTableName'

-- Rename a column

EXEC sp_rename
    @objname = 'TableName.OldColumnName',
    @newname = 'NewColumnName',
    @objtype = 'COLUMN'