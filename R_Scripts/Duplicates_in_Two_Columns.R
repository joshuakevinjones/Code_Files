# every operation comes from one of these packages
require(dplyr)
require(stringdist)

# load test data (2 separate data frames to compare against each other)
a <- data.frame(name=c('Josh','John', 'Chad', 'Steve', 'Peter'))
b <- data.frame(name=c('Josh','John', 'Chad', 'Steve', 'Peter', 'osh', 'ohn', 'had', 'eve', 'reteP'))

# stack columns into a single column
c <- rbind(a, b)

# clean source columns
rm(a,b)

#str(c)

# build boolean filter vector for duplicates
duplicated(c$name)

# show duplicates
filter(c, duplicated(c$name) == TRUE)
