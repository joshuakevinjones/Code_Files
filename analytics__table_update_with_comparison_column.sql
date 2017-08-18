/* Update [IAACE1].[TRN_LA_iB].[LA_Customers] with a new permanent column	
Logic for new column		
CASE WHEN [Primary Address Country] = [Reporting Country] THEN 'True' ELSE 'False' END AS [Address = Reporting]
*/

ALTER TABLE 
	[IAACE1].[TRN_LA_iB].[LA_Customers] 
	ADD [Address = Reporting] VARCHAR(5);

UPDATE 
	[IAACE1].[TRN_LA_iB].[LA_Customers]
SET 
	[Address = Reporting] = CASE WHEN [Primary Address Country] = [Reporting Country] THEN 'True' ELSE 'False' END
FROM 
	[IAACE1].[TRN_LA_iB].[LA_Customers] 
