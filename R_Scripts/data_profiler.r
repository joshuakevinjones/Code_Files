options(scipen=999)

# Load packages

x <- c("dplyr", "RODBC", "tidyverse", "ggplot2")
lapply(x, require, character.only = TRUE)


# connect to database
channel <- odbcDriverConnect('driver={SQL Server};server=CQW-DBS001236.stage.twi.com; database=IAACE1; uid=IAACE1User; pwd=9n5B1RIc')

# Check that connection works
odbcGetInfo(channel)

df <- sqlQuery(channel, 
"            
SELECT 
*
FROM [IAACE1].[TRN_PS].[v_JRNL_HDR_LN]              
"
);

# look at variable types
str(df)

df$`Bus Unit` <- as.character(df$`Bus Unit`)
df$`Alt Acct` <- as.character(df$`Alt Acct`)
df$`Account` <- as.character(df$`Account`)
df$`Bus Unit Interunit` <- as.character(df$`Bus Unit Interunit`)
df$`Class Field` <- as.character(df$`Class Field`)

df. <- df[,colSums(is.na(df))<nrow(df)] # remove columns in which all values are blank

str(df.)

#df.$`Bus Unit Interunit` <- as.factor(df.$`Bus Unit Interunit`)
cols <- c("")


library(xda)

xda::numSummary(df)
xda::charSummary(df)

library(ggplot2)

# eda on journal lines by journal id
ggplot(df, aes(x=`Jrnl Tot Lines`)) + geom_density()

ggplot(df, aes(x=`Amount`)) + geom_density()

#histFactor <- as.factor(df$`Account Descr`)
#hist(table(histFactor), freq=TRUE, xlab = levels(histFactor), ylab = "Frequencies")

barplot(prop.table(table(df$`Account Descr`)))

str(df)
dim(df)
