/* find duplicates in an id table */

SELECT 
o.orgName, oc.dupeCount, o.id
FROM
organizations o
INNER JOIN
	(
		SELECT orgName, COUNT(*) AS dupeCount
		FROM organizations
		GROUP BY orgName
		HAVING COUNT(*) > 1
	) oc 
	ON o.orgName = oc.orgName