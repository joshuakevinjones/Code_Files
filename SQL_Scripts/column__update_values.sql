/***************************************************************
<category__file_name>

--<source>	:
--<date>	: 2017/10/22
--<descr>	: update values in column base on column value

****************************************************************
change history


***************************************************************/

UPDATE table_name
SET 
	column_name_1 = new_value_1, 
	column_name_2 = new_value_2

WHERE column_name = some_value

-- example

UPDATE table_dictators
SET
	Address = 'Baghdad'
	
WHERE LastName = 'Hussein'

-- example from TW ACE PeopleSoft Project

  USE IAACE1
  GO

  UPDATE TRN_PS.[JRNL_HDR_LN_SUM]
  SET ACE_PROJECT_ID = 'ACE_TRN_PS_NBA'
  WH ACE_PROJECT_ID = 'TRN_PS'