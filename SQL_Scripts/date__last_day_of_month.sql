

--date
--last day of month

SELECT DAY(DATEADD(d, -DAY(DATEADD(m,1,GETDATE())),DATEADD(m,1,GETDATE())))