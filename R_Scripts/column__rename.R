# -- ============================================================
# -- Josh
# -- no project
# -- 2018/07/17			
# -- Ways to rename a column (or columns)			

#	comments go here	
#	

# -- ============================================================

# rename a single column

# Rename a column in R
colnames(data)[colnames(data)=="old_name"] <- "new_name"

# -- ============================================================

# rename > 1 column at a time

library(data.table)
setnames(data, old=c("old_name","another_old_name"), new=c("new_name", "another_new_name"))

# -- ============================================================

library(dplyr)

names(cars)

# renames the speed column to "new"
cars %>% rename_at("speed",~"new") %>% head     
cars %>% rename_at(vars(speed),~"new") %>% head
cars %>% rename_at(1,~"new") %>% head