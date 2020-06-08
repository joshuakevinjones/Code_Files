
/*
[Bill Date] starts in Excel's proprietary serial number format
*/

CONVERT(CHAR(12), CAST([<INSERT DATE HERE>] - 2 AS smalldatetime), 101) [<Name of Date Field>]