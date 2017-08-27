require(odbcConnect)
server1 <-odbcConnect("IAACE1", uid="GhoshAnirban", pwd="Password@123")


d<-sqlQuery(server1,"select * from [IAACE1].[AntiCorr].[VP_Contacts] where 
            [Nature of Contact] is not Null")
head(d)
#Expense_details<-sqlQuery(server1,"select * from IAACE1.CONCUR.EXPENSE_DETAIL")

d$Nature_of_Contact<-d$`Nature of Contact`

x <- d$Nature_of_Contact

attach(d)

#docs1 =Corpus(VectorSource(Comment))

#head(docs1)


Nature_of_Contact = as.data.frame(d$Nature_of_Contact)

# check for NA(missing) values
any(is.na(Nature_of_Contact))
which(is.na(Nature_of_Contact))
thir_party=na.omit(Nature_of_Contact)
head(Nature_of_Contact)

#create a function 

remove=function(x){
  x = gsub("@","",x)
  x = gsub("!","",x)
  x = gsub("?","",x)
  x = gsub("review","",x)
  x = gsub("please","",x)
  x = gsub("report","",x)
  x = gsub("expenses","",x)
  x = gsub("thanks","",x)
  x = gsub("email","",x)
  x = gsub("attach","",x)
  x = gsub("also","",x)
  x = gsub("Please","",x)
  x = gsub("need","",x)
  x = gsub("sent","",x)
  x = gsub("Per","",x)
  x = gsub("approval","",x)
  x = gsub("thanks","",x)
  x = gsub("thank","",x)
  return(x)
}

library(plyr)



clean_Nature_of_Contact=apply(Nature_of_Contact,2,remove)
head(clean_Nature_of_Contact)

library(tm)

Nature_of_Contact_corp =Corpus(VectorSource(clean_Nature_of_Contact))
#cmment_corp =Corpus(VectorSource(Comment))

#clean

Nature_of_Contact_corp <- tm_map(Nature_of_Contact_corp,tolower)
Nature_of_Contact_corp <- tm_map(Nature_of_Contact_corp,removeWords, stopwords("english"))
Nature_of_Contact_corp <- tm_map(Nature_of_Contact_corp,removeNumbers)
Nature_of_Contact_corp <- tm_map(Nature_of_Contact_corp,removePunctuation)
Nature_of_Contact_corp_fin <- tm_map(Nature_of_Contact_corp,stripWhitespace)
corpus_clean <- tm_map(Nature_of_Contact_corp_fin, PlainTextDocument)

dtm <- DocumentTermMatrix(corpus_clean)

#############################CHECK###############################

dtm <- removeSparseTerms(dtm, 0.99)
rowTotals <- apply(dtm , 1, sum) #Find the sum of words in each Document
dtm   <- dtm[rowTotals> 0, ] #Remove all docs without words


# install.packages("bigmemory")
# library(bigmemory)
# library(bigmemory.sri)
# 
# dtm_trans = t(dtm)
# 
# M = as.big.matrix(x=as.matrix(dtm_trans))
# 
# install.packages("Matrix")
# library(Matrix)
# 
# mat = sparseMatrix(i=dtm$i , j=dtm$j , x = dtm$v , dims=c(dtm$nrow,dtm$ncol))
# mat_n = as.matrix(mat)
#   
#   tdm <- TermDocumentMatrix(corpus_clean,
#                           control = list(weighting = weightTfIdf,
#                                          stopwords = TRUE))
# library(Matrix)
# Dense <- sparseMatrix(dtm$i,dtm$j,x=dtm$v)
# dense <- as.matrix(dtm)
##########################################################
gc()

head(dtm)
str(dtm)
#install.packages("wordcloud",dependencies=TRUE)
library(wordcloud)

memory.limit()
memory.limit(size=4000)


m <- as.matrix(dtm)
head(m)

v <- sort(colSums(m),decreasing=TRUE)

nrow(v)

x = head(v,100)
words <- colnames(data.frame(v))
words = names(x)

d <- data.frame(word=words, freq=x)
write.csv(d, "C:\\Users\\GhoshAnirban\\Desktop\\New folder\\Anticorr\\wordlist_Nature_of_Contact.csv")
wc = wordcloud(d$word,d$freq)
