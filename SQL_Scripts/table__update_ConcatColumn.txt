-- Putting a space after comma(,) in the ComboField_C field

UPDATE 
	[IAACE1].[TRNPAY].[BASE_JOB_INFO_DETAIL]

SET [ComboField_C] = CONCAT([Action Descr],', ',[Reason Descr]);