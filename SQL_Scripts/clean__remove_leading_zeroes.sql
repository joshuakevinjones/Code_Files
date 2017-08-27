/* remove leading zeros from field */

SUBSTRING([FIELD_W_Zero], PATINDEX('%[^0]%', [FIELD_W_Zero]+'.'), LEN([FIELD_W_Zero]))
