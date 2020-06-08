
# -- ============================================================
# -- Author / Project		Josh Jones / n/a
# -- 2018/06/20			
# -- Write a data frame to csv w/ options			

#	
#	

# -- ============================================================


# ****************************************************************
# change history


# ****************************************************************

# write.table()

write.csv(
	x, # x is the data frame
	# file = "",
	  # effective use
	  file = file.choose(new = T),
	append = FALSE,
	quote = TRUE,
	sep = " ",
	    eol = "\n", na = "NA", dec = ".", row.names = TRUE,
        col.names = TRUE, qmethod = c("escape", "double"),
        fileEncoding = "")

# usage example

data(iris)

write.csv(
  iris,
  file = file.choose(new = T),
  append = FALSE,
  quote = TRUE,
  sep = " ",
  eol = "\n", na = "NA", dec = ".", row.names = TRUE,
  col.names = TRUE, qmethod = c("escape", "double"),
  fileEncoding = "")


