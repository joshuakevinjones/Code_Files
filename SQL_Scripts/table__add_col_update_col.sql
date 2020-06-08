-- Add the column

USE IAACE1;
GO

	ALTER TABLE
	[dbo].[<'table name'>]. ADD [NEW_COLUMN] VARCHAR(20) NULL; -- need the NULL bc no values yet

-- Update the column with a value

USE IAACE1;
GO
	UPDATE 
	[dbo].[<'table name'>]
	SET [NET_COLUMN] = 'C';