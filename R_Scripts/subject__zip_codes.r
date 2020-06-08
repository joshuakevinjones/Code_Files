install.packages("zipcode")
library(zipcode)
data(zipcode)

zip <- as.data.frame(zipcode)
write.csv(zip, "zip_codes.csv")