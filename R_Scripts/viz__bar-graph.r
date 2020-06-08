# Bar Graph

# load the ggplot2 library
library(ggplot2)

# plot an item from the iris dataset
qplot(iris$Sepal.Length, geom="bar", stat="identity")


# Convert the x variable to a factor, so that it is treated as discrete
qplot(factor(iris$Sepal.Length), geom="bar", stat="identity")
