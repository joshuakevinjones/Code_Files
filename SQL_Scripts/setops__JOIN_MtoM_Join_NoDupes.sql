/* 
Customers joined to contracts
*/

SELECT
cust.[Row_Num] AS 'Cust Row'
, cust.[ID] AS 'Cust ID'
, cust.[Customer Name]
, con.[Row_Num] AS 'Con Row'
, con.[Cov Cust ID] as 'Con Cov Cust ID'
, con.[Contract ID] 
, cust.[Status]
, con.[Contract Status]
, con.[Reporting Country]

FROM
[IAACE1].[TRN_LA_iB].[LA_Customers] cust
	
  /* Join syntax #1 --- no duplicates */
	LEFT JOIN (
		SELECT *
		, ROW_NUMBER() OVER (PARTITION BY LOWER([Cov Cust ID]) ORDER BY [Cov Cust ID]) AS rn 
		FROM [IAACE1].[TRN_LA_iB].[LA_Contracts] 
		) con 
		ON con.[Cov Cust ID] = cust.[ID] and con.rn = 1

 -- /* Join syntax #2 --- duplicates (traditional join) */
	--LEFT JOIN 
	--	[IAACE1].[TRN_LA_iB].[LA_Contracts] con 
	--	ON con.[Cov Cust ID] = cust.[ID]

WHERE
cust.[Status] = 'Active'

ORDER BY 
cust.[Row_Num] ASC