/* IF THEN logic within a SELECT

Product table
An item is "Saleable" if that item meets at least one of two conditions (Obsolete = 'N' OR Instock = 'Y')

 */

-- Case statement (provides bit data type)

SELECT CAST(
	CASE 
		WHEN Obsolete = 'N' or InStock = 'Y' 
			THEN 1 
		ELSE 0 
	END AS bit) as Saleable, * 
FROM Product

-- Case statement (provides int)
SELECT CASE 
            WHEN Obsolete = 'N' or InStock = 'Y' 
               THEN 1 
               ELSE 0 
       END as Saleable, * 
FROM Product

-- IIF statement
SELECT IIF(Obsolete = 'N' or InStock = 'Y', 1, 0) as Saleable, * FROM Product
