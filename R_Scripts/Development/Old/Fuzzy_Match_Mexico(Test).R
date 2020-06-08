# every operation comes from one package (stringdist)
require(stringdist)
library(stringdist)

# load test data
data <- read.csv(file.choose(), na.strings=c("", "NA"))
names(data)
names(data[1])
a <- as.character(data$nombrelegal..Translated.)
b <- as.character(na.omit(data$Vendor_Account.Keywords))

#rm(d)
  
# crossjoin entries from a and b to create format for comparison
d <- expand.grid(a, b)

# rename a and b (just placeholders for now)
names(d) <- c("a_name", "b_name")

# create new columns and append to existing df
d$osa <- stringdist(d$a_name, d$b_name, method="osa")
d$lv <- stringdist(d$a_name, d$b_name, method="lv")
d$dl <- stringdist(d$a_name, d$b_name, method="dl")
d$ham <- stringdist(d$a_name, d$b_name, method="hamming")
d$lcs <- stringdist(d$a_name, d$b_name, method="lcs")
d$qgram <- stringdist(d$a_name, d$b_name, method="qgram")
d$cos <- stringdist(d$a_name, d$b_name, method="cosine")
d$jac <- stringdist(d$a_name, d$b_name, method="jaccard")
d$jw <- stringdist(d$a_name, d$b_name, method="jw")
d$sdx <- stringdist(d$a_name, d$b_name, method="soundex")

greedyAssign <- function(a,b,d){
  x <- numeric(length(a)) # assgn variable: 0 for unassigned but assignable, 
  # 1 for already assigned, -1 for unassigned and unassignable
  while(any(x==0)){
    min_d <- min(d[x==0]) # identify closest pair, arbitrarily selecting 1st if multiple pairs
    a_sel <- a[d==min_d & x==0][1] 
    b_sel <- b[d==min_d & a == a_sel & x==0][1] 
    x[a==a_sel & b == b_sel] <- 1
    x[x==0 & (a==a_sel|b==b_sel)] <- -1
  }
  cbind(a=a[x==1],b=b[x==1],d=d[x==1])
}
y_osa <- data.frame(greedyAssign(as.character(d$a_name),as.character(d$b_name),d$osa))
y_lv <- data.frame(greedyAssign(as.character(d$a_name),as.character(d$b_name),osa$dist))


