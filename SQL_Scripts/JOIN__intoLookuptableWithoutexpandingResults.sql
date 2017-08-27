
/* 
LEFT JOIN into a lookup table with duplicate key values and take the first value found.
Business purpose is to prevent data expansion when joining into a field with multiple lookup values.
*/


/* Example 1 : CF1_NS_VW (called a) is the lookup table*/

LEFT JOIN 
	(
	SELECT [CF1], [CF1Descr]
	FROM
		(
		SELECT [CF1], [CF1Descr], ROW_NUMBER() OVER(PARTITION BY [CF1] ORDER BY [CF1Descr]) rnk --establishes rnk 
  		FROM [IAACE1].[TRN_PS].[CF1_NS_VW]) a -- establishes a
  		WHERE rnk=1) k -- establishes k (the lookup table)
ON a.CHARTFIELD1 = k.CF1

/* Example 2 : CF2_NS_VW (called a) is the lookup table*/

LEFT JOIN 
	(
	SELECT [ProjectCF2], [CF2Descr]
	FROM
		(
		SELECT [ProjectCF2], [CF2Descr], ROW_NUMBER() OVER(PARTITION BY [ProjectCF2] ORDER BY [CF2Descr]) rnk -- establishes rnk
		FROM [IAACE1].[TRN_PS].[CF2_NS_VW]) a --establishes a
		WHERE rnk = 1) l -- establishes l (the lookup table)
ON a.CHARTFIELD2 = l.ProjectCF2