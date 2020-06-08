DECLARE @path varchar(256),
        @currPeriod varchar(25),
        @pastPeriod varchar(25),
        @period varchar(25),
        @fileName varchar(256),
        @sheet varchar(25),
        @sql varchar(MAX)

SET     @path = 'H:\Scripts\DataImport';
SET     @currPeriod = CONCAT(DATEPART(year,GETDATE()),'-',CONVERT(varchar(2), getdate(), 101));
SET     @pastPeriod =  CONCAT(DATEPART(year,DateAdd(month, -1, Convert(date, GETDATE()))),'-',CONVERT(varchar(2), DateAdd(month, -1, Convert(date, GetDate())), 101));
SET     @period = @pastPeriod;  -- Change to currPeriod or pastPeriod based on import type.
SET     @fileName = 'ReferenceClients-' + @period + '.xlsx';
SET     @sheet = '[Sheet1$]';

select @path, @currPeriod, @pastPeriod, @period, @fileName, @sheet