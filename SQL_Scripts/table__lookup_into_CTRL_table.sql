-- VLOOKUP-like
	-- does lookup into CTRL table to add a Descr where there is currently only a code (add long description)

SELECT
	a.*, b.[field] AS 'field name'

FROM
	[db].[schema].[table] a
	
LEFT JOIN
	[db].[schema].[table2] b

ON a.[field] = b.[field]