/* 
Existing table
	add calculated column
	calc column is total sum of existing column

*/

ALTER TABLE 
	[IAACE1].[TRNPAY].[TAX_DIST_MULTISTATE] 
ADD 
	TOTAL_C INT;

UPDATE a
SET a.TOTAL_C = b.TOTAL_C
FROM [IAACE1].[TRNPAY].[TAX_DIST_MULTISTATE] a
INNER JOIN
	(
	SELECT [Empl ID], SUM([Distrb %]) AS [TOTAL_C] 
	FROM [IAACE1].[TRNPAY].[TAX_DIST_MULTISTATE] 
	GROUP BY [Empl ID]
	) b
ON a.[Empl ID] = b.[Empl ID];