fin <- read.csv(file.choose(), na.strings=c(""))
head(fin)

#sub() and gsub()
x <- head(fin)
x$Expenses <- gsub(" Dollars", "", x$Expenses)
x$Expenses <- gsub(",", "", x$Expenses)
x$Revenue <- gsub("[:punct:]", "_", x$Revenue)
x$Revenue <- gsub("[^[:alnum:][:blank:]+?&/\\-]", "", x$Revenue)
x$Growth <- gsub("[^[:alnum:][:blank:]+?&/\\-]", "", x$Growth)
x

head(fin, 24)
miss <- fin[!complete.cases(fin),]

statena <-  fin[is.na(fin$State), ]
head(statena)
