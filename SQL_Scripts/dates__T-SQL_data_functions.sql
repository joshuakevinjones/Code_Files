
/* T-SQL Date Functions   */

GETDATE()

Select getdate() as currentdatetime

DATEPART(datepart, datecolumnname)

	Select datepart(day, getdate()) as currentdate

	Select datepart(month, getdate()) as currentmonth

DATEADD()

	-- returns a new datetime value based on adding an interval to the specified date

	DATEADD(datepart, number, datecolumnname)

	Select dateadd(day, 10, getdate()) as after10daysdatetimefromcurrentdatetime 


DATEDIFF()

	-- returns the number of date and time boundaries crossed between two specified dates

	DATEDIFF(datepart, startdate, enddate)

	Select datediff(hour, 2015-11-16, 2015-11-11) as differencehoursbetween20151116and20151111

CONVERT()

	CONVERT(datatype, expression, style)

	SELECT CONVERT(VARCHAR(19),GETDATE()) 
	SELECT CONVERT(VARCHAR(10),GETDATE(),10) 
	SELECT CONVERT(VARCHAR(10),GETDATE(),110)
