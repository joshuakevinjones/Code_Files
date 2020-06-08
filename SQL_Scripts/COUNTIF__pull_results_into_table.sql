/* ----------
Creates new table of results

Uses two tables
	1) lookup table a
	2) activity (detail) table b
Using the lookup table, counts occurrences in b of every item in activity
	will only show counts for items that exist in b

Notes
v2 is probably preferable
*/ ----------

SELECT
	a.[Earn Code],    
	a.[Descr],
	COUNT(b.[Earn Code]) Count_C

INTO [IAACE1].[TRNPAY].[A_EARNCODE_USAGE]

FROM 
	(
	SELECT DISTINCT 
		[Earn Code],    
		[Descr]
	FROM 
		[IAACE1].[TRNPAY].[LK_EARNCODE_TBL]
	) a	

		INNER JOIN 
			[IAACE1].[TRNPAY].[BASE_EARN_CODE_DETAIL] b
		ON
			a.[Earn Code] = b.[Earn Code]

GROUP BY a.[Earn Code],[Descr];

