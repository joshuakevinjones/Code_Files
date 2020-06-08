##
## Project: R Text Mining Project
## Script purpose:
## Date:
## Author: Tarun, Josh
##

#################### Setup #########################

# JKJ 2018/05/08 ~ let's load the packages all in one go like this
x <- c("RODBC", "data.table", "readtext", "tm", "wordcloud", "RWeka", "tidytext", "doParallel", "tau", "quanteda", "stringr", "ggplot2", "dplyr")
lapply(x, require, character.only = TRUE)

doParallel::registerDoParallel(cores = 4)   # loads doParallel package    

# setup for working directory  
  #setwd("S:/Projects/2018 R Text Mining/texts")   # Enter the location of the folder.   
  setwd(choose.dir()) # JKJ 2018/05/08 ~ alternate way to choose the folder

# Setup for database connection (use only if needed)
  #server1 <-odbcDriverConnect('driver={SQL Server};server=CQW-DBS001236.stage.twi.com; database=IAACE1; uid=IAACE1User; pwd=9n5B1RIc')

#################### Functions #########################

# custom function to strip empty columns.  used in the sentiment analysis section below
has_data <- function(x) { sum(!is.na(x)) > 0 }

#################### Folder Control #########################

# JKJ 2018/05/08 ~ changed to let the user specify the directory
  folder_to_read <- getwd() # choose.dir()

  # check
  folder_to_read
  
# # JKJ 2018/05/08 ~ changed to show all arguments in case we want to use these options in the future
  file_list <- list.files(
    path = folder_to_read, # JKJ ~ need to fix so that we can let user specify file path
    pattern = ".txt", # JKJ 2018/05/09 ~ need to make sure we can read Word and PDF too
    all.files = FALSE, 
    full.names = FALSE, 
    recursive = TRUE, 
    ignore.case = FALSE, 
    include.dirs = TRUE, 
    no.. = FALSE)
  
  # check
    file_list   # Returns the files in the folder
    
  # make any adjustments to file_list after checking (i.e. remove unwanted files)
    # TO DO

# reads in the files using the readtext package
  datalist = lapply(file_list, function(x) readtext(x))  # datalist is a list object

  # check
    str(datalist)  # datalist is a list of data frames
    head(datalist)  # shows the documents as 1x2 data frames

# combine all the datalist items into a single object
  datafr = do.call("rbind", datalist) 
  
  rm(datalist)  # clean up
  
  # check
    #View(datafr)
    #str(datafr)
    #datafr$text[7]
    #write.table(datafr$text[7],"test.txt")

# make a data frame out of datafr for future use
  df1 <- as.data.frame(datafr)
    
  ### now working
    # test for replacing garbage strings / characters  
      gsub("the", "", datafr$text)
      gsub("â", "", datafr$text)
  
      gsub("the", "", df1$text)
      gsub("â", "", df1$text)
  ### ---
  
  # creates a data corpus from the text column of the datafr data frame
    datacorpus=Corpus(VectorSource(datafr$text))
    
    # check
      for (i in 1:5) {
        cat(paste("[[", i, "]] ", sep = ""))
        writeLines(as.character(datacorpus[[i]]))
        }
        
  # JKJ 2018/05/08 ~ added this option that reads in the files directly to a corpus
    # tm pkg
      #datafr_corpus <- VCorpus(DirSource(getwd()))
      #rm(datafr_corpus)  # clean up
      
    # TESTING
    # convert corpus back to data frame
      #dataframe <- data.frame(text=sapply(datafr_corpus, identity), stringsAsFactors=F)
      #rm(dataframe)  # clean up
      
  # start of transformations (all done on datacorpus object)
    jeopCorpus=NULL

    removeURL <- function(x) gsub("http[[:alnum:]]*", "", x)
    
    removeGarbage <- function(x) gsub("â???", "", x)
    
    jeopCorpus <- tm_map(datacorpus, PlainTextDocument)
    jeopCorpus <- tm_map(jeopCorpus, tolower)
    jeopCorpus <- tm_map(jeopCorpus,removePunctuation)
    #jeopCorpus <- tm_map(jeopCorpus, content_transformer(removeMostPunctuation),preserve_intra_word_dashes = TRUE) 
    jeopCorpus <- tm_map(jeopCorpus, removeNumbers)
    jeopCorpus <- tm_map(jeopCorpus, content_transformer(removeURL))
    jeopCorpus <- tm_map(jeopCorpus, content_transformer(removeGarbage))
    jeopCorpus <- tm_map(jeopCorpus, removeWords, stopwords('english'))
    jeopCorpus <- tm_map(jeopCorpus, stripWhitespace)
    #jeopCorpus <- tm_map(jeopCorpus, stemDocument,language="english")
    # TO DO ... need to remove user-specified words / phrases ... 
    
    # check
    for (i in 1:5) {
      cat(paste("[[", i, "]] ", sep = ""))
      writeLines(as.character(jeopCorpus[[i]]))
    }    

#################### Document Term Matrix for Analysis #########################

  # create a copy
    jeopCorpus.copy=jeopCorpus

  # previous transformations turned the corpus of texts to character.  now we need to change back to a vector source    
    jeopCorpus.copy <- Corpus(VectorSource(jeopCorpus.copy))

  # declare the doctmtrx object
    doctmtrx=NULL

  # make the document term matrix using this object
    doctmtrx=DocumentTermMatrix(jeopCorpus.copy)

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
      rm(jeopCorpus.copy)
      rm(doctmtrx)

#################### Term Summaries Using the DTM #########################
              
# Term summary (done on dtm object)
  word_data_1=as.data.frame(cbind.data.frame(Words = colnames(dtm), freq=colSums(dtm)))
  names(word_data_1)
  
    # put in descending order
      word_data_1 <- word_data_1[order(-word_data_1$freq),]
  
    # check  
      word_data_1
    
    #write.csv(word_data_1,"Summary.csv",row.names=F)

# Wordcloud (done on dtm object)
  word_data_1 %>%
    count(Words, sort = TRUE) %>%
    with(wordcloud(words=colnames(dtm),freq=colSums(dtm), max.words = 35, min.freq=10, scale=c(3, 0.1), colors=brewer.pal(n=10, "Paired"), random.order=TRUE))

# find the top N words - Here N is the threshold freq
  findMostFreqTerms(doctmtrx, n = 6L)  # Gives most frequent occuring words in each document
  findFreqTerms(doctmtrx, 10)  # at least frequency of 100

  # list most frequent terms
  top_n_terms <- word_data_1 %>%
    select_if(has_data) %>% # strip empty columns
    top_n(10)  
    # need a way to sort this list descending
    # need a way to show a different top 10 graph for each document

  ggplot(top_n_terms, aes(x=Words, y=freq)) + geom_bar(stat = "identity") + xlab("Words") + ylab("Count") +coord_flip()
  

#################### Bigrams and Trigrams #########################

### Tarun bigrams
    bigrams = textcnt(datafr$text, n = 2, method = "string")
    bigrams = bigrams[order(bigrams, decreasing = TRUE)]
    View(bigrams)
    #fwrite(as.data.frame(bigrams),row.names = T,file = "Bigrams.csv") #This is to write the Bigram Summmary into an excel file.

    # need a way to show top 10 bigrams per document (similar to top 10 terms above)
    
    
  ### Tarun trigrams
    trigrams = textcnt(datafr$text, n = 3, method = "string")
    trigrams = trigrams[order(trigrams, decreasing = TRUE)]
   #fwrite(as.data.frame(trigrams),row.names = T,file = "Trigrams.csv") #This is to write the Trigram Summmary into an excel file.

    # need a way to show top 10 trigrams per document (similar to top 10 terms above)
    
#################### Advanced Requirements #########################
    
# quanteda package loaded during setup
      
# use the VCorpus object loaded via tm package
  docs <- VCorpus(DirSource(choose.dir()))
  quantedaCorpus <- corpus(docs)

  # clean up
    rm(docs) # cleanup
    
  # check structure
    summary(quantedaCorpus)

# Advanced Requirement #1
# perform a search for a word across the corpuses, and view the contexts in which it occurs
        
  # note: it is necessary to manually specify the words.
    words <- c("China", "America")
  
  # show the words in context      
    kwic(quantedaCorpus, words)
      
# Advanced Requirement #2: Sentiment Analysis
    
  # we will use Tarun's method for sentiment analysis using the two approaches he outlines
    # 1.	Using Bag of words - From a reference files of positive words and negative words , I have calculated Sentiement_BOW.
    # 2.	Using Syuzhet Methodology - I have used this to present various emotions and rate each speech accordingly. Also, I have lastly categorized into Positive and Negative sentiments using "NRC" technique. 

    # viz results
      # we will visualize in two ways
        # 1. the table similar to tarun's email file
        # 2. heatmap
  
  # Advanced Requirement #3: Similarity among Documents

    # tarun to add his code that compares all documents to all other documents