# df cuts

# create some simulated data
ID <- 1:10
Age <- c(26, 65, 15, 7, 88, 43, 28, 66 ,45, 12)
Sex <- c(1, 0, 1, 1, 0 ,1, 1, 1, 0, 1)
Weight <- c(132, 122, 184, 145, 118, NA, 128, 154, 166, 164)
Height <- c(60, 63, 57, 59, 64, NA, 67, 65, NA, 60)
Married <- c(0, 0, 0, 0, 0, 0, 1, 1, 0, 1)

# create a dataframe of the simulated data
mydata <- data.frame(ID, Age, Sex, Weight, Height, Married)

# cut up Age and label each category
mydata$Agecat1<-cut(mydata$Age, c(0,5,10,15,20,25,30,40,50,60,70,80), labels=c(1:11))

	mydata$Agecat2<-cut(mydata$Age, breaks=10, labels=c(1:10))

# it is a factor
class(mydata$Agecat1)
[1] "factor"