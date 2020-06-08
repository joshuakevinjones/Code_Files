# -- ============================================================
# -- Author / Project		Josh J.
# -- 2019/04/05			
# -- Keep and remove columns from data frame			

#	Ways to create a new table by copying an existing table	
#	or copying the results of a subset on an existing table

# -- ============================================================

# ****************************************************************
# change history
# ***************************************************************/


drops <- c("Division", "Region", "District", "Wk_End_Dt")
df1 <- df[ , !(names(df) %in% drops)]

keeps <- c("Store", "pct_complete", "pct_utilization")
df_clust <- df[ , (names(df) %in% keeps)]