attach(data)



## generic syntax
aggdata <- aggregate(data, by = list(Year, Descr), FUN = sum, na.rm = TRUE)



## specific example syntax

```{r}
aggdata <- aggregate(MyData$Gross.MTD, by=list(MyData$Year, MyData$Descr), FUN=sum, na.rm=TRUE)
```




## Test case


MyData <- read.csv(file.choose(), stringsAsFactors = FALSE, header = TRUE, sep = ",")


table(MyData$Descr, MyData$Year) # frequency count of earnings codes across years
 across years
xtabs(Gross.MTD ~ Descr+Year, data = MyData) # $ sum of balances in earnings codes across years
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTkyMjM2OTk3OV19
-->