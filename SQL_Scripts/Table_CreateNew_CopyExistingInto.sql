-- Direct table copy with rename and copy of all data
-- Also creates the new table

SELECT 
* 
	INTO 
	[IAACE1].[dbo].[JKJ_OFAC_AKA_BASE_RESULTS] 
	FROM 
	[IAACE1].[SAP].[OFAC_AKA_BASE_RESULTS];

--TRUNCATE TABLE [IAACE1].[dbo].[JKJ_OFAC_AKA_BASE_RESULTS];

