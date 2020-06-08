data <- read.csv(file.choose())

library(dplyr)
library(tidyr)

# 22:125 are the columns to gather 
data2 <- data %>% gather("Measure", "Value", 22:125)
