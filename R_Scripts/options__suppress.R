
# -- ============================================================
# -- Josh
# -- no project
# -- 2018/07/17			
# -- suppress warnings globally			

#	comments go here	
#	

# -- ============================================================

# expression
suppressWarnings(expr)

  # example usage
    suppressWarnings(library(dplyr))

# do it globally
options(warn = -1)

# turn it back on
options(warn = 0)


# related
suppressForeignCheck()
suppressMessages()
suppressPackageStartupMessages()
