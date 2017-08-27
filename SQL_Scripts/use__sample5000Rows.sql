  SELECT * FROM [IAACE1].[TRN_PS].[v_JRNL_HDR_LN] /* Table Name */
  WHERE 
  	(ABS(CAST(
  		(BINARY_CHECKSUM(*) *
  		RAND()) as int)) % 100) < 9

  /* Trying to select < 5,000 random rows from a table */