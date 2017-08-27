/*************************************************************************************************
Purpose:	To concatenate the values of a column in all rows into one row.
Author:
Tested on:
Date:
Notes:
*************************************************************************************************/

CREATE VIEW [TRN_PS].[v_CF1_NS_VW] AS

SELECT 
	CF1, CF1Descr = 
    	STUFF((SELECT DISTINCT ', ' + CF1Descr
        	FROM IAACE1.TRN_PS.CF1_NS_VW b 
        	WHERE b.CF1 = a.CF1 
        	FOR XML PATH('')), 1, 2, '')

FROM IAACE1.TRN_PS.CF1_NS_VW a
GROUP BY CF1

/*
alternate code to text */
USE pubs
GO
DECLARE @title_ids varchar(150), @delimiter char
SET @delimiter = ','
SELECT @title_ids = COALESCE(@title_ids + @delimiter, '') + title_id FROM titles
SELECT @title_ids AS [List of Title IDs]