CREATE PROC nth 
(
	@table_name sysname,
	@column_name sysname,
	@nth int
)
AS
BEGIN

--Written by: Narayana Vyas Kondreddi
--Date written: December 23rd 2000
--Purpose: To find out the nth highest number in a column. Eg: Second highest salary from the salaries table
--Input parameters: Table name, Column name, and the nth position
--Tested on: SQL Server Version 7.0
--Email: answer_me@hotmail.com

SET @table_name = RTRIM(@table_name)
SET @column_name = RTRIM(@column_name)

DECLARE @exec_str CHAR(400)
IF (SELECT OBJECT_ID(@table_name,'U')) IS NULL
BEGIN
	RAISERROR('Invalid table name',18,1)
	RETURN -1
END

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @table_name AND COLUMN_NAME = @column_name)
BEGIN
	RAISERROR('Invalid column name',18,1)
	RETURN -1
END

IF @nth <= 0
BEGIN
	RAISERROR('nth highest number should be greater than Zero',18,1)
	RETURN -1
END

SET @exec_str = 'SELECT MAX(' + @column_name + ') from ' + @table_name + ' WHERE ' + @column_name + ' NOT IN ( SELECT TOP ' + LTRIM(STR(@nth - 1)) + ' ' + @column_name + ' FROM ' + @table_name + ' ORDER BY ' + @column_name + ' DESC )'
EXEC (@exec_str)

END