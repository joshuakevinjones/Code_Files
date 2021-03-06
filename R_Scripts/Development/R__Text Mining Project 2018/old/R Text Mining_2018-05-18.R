---
  title: 'ACE: Text Mining Analytics Project'
---
  
```{r include=FALSE}

# load the packages all in one go
x <- c("RODBC", "data.table", "readtext", "tm", "wordcloud", "tidytext", "doParallel", "tau", "quanteda", "stringr", "ggplot2", "dplyr")
lapply(x, require, character.only = TRUE)

doParallel::registerDoParallel(cores = 4)   # loads doParallel package    

```

```{r include=FALSE}  
# setup for working directory  
#setwd(choose.dir())  # alternate way to choose the folder
setwd("C:\\Users\\jonesjosh\\OneDrive - Time Warner\\Code_Files\\R_Scripts\\Development\\R__Text Mining Project 2018\\texts")

```

### Directory folder location for the analysis files
```{r Directory}
getwd()
```

```{r Database Connection, include=FALSE}
# Setup for database connection (use only if needed)
#server1 <-odbcDriverConnect('driver={SQL Server};server=CQW-DBS001236.stage.twi.com; database=IAACE1; uid=IAACE1User; pwd=9n5B1RIc')

```

```{r Custom functions, include=FALSE}
## Setup for special functions used in the analysis
# custom function to strip empty columns.  used in the sentiment analysis section below
has_data <- function(x) { sum(!is.na(x)) > 0 }

```

```{r List and process files, include=FALSE}

# set folder to read
folder_to_read <- "C:\\Users\\jonesjosh\\OneDrive - Time Warner\\Code_Files\\R_Scripts\\Development\\R__Text Mining Project 2018\\texts"

# check
folder_to_read

# 
file_list <- list.files(
  path = "C:\\Users\\jonesjosh\\OneDrive - Time Warner\\Code_Files\\R_Scripts\\Development\\R__Text Mining Project 2018\\texts",
  #folder_to_read, # JKJ ~ need to fix so that we can let user specify file path
  pattern = ".txt", # JKJ 2018/05/09 ~ need to make sure we can read Word and PDF too
  all.files = FALSE, 
  full.names = FALSE, 
  recursive = TRUE, 
  ignore.case = FALSE, 
  include.dirs = TRUE, 
  no.. = FALSE)

```

### Files included in this analysis
```{r}
# List of files that were read in
file_list   # Returns the files in the folder

```

```{r include=FALSE}
# TO DO: ignore for now
# make any adjustments to file_list after checking (i.e. remove unwanted files)

```

```{r include=FALSE}

# reads in the files using the readtext package
datalist <- lapply(file_list, function(x) readtext(x))  # datalist is a list object

# check
#str(datalist)  # datalist is a list of data frames
#head(datalist)  # shows the documents as 1x2 data frames

# combine all the datalist items into a single object
datafr = do.call("rbind", datalist) 

rm(datalist)  # clean up, datalist has been replaced with datafr

# check
#head(datafr)  # datafr is a data frame with two columns: doc_id and text
str(datafr)
#datafr$text[7]
#write.table(datafr$text[7],"test.txt")
```

```{r Cleaning text and creating the corpus, include=FALSE}      

# test for replacing garbage strings / characters  
gsub("the", "", datafr$text)
gsub("�", "", datafr$text)

# clear the console
cat("\014")

# creates a data corpus from the text column of the datafr data frame
datacorpus=Corpus(VectorSource(datafr$text))

# Checking the corpus

# check
for (i in 1:5) {
  cat(paste("[[", i, "]] ", sep = ""))
  writeLines(as.character(datacorpus[[i]]))
}

#### TESTING SECTION - data frame ####

# make a data frame out of datafr for future use
df1 <- as.data.frame(datafr) %>%
  gsub("the", "", datafr$text) %>%
  gsub("�", "", datafr$text)

# JKJ 2018/05/08 ~ added this option that reads in the files directly to a corpus
# tm pkg
#datafr_corpus <- VCorpus(DirSource(getwd()))
#rm(datafr_corpus)  # clean up

# TESTING
# convert corpus back to data frame
#dataframe <- data.frame(text=sapply(datafr_corpus, identity), stringsAsFactors=F)
#rm(dataframe)  # clean up

```    

```{r Corpus transformations, include=FALSE}    

## start of transformations (all done on datacorpus object)
jeopCorpus=NULL

removeURL <- function(x) gsub("http[[:alnum:]]*", "", x)

jeopCorpus <- tm_map(datacorpus, PlainTextDocument)
jeopCorpus <- tm_map(jeopCorpus, tolower)
jeopCorpus <- tm_map(jeopCorpus,removePunctuation)
#jeopCorpus <- tm_map(jeopCorpus, content_transformer(removeMostPunctuation),preserve_intra_word_dashes = TRUE) 
jeopCorpus <- tm_map(jeopCorpus, removeNumbers)
jeopCorpus <- tm_map(jeopCorpus, content_transformer(removeURL))
jeopCorpus <- tm_map(jeopCorpus, removeWords, stopwords('english'))
jeopCorpus <- tm_map(jeopCorpus, stripWhitespace)
#jeopCorpus <- tm_map(jeopCorpus, stemDocument,language="english")

## TO DO ... need to remove user-specified words / phrases ... 
removeGarbage <- function(x) gsub("�", "", x)
jeopCorpus <- tm_map(jeopCorpus, content_transformer(removeGarbage))
removeGarbage <- function(x) gsub("???T", "", x)
jeopCorpus <- tm_map(jeopCorpus, content_transformer(removeGarbage))
```

```{r include=FALSE}  
# check
for (i in 1:5) {
  cat(paste("[[", i, "]] ", sep = ""))
  writeLines(as.character(jeopCorpus[[i]]))
}    
```

```{r include=FALSE}
#### Document term matrix for analysis ####

# create a copy
jeopCorpus.copy=jeopCorpus

# previous transformations turned the corpus of texts to character.  now we need to change back to a vector source    
jeopCorpus.copy <- Corpus(VectorSource(jeopCorpus.copy))

# declare the doctmtrx object
doctmtrx=NULL

# make the document term matrix using this object
doctmtrx=DocumentTermMatrix(jeopCorpus)  # JKJ 2018/05/17 ~ changed from jeopCorpus.copy

# TO DO ... document what this does
alarm()

# check
class(doctmtrx)

# TO DO ... document what this does
dtm <- as.matrix(doctmtrx)

# check
length(doctmtrx)
length(colSums(as.matrix(doctmtrx)))

# clean up
#rm(jeopCorpus.copy)
#rm(doctmtrx)
```
```{r include=FALSE}
#### Beginning of analysis section ####

## PREP

# Term summary (done on dtm object)
word_data_1=as.data.frame(cbind.data.frame(Words = colnames(dtm), freq=colSums(dtm)))
#names(word_data_1)

# put in descending order
word_data_1 <- word_data_1[order(-word_data_1$freq),]

# check  
word_data_1

# Optional: write to .csv  
#write.csv(word_data_1,"Summary.csv",row.names=F)
```

### WORDCLOUD
```{r}

# Wordcloud
wordcloud(words=colnames(dtm),freq=colSums(dtm), max.words = 30, min.freq=5, scale=c(4, .1), colors=brewer.pal(n=10, "Paired"), random.order=TRUE)

```

### TERM SUMMARIES
```{r}


#### to do in this section
# 1. still need to list final step --- top n for EACH document

# list most frequent terms (all documents)
top_n_terms <- word_data_1 %>%
  select_if(has_data) %>% # strip empty columns
  top_n(10)  

top_n_terms

# old way
#ggplot(top_n_terms, aes(x=Words, y=freq)) + geom_bar(stat = "identity") + xlab("Words") + ylab("Count") +coord_flip()

# new way (descending order)
ggplot(top_n_terms, aes(x=reorder(Words,freq), y=freq)) + geom_bar(stat = "identity", fill="red") + xlab("Words") + ylab("Count") + ggtitle("Top 10 Terms") + coord_flip()

# list most frequent terms (by document)
#as.data.frame(findMostFreqTerms(doctmtrx, n=10))
```
## BIGRAMS and TRIGRAMS
```{r}

### BIGRAMS
bigrams = textcnt(datafr$text, n = 2, method = "string")
bigrams = bigrams[order(bigrams, decreasing = TRUE)]

# need a way to show top 10 bigrams per document (similar to top 10 terms above)

# View bigrams
#head(as.data.frame(bigrams), 20)

# Optional: Write list of bigrams to a file
#fwrite(as.data.frame(bigrams),row.names = T,file = "Bigrams.csv") #This is to write the Bigram Summmary into an excel file.

# plot bar chart of bigrams
library(data.table)
d1=setDT(as.data.frame(bigrams), keep.rownames = TRUE)[]


top_n_bigrams <- d1 %>%
  select_if(has_data) %>% # strip empty columns
  top_n(10)  

top_n_bigrams

ggplot(d1[1:10], aes(x=reorder(rn,bigrams), y=bigrams)) + geom_bar(stat = "identity", fill="Blue") + xlab("Words") + ylab("Count") + ggtitle("Top Bigrams") + coord_flip()

### TRIGRAMS
trigrams = textcnt(datafr$text, n = 3, method = "string")
trigrams = trigrams[order(trigrams, decreasing = TRUE)]

# View trigrams
#head(as.data.frame(trigrams), 20)

# Optional: Write list of trigrams to a file
#fwrite(as.data.frame(trigrams),row.names = T,file = "Trigrams.csv") #This is to write the Trigram Summmary into an excel file.

# plot bar chart of trigrams
d2=setDT(as.data.frame(trigrams), keep.rownames = TRUE)[]

ggplot(d2[1:10], aes(x=reorder(rn,trigrams), y=trigrams)) + geom_bar(stat = "identity", fill="Purple") + xlab("Words") + ylab("Count") + ggtitle("Top Trigrams") + coord_flip()    

```
```{r include=FALSE}        
#### Advanced Requirements ####

# quanteda package (loaded during setup)

# use the VCorpus object loaded via tm package
quantedaCorpus <- corpus(jeopCorpus)

#quantedaCorpus <- tm_map(quantedaCorpus, tolower)
#quantedaCorpus <- corpus(VectorSource(quantedaCorpus))

# TO DO: figure out how to use the same corpus that we already cleaned / did the transformations to here

# clean up

# check structure
#summary(quantedaCorpus)
```

```{r}
### ADVANCED REQUIREMENT 1: Perform a search for a word across the corpuses, and view the contexts in which it occurs

# specify first keyword
words <- c("China")

# show the words in context      
kwic(quantedaCorpus, words)

# specify second keyword

words <- c("People")
kwic(quantedaCorpus, words)


```

### ADVANCED REQUIREMENT 2: Sentiment Analysis
```{r include=FALSE}
# We will use Tarun's method for sentiment analysis using the two approaches he outlines
# 1.	Using Bag of words - From a reference files of positive words and negative words , I have calculated Sentiement_BOW.
# 2.	Using Syuzhet Methodology - I have used this to present various emotions and rate each speech accordingly. Also, I have lastly categorized into Positive and Negative sentiments using "NRC" technique. 

# viz results
# we will visualize in two ways
# 1. the table similar to tarun's email file
# 2. heatmap

####### Using Bag of Words and calculating the overall Sentiment of all the document ####################
#pos = read.table("S:/Projects/2018 R Text Mining/Positive.txt", sep="\n")

pos <- read.table("S:\\ACE\\Projects\\ACE - Ongoing and Standard Analytics\\R__Text Mining\\Positive.txt")

#View(pos)

#neg = read.table("S:/Projects/2018 R Text Mining/Negative.txt", sep="\n")

neg <- read.table("S:\\ACE\\Projects\\ACE - Ongoing and Standard Analytics\\R__Text Mining\\Negative.txt")

#View(neg)

pos.matches <- match(colnames(dtm),as.character(pos$V1))
neg.matches <- match(colnames(dtm),as.character(neg$V1))
pos.matches <- !is.na(pos.matches)
neg.matches <- !is.na(neg.matches)
pos.matrix <- doctmtrx[,pos.matches]
neg.matrix <- doctmtrx[,neg.matches]

sentiment.score <- rowSums(as.matrix(pos.matrix)) - rowSums(as.matrix(neg.matrix))
sentiment.score
New_data=NULL
New_data=cbind.data.frame(Doc_name=datafr[,c(1)],Sentiment_BOW=sentiment.score)

# check
  head(New_data)

```    

```{r}
# legend
tbl_df(as.data.frame(New_data[1]))

# Sentiment plot by document
plot(x=row.names(New_data),y=New_data$Sentiment_BOW, type="b",xlab = "Document ID", ylab = "Sentiment")

# Alternate sentiment plot by document (superceded by next plot)
#ggplot(New_data, aes(x=row.names(New_data), y=Sentiment_BOW)) + geom_bar(stat="Identity", fill="Maroon")

# Latest sentiment plot by document
ggplot(New_data, aes(x=reorder(Doc_name,Sentiment_BOW), y=Sentiment_BOW)) + geom_bar(stat = "identity", fill="orange") + xlab("File name") + ylab("Sentiment Score") + 
  ggtitle("BOW Sentiment Score") + coord_flip()


```

```{r include=FALSE}    

## Using Syuzhet methodology ##

#install.packages('syuzhet')
library(syuzhet)

#install.packages('RNewsflow')
#install.packages('reshape2')
#install.packages('corrgram')
library(RNewsflow)
library(reshape2)
library(corrgram)

syuzhet_vector=get_sentiment(datafr$text,method="syuzhet")
New_data=cbind(New_data, Sentiment_syuzhnet=syuzhet_vector)

# check
#View(New_data)

s_v <- get_sentences(datafr$text)
s_v_sentiment <- get_sentiment(s_v)

nrc_data <- get_nrc_sentiment(datafr$text)
#View(nrc_data)

New_data=cbind.data.frame(New_data,nrc_data)
#glimpse(New_data)
#write.csv(New_data,file = "Sentiment_Analysis_Combined.csv")

# ADVANCED REQUIREMENT 3: Similarity among Documents

# we will visualize with a heatmap

```

```{r}
# View Sentiment results table
as.data.frame(New_data)

```

```{r}

doc_comp <- as.data.frame(documents.compare(doctmtrx ))

# legend
tbl_df(as.data.frame(New_data[1]))

doc_comp <- doc_comp %>%
  arrange(desc(similarity))

doc_comp

new_doc_comp <-  reshape2::acast(doc_comp, x  ~ y, value.var = "similarity")
new_doc_comp.sorted = new_doc_comp[as.character(order(rownames(new_doc_comp))),as.character(order(rownames(new_doc_comp)))]

rm(new_doc_comp)

new_doc_comp.sorted <- as.data.frame(new_doc_comp.sorted)

# corrgram
corrgram(new_doc_comp.sorted,
         #order=TRUE,
         main="Document Similarity Matrix",
         lower.panel=panel.shade,
         upper.panel=panel.pie,
         diag.panel = panel.pts,
         text.panel=panel.txt)

corrgram(new_doc_comp.sorted,
         lower.panel=panel.pts, upper.panel=panel.conf,
         diag.panel=panel.density)



```    