SELECT 
contracts.[Contract ID], Count(contracts.[Contract ID]) AS ['Count']
FROM LA_Contracts contracts
GROUP BY contracts.[Contract ID]
HAVING COUNT(contracts.[Contract ID]) > 1;