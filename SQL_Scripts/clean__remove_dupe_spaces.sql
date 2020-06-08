
-- clean__remove_dupe_spaces

-- before

[HDR_DESCR]
--VISA EXPENSES                  - RELOCATION

-- after

[HDR_DESCR] = REPLACE(REPLACE(REPLACE([HDR_DESCR],' ','<>'),'><',''),'<>',' ')
--VISA EXPENSES - RELOCATION