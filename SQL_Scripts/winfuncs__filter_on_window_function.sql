/* Filter on a window function */

SELECT x.*

FROM (
	SELECT 
		[ID],
		[Empl Record],
		[Tot Gross],
		[Total Taxes],
		[Total Ded#],
		[Net Pay],
		[Chk Option],
		[Reprint],
		[Check Nbr],
		
		COUNT([Check Nbr]) OVER(PARTITION BY [Check Nbr] ORDER BY [Check Nbr]) AS [Check Nbr Count] 

	FROM 
		[IAACE1].[TRNPAY].[BASE_PAYCHECK_TAX_ALL]
		) x

WHERE 
	x.[Check Nbr Count] > 1;