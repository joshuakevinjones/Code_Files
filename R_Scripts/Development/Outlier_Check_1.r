
getwd()
setwd("//ad.corp.aoltw.net/timewarner/users/SenJoydeep/AppSenseHome/My Desktop/Time Warner/R folder")


# Required for RODBC connection

library(RODBC)


#connect to server
server1<-odbcDriverConnect('driver={SQL Server};server=CQW-DBS001236.stage.twi.com; database=IAACE1; uid=IAACE1User; pwd=9n5B1RIc')

Details<-sqlQuery(server1,"select * from IAACE1.CONCUR.EXPENSE_DETAIL")

View(Details)
all_unit = Details[,c("Org Unit 1 - Name","Expense Amount (rpt)","Spend Category")]    
names(all_unit) = c("Org_Unit1_Name","Expense_Amount","Spend_Category")

cl = function(all_unit)
{
  
  LCL = mean(all_unit[ , "Expense_Amount"], na.rm=T) - 2* sd(all_unit[ , "Expense_Amount"], na.rm=T)
  UCL = mean(all_unit[ , "Expense_Amount"], na.rm=T) + 2* sd(all_unit[ , "Expense_Amount"], na.rm=T)
  return(data.frame(LCL,UCL))
  
}

library(plyr)

l2=ddply(all_unit, .(Org_Unit1_Name,Spend_Category), cl)

all_unit <- merge(all_unit,l2, by.x = c("Org_Unit1_Name","Spend_Category"))

View(all_unit)

summary(all_unit)

plotFn <- function(dataset,Spend)
{
  data_spend <- dataset[dataset[,"Spend_Category"]==Spend,]
  par(mfrow=c(2,2))
  for( i in levels(data_spend[,"Org_Unit1_Name"]))
  {
      plot(data_spend[data_spend[,"Org_Unit1_Name"]==i,"Expense_Amount"],ylab = "Expense Amount",main = i,pch =19 , col="blue")
      abline(h = data_spend[data_spend[,"Org_Unit1_Name"]==i,"LCL"] ,col="red",lwd=2)
      abline(h = data_spend[data_spend[,"Org_Unit1_Name"]==i,"UCL"] ,col="red",lwd=2)
  }

}


par(mfrow=c(1,1))
plotFn(all_unit,"Airfare")

bwplot(~Expense_Amount|Org_Unit1_Name+Spend_Category,data=all_unit)

test15<- sqlQuery(server1,"select  DISTINCT[Spend Category] from IAACE1.CONCUR.EXPENSE_DETAIL")

View(test15)

b <- Details[,c("Org Unit 1 - Name","Expense Amount (rpt)","Spend Category")] 
names(b) = c("Org_Unit1_Name","Expense_Amount","Spend_Category")
View(a)

summary(b)

View(a)

new1 <- mapvalues(b$Org_Unit1_Name,
                  from = c("Home Box Office","Time Warner Corporate","Turner Broadcasting System","Warner Bros."), 
                           to = c("HBO","TWC","TBS","WB"))




new2 <- mapvalues(b$Spend_Category,
                  from = c("Advertising/Marketing","Airfare", "Car Rental","Cash Advance - Standard",
                           "Company Car - Mileage Reimbursement","Computer","Entertainment","Fees/Dues",
                           "Gas","Ground Transportation","Lodging - Do Not Track Room Rate Spending",
                           "Lodging - Track Room Rate Spending","Meal","Meal - Count in Daily Meal Allowance",
                           "Meetings","Other","Personal Car - Mileage Reimbursement","Rail","Shipping","Subscription/Publication",
                           "Telecom","Trade/Convention","Training"), to = c("Adver","Air","Car_rental","Cash_adv","Company_car","computer",
                                                                            "Enter","Fees","Gas","Ground_T","Lodging_Do_not",
                                                                            "Lodging_Do","Meal","Meal_count","Meetings","Other",
                                                                            "Personal_car","Rail","Shipp","Subscription","Telecom",
                                                                            "Trade","Training"))
unique(b$Spend_Category)
























