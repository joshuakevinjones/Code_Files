SELECT
	t1.[ID], t1.[Status], t1.[Customer Name], t2.[Customer ID]

	FROM [IAACE1].[TRN_LA_iB].[LA_Customers] t1	--Active Customers
	
	LEFT OUTER JOIN --LOJ w Exclusion
		[IAACE1].[TRN_LA_iB].[LA_Billing_Details] t2 --Bills	

		ON t1.[ID] = t2.[Customer ID]
		WHERE
			t2.[Customer ID] IS NULL -- no bills present in the bill file (bc no listings of that customer)	
			AND
			t1.[Status] = 'Active' -- customer present in the Customer table and has status of 'Active'