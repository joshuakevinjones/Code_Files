SELECT  
	 DATEPART(YYYY, [Check Dt]) AS 'Year'
	,DATEPART(MM, [Check Dt]) AS 'Period'    
	,[Chk Option Descr] 
	,[Off Cycle]
	--,[Reprint]
	--,[Pay Period End]
	,SUM([Tot Gross]) AS 'Tot Gross'
	,SUM([Total Taxes]) AS 'Total Taxes'
	,SUM([Total Ded#]) AS 'Total Ded'
	,SUM([Net Pay]) AS 'Net Pay'
	,Count([Check Nbr]) AS 'Number of Checks'
	--,[Check Nbr]

FROM
	[IAACE1].[TRNPAY].[BASE_PAYCHECK_TAX_ALL_1]

GROUP BY 
	ROLLUP
		(
			 DATEPART(YYYY, [Check Dt])
			,DATEPART(MM, [Check Dt])   
			,[Chk Option Descr] 
			,[Off Cycle]
			--,[Reprint]
			--,[Pay Period End]
		)
