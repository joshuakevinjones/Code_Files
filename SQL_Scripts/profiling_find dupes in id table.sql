/* find duplicates in an id table */

select o.orgName, oc.dupeCount, o.id
from organizations o
inner join (
    SELECT orgName, COUNT(*) AS dupeCount
    FROM organizations
    GROUP BY orgName
    HAVING COUNT(*) > 1
) oc on o.orgName = oc.orgName