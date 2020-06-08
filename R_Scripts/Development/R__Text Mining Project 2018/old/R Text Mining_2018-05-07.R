
library(RODBC)
library(data.table)
library(readtext)
library(tm)
library(wordcloud)
library(RWeka)

setwd("S:/Projects/2018 R Text Mining/texts")   # Enter the location of the folder.

#server1 <-odbcDriverConnect('driver={SQL Server};server=CQW-DBS001236.stage.twi.com; database=IAACE1; uid=IAACE1User; pwd=9n5B1RIc')
#d=sqlQuery(server1,"Select * from [IAACE1].[CONCUR].[R_KRI_EMP]")

filelist = list.files(pattern = ".*.txt")
filelist   # Returns the files in the folder


datalist = lapply(filelist, function(x)readtext(x)) 

#datalist

#assuming the same header/columns for all files
datafr = do.call("rbind", datalist) 
View(datafr)
#datafr$text[7]
#write.table(datafr$text[7],"test.txt")

library("doParallel")
doParallel::registerDoParallel(cores = 4)

datacorpus=Corpus(VectorSource(datafr$text))
datacorpus
#inspect(datacorpus)

jeopCorpus=NULL
jeopCorpus <- tm_map(datacorpus, PlainTextDocument)
jeopCorpus <- tm_map(jeopCorpus, tolower)
jeopCorpus <- tm_map(jeopCorpus,removePunctuation)
#jeopCorpus <- tm_map(jeopCorpus, content_transformer(removeMostPunctuation),preserve_intra_word_dashes = TRUE)
jeopCorpus <- tm_map(jeopCorpus, removeNumbers)
jeopCorpus <- tm_map(jeopCorpus, removeWords,stopwords('english'))
jeopCorpus <- tm_map(jeopCorpus, stripWhitespace)
#jeopCorpus <- tm_map(jeopCorpus, stemDocument,language="english")


jeopCorpus.copy=jeopCorpus
doctmtrx=NULL
doctmtrx=DocumentTermMatrix(jeopCorpus.copy)
alarm()
class(doctmtrx)
dtm=as.matrix(doctmtrx)
length(doctmtrx)


length(colSums(as.matrix(doctmtrx)))

word_data_1=as.data.frame(cbind.data.frame(Words = colnames(dtm), freq=colSums(dtm)))
names(word_data_1)
word_data_1 <- word_data_1[order(-word_data_1$freq),]
write.csv(word_data_1,"Summary.csv",row.names=F)

wordcloud(words=colnames(dtm),freq=colSums(dtm),min.freq=2,scale=c(4,0.1),colors=brewer.pal(n=10,"Paired"),random.order=F)



# To find the top N words - Here N is the threshold freq
findMostFreqTerms(doctmtrx) #Gives most frequent occuring words in each document
findFreqTerms(doctmtrx, 100) #atleast frequency of 100

#################### Bigrams and Trigrams #########################
library(tau)
bigrams = textcnt(datafr$text, n = 2, method = "string")
bigrams = bigrams[order(bigrams, decreasing = TRUE)]
View(bigrams)
fwrite(as.data.frame(bigrams),row.names = T,file = "Bigrams.csv") #This is to write the Bigram Summmary into an excel file.


trigrams = textcnt(datafr$text, n = 3, method = "string")
trigrams = trigrams[order(trigrams, decreasing = TRUE)]
fwrite(as.data.frame(trigrams),row.names = T,file = "Trigrams.csv") #This is to write the Trigram Summmary into an excel file.

