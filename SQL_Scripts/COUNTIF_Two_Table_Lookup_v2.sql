/* ----------
Shows results
Uses two tables
	1) lookup table a
	2) activity (detail) table b
Using the lookup table, counts occurrences in b of every item in activity
	will show 0 for items in a not found in b

Business purpose
	Using a base table of all options, show how often those options occur in an activity table
*/ ----------

SELECT	
	a.[Earn Code]    
	, a.[Descr]
	, a.[Status]
	, COUNT(b.[Earn Code]) Count_C

FROM 
	(SELECT DISTINCT 
		[Earn Code]    
		,[Descr]
		,[Status]
	FROM [IAACE1].[TRNPAY].[LK_EARNCODE_TBL]
	) a	

LEFT OUTER JOIN 
	[IAACE1].[TRNPAY].[BASE_EARN_CODE_DETAIL] 
	b

	ON 
		a.[Earn Code] = b.[Earn Code]

GROUP BY 
	a.[Earn Code], a.[Status], [Descr]

ORDER BY 
	Count_C DESC;