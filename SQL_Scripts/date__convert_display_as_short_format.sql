/*
Probably want to update this with more date convert options

*/

--without
[Start Date]
--2006-03-01 00:00:00.000

--with
CONVERT(CHAR(12),[Start Date], 101) AS [Start Date]
--03/01/2006  