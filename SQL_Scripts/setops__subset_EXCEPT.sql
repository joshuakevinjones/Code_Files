
-- this would return customer ids with no contract id

SELECT
	[ID]
FROM
	[IAACE1].[TRN_LA_iB].[LA_Customers]

EXCEPT

SELECT
	[Cov Cust ID]
FROM
	[IAACE1].[TRN_LA_iB].[LA_Contracts]

-- this is a different way to return the same information

SELECT
cust.[ID], cust.[Customer Name] 
FROM
[IAACE1].[TRN_LA_iB].[LA_Customers] cust
WHERE
	cust.[Status] = 'Active'
	AND
	cust.ID NOT IN 
		(SELECT con.[Cov Cust ID] FROM [IAACE1].[TRN_LA_iB].[LA_Contracts] con)