/*Update [IAACE1].[TRN_LA_iB].[LA_Customers] with a new permanent column .This will be the first column in the table.
Place a row number index starting at 1 and going to the final row of the table
*This will serve as a check for when we do data operations on the table in the future.*/


ALTER TABLE [IAACE1].[TRN_LA_iB].[LA_Billing_Transactions] 
ADD [Row_Num] INT;


UPDATE a
SET a.[Row_Num]=b.[Row_Num]
FROM [IAACE1].[TRN_LA_iB].[LA_Billing_Transactions] a
INNER JOIN
(SELECT	[AR Transaction ID],
		row_number() over(ORDER BY [AR Transaction ID]) AS [Row_Num]
		FROM [IAACE1].[TRN_LA_iB].[LA_Billing_Transactions]
) b
ON a.[AR Transaction ID]=b.[AR Transaction ID];