-- ============================================================
-- Author / Project		Payroll (Time Warner, Inc.)
-- Create Date			
-- Description			
/*
	Ways to create a new table by copying an existing table	
	or copying the results of a subset on an existing table
*/
-- ============================================================

-- create table with selected / filtered results from another existing table
	--could use to filter, etc.

SELECT DISTINCT 
	[Empl ID],
	[Dept Descr]

INTO 
[IAACE1].[TRNPAY].[SEC_INTERNAL_AUDIT]

FROM 
[IAACE1].[TRNPAY].[BASE_JOB_INFO_DETAIL]

WHERE 
[Dept Descr] = 'Internal Audit'

-- direct table copy with rename and copy of all data
	-- Also creates the new table
	-- no filtering
	
SELECT * 
	INTO [IAACE1].[dbo].[JKJ_OFAC_AKA_BASE_RESULTS] 
FROM [IAACE1].[SAP].[OFAC_AKA_BASE_RESULTS]

--TRUNCATE TABLE [IAACE1].[dbo].[JKJ_OFAC_AKA_BASE_RESULTS];