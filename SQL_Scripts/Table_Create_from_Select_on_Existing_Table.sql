--Creating table SEC_INTERNAL_AUDIT

--creating table with selected results from another table
--could use to filter, etc.

SELECT DISTINCT 
	 [Empl ID]
	,[Dept Descr]

INTO 
[IAACE1].[TRNPAY].[SEC_INTERNAL_AUDIT]

FROM 
[IAACE1].[TRNPAY].[BASE_JOB_INFO_DETAIL]

WHERE 
[Dept Descr] = 'Internal Audit'
