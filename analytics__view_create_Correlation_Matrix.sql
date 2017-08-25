/* Create a summary correlation table

The summary information will have the following columns:
Account 1 : This is the account number.
Account 2 : This is the account number for the co-occurring account.
Account 1 Total Times : the number of times Account 1 occurs in the data
No. of Times Together : the number of times the accounts occur together
Percentage : the % of times the two accounts occur together */

USE [IAACE1]
GO

/****** Object:  View [TRN_PS].[v_JRNL_HDR_LN_CORR]    Script Date: 6/8/2017 1:45:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE view [TRN_PS].[v_JRNL_HDR_LN_CORR] AS
SELECT 	 
		 x.[Account 1]
		,y.[Account 2]
		,x.[Account 1 Total Times] AS [Account 1 Count]
		,y.[No. of Times Together] AS [Accounts Count Together]
		,CAST(y.[No. of Times Together] AS float)/cast(x.[Account 1 Total Times] AS float) AS [Pct Together]
from 
	(SELECT [Account 1], COUNT(*) AS [Account 1 Total Times]
	FROM 
		(
		SELECT DISTINCT 
			 a.[JOURNAL_ID]
			,a.[Account] AS [Account 1]
			,b.[Account] AS [Account 2]

		FROM [IAACE1].[TRN_PS].[JRNL_HDR_LN] a
		INNER JOIN
			[IAACE1].[TRN_PS].[JRNL_HDR_LN] b
		ON 
			a.[JOURNAL_ID]=b.[JOURNAL_ID]
			AND a.[Account]<>b.[Account]
			) a
		GROUP BY [Account 1]
	) x

INNER JOIN

(
SELECT 	
	 [Account 1]
    ,[Account 2]
	,COUNT(DISTINCT [JOURNAL_ID]) AS [No. of Times Together]
FROM 
	(
	SELECT 	
		 a.[JOURNAL_ID]
		,a.[Account] AS [Account 1]
		,b.[Account] AS [Account 2]

	FROM 
		[IAACE1].[TRN_PS].[JRNL_HDR_LN] a
	INNER JOIN
		[IAACE1].[TRN_PS].[JRNL_HDR_LN] b
	ON 
		a.[JOURNAL_ID]=b.[JOURNAL_ID]
		AND 
		a.[Account]<>b.[Account]
	) a
GROUP BY 
	[Account 1],[Account 2]
	) y
ON x.[Account 1]=y.[Account 1];

GO