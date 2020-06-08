/***************************************************************
<formula_Excel__extract_nums_from_string>

--<source>	: https://www.extendoffice.com/documents/excel/1622-excel-extract-number-from-string.html
--<date>	: 2017/10/22
--<descr>	: array formula for extracting all number elements from a string

****************************************************************
change history


***************************************************************/

A2 below is the cell with the string from which you want to extract numbers

=SUMPRODUCT(MID(0&A2,LARGE(INDEX(ISNUMBER(--MID(A2,ROW($1:$25),1))* ROW($1:$25),0),ROW($1:$25))+1,1)*10^ROW($1:$25)/10)