USE IAACE1;
GO


SELECT 
		 TABLE_SCHEMA
		,TABLE_NAME
		,COLUMN_NAME
		,(
		CASE data_type 
			WHEN 'bigint'			THEN 'int'
--			WHEN 'binary'			THEN 'raw'
			WHEN 'bit'				THEN 'int'
			WHEN 'char'				THEN 'char'
			WHEN 'datetime'			THEN 'DateTime'
			WHEN 'decimal'			THEN 'decimal'
			WHEN 'float'			THEN 'float'
--			WHEN 'image'			THEN 'long raw'
			WHEN 'int'				THEN 'int'
			WHEN 'money'			THEN 'double'
			WHEN 'nchar'			THEN 'string'
			WHEN 'ntext'			THEN 'string'
			WHEN 'nvarchar'			THEN 'string'
			WHEN 'numeric'			THEN 'int'
			WHEN 'real'				THEN 'decimal'
			WHEN 'smalldatetime'	THEN 'DateTime'
			WHEN 'smallmoney'		THEN 'double'
			WHEN 'smallint'			THEN 'int'
			WHEN 'text'				THEN 'string'
			WHEN 'timestamp'		THEN 'Date'
			WHEN 'uniqueidentifier' THEN 'string'
			--WHEN 'varbinary'		THEN 'raw'
			WHEN 'varchar'			THEN 'string'
									ELSE 'CHECK THIS.. ' + data_type + ' DataType'
		END 
		) AS data_type
	
FROM information_schema.columns
WHERE TABLE_NAME IN ('JRNL_HDR_LN', 'v_JRNL_HDR_LN')