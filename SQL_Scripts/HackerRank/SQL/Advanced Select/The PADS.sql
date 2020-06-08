/* The PADS */

SELECT
	Name+"("+UPPER(LEFT(Occupation, 1))+")"

FROM
	OCCUPATIONS
	
ORDER BY
	Name ASC;
	
SELECT
	CONCAT ('There are a total of ',Count(*),' ',LOWER(Occupation),'s.')

FROM
	OCCUPATIONS

GROUP BY
	Occupation
	
ORDER BY
	COUNT(*) ASC;