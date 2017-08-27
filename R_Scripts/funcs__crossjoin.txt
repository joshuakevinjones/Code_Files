# this assumes that you have unique lists of members in each column of an Excel file

# read in data
df <- read.csv()
	# read_csv
	
# read each list of group members into its own variable
# you are reading each data frame column into its own variable
a <- as.character(na.omit(df$A))
b <- as.character(na.omit(df$B))
c <- as.character(na.omit(df$C))
d <- as.character(na.omit(df$D))
e <- as.character(na.omit(df$E))
f <- as.character(na.omit(df$F))

# do the crossjoin in R
cj <- expand.grid(b,c,d,e,f,a)

# write the results back to a csv
write.csv( cj, file.choose(), row.names=FALSE )