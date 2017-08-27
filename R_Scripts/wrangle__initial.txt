# Explore data
attributes(MyData)
names(MyData)
typeof(MyData)
is.data.frame(MyData)
str(MyData)
head(MyData)
summary(MyData)

# check to make sure columns are the correct type
sapply(data, class)

# Prep / clean data
data <- na.omit(MyData) # listwise deletion of missing
data2 <- scale(MyData$Gross.YTD) # standardize variables