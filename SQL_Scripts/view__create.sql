/* How to create a view */

-- basic syntax

CREATE VIEW Top10Sales AS 

SELECT
	 top(10) [TotalSales] 
			,[SalesYear]	
			,[SalesWeek]
			,[ProductName]
FROM
	[dbo].[SalesByProductSummary]

ORDER BY
	 [SalesYear]	
	,[SalesWeek]
	,[TotalSales] DESC

	/* Then to use the view later */
	SELECT * FROM [dbo].[Top10Sales]
	--... additional filters in WHERE clause, etc.
	
-- advanced syntax

USE [IAACE1];  -- have to use when you can't specify database name in the view name
GO

CREATE VIEW [TRN_LA_iB].[v_LA_Contracts_FutureOnly_Covered]

AS
SELECT 
	[Contract ID]
	,[Cov Cust ID]
	,[Covered Customer Name]
	,[Commercial Name]
	,[Licensee ID]
	,[Licensee Name]
	,[Reporting Country]
	,[Contract Status]
	--,[Start Date]
	,CONVERT(CHAR(12),[Start Date], 101) AS [Start Date] --easy to read date
	--,[End Date]
	,CONVERT(CHAR(12),[End Date], 101) AS [End Date] --easy to read date
	,[Products/Terms]
	,[License Countries]
	,[License States/Provinces]
	,[License Cities]
	,[Salesperson]
	,[Sales Region]
	,[Business Type]
	,[Contract Type]
	,[Licensor]
	--,[Approved Date]
	,CONVERT(CHAR(12),[Approved Date], 101) AS [Approved Date] --easy to read date
	,[Products]
	--,[Sales Approver]
	,[Authorized Unit Type]

FROM 
	[IAACE1].[TRN_LA_iB].[LA_Contracts_FutureOnly_Covered]
	
	/* Then to use the view later */
	SELECT * FROM [TRN_LA_iB].[v_LA_Contracts_FutureOnly_Covered]
	--... additional filters in WHERE clause, etc.
