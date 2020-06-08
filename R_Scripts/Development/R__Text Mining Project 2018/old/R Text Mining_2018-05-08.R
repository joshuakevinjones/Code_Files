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
  setwd("S:/Projects/2018 R Text Mining/texts")   # Enter the location of the folder.   
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

### doesn't work...
  # test for replacing garbage strings / characters  
    str_replace_all(datalist$text, "the", "")
### ---
        
# combine all the datalist items into a single object
  datafr = do.call("rbind", datalist) 
  
  rm(datalist)  # clean up
  
  # check
    #View(datafr)
    #str(datafr)
    #datafr$text[7]
    #write.table(datafr$text[7],"test.txt")
  
  # creates a data corpus from the text column of the datafr data frame
    datacorpus=Corpus(VectorSource(datafr$text))
    
    # check
      datacorpus # simple corpus
      inspect(datacorpus)
        
  # JKJ 2018/05/08 ~ added this option that reads in the files directly to a corpus
    # tm pkg
      datafr_corpus <- VCorpus(DirSource(getwd()))
      rm(datafr_corpus)  # clean up
      
    # TESTING
    # convert corpus back to data frame
      #dataframe <- data.frame(text=sapply(datafr_corpus, identity), stringsAsFactors=F)
      rm(dataframe)  # clean up
      
  # start of transformations (all done on datacorpus object)
    jeopCorpus=NULL

    jeopCorpus <- tm_map(datacorpus, PlainTextDocument)
    jeopCorpus <- tm_map(jeopCorpus, tolower)
    jeopCorpus <- tm_map(jeopCorpus,removePunctuation)
    #jeopCorpus <- tm_map(jeopCorpus, content_transformer(removeMostPunctuation),preserve_intra_word_dashes = TRUE) 
    jeopCorpus <- tm_map(jeopCorpus, removeNumbers)
    jeopCorpus <- tm_map(jeopCorpus, removeWords,stopwords('english'))
    jeopCorpus <- tm_map(jeopCorpus, stripWhitespace)
    jeopCorpus <- tm_map(jeopCorpus, stemDocument,language="english")
    # TO DO ... need to remove user-specified words / phrases ... 
    
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
      
        
# Term summary (done on dtm object)
  word_data_1=as.data.frame(cbind.data.frame(Words = colnames(dtm), freq=colSums(dtm)))
  names(word_data_1)
  word_data_1 <- word_data_1[order(-word_data_1$freq),]
  word_data_1
  write.csv(word_data_1,"Summary.csv",row.names=F)

  # JKJ 2018/0508 ~ added a secondary version of the term summary
    # use tidytext pkg to convert tm pkg DocumentTermMatrix into tidy format
    dtm_df <- tidy(datafr_corpus)
    
    dtm_df %>%
      unnest_tokens(word, text) %>% # unnest tokens automatically converts to lowercase
      select_if(has_data) %>% # strip empty columns
    count(word, sort = TRUE) %>%
    top_n(10)
  # end JKJ additions
  
    dtm_df %>%
    unnest_tokens(word, text) %>% # unnest tokens automatically converts to lowercase
    select_if(has_data) %>% # strip empty columns
    count(word, sort = TRUE) %>%
    top_n(10, -n)
    
    
# Wordcloud (done on dtm object)
    wordcloud(words=colnames(dtm),freq=colSums(dtm),max.words = 35, min.freq=10 ,scale=c(4,0.1),colors=brewer.pal(n=10,"Paired"),random.order=F)

  # JKJ 2018/05/08 ~ added the code below to show my version for a wordcloud
    word_data_1=as.data.frame(cbind.data.frame(Words = colnames(dtm), freq=colSums(dtm)))
  
    word_data_1 %>%
      count(Words, sort = TRUE) %>%
      with(wordcloud(words=colnames(dtm),freq=colSums(dtm), max.words = 35, min.freq=10, scale=c(3, 0.1), colors=brewer.pal(n=10, "Paired"), random.order=TRUE))

# To find the top N words - Here N is the threshold freq
findMostFreqTerms(doctmtrx) #Gives most frequent occuring words in each document
findFreqTerms(doctmtrx, 100) #atleast frequency of 100

#################### Bigrams and Trigrams #########################

### Tarun bigrams
    bigrams = textcnt(datafr$text, n = 2, method = "string")
    bigrams = bigrams[order(bigrams, decreasing = TRUE)]
    View(bigrams)
    fwrite(as.data.frame(bigrams),row.names = T,file = "Bigrams.csv") #This is to write the Bigram Summmary into an excel file.

  ### josh bigrams

  # -- n-grams (2)
    ngrams2 <- datafr %>%
    unnest_tokens(ngram, text, token = "ngrams", n = 2) %>%
    count(ngram, sort = TRUE)

    # check
    head(ngrams2,20)

  ### Tarun trigrams
    trigrams = textcnt(datafr$text, n = 3, method = "string")
    trigrams = trigrams[order(trigrams, decreasing = TRUE)]
    fwrite(as.data.frame(trigrams),row.names = T,file = "Trigrams.csv") #This is to write the Trigram Summmary into an excel file.

  ### josh ngrams

  # -- n-grams(3)
    ngrams3 <- datafr %>%
    unnest_tokens(ngram, text, token = "ngrams", n = 3) %>%
    count(ngram, sort = TRUE)

    # check
    head(ngrams3)

#################### Advanced Requirements #########################
    
## josh additions
    
  # --- Start of advanced reporting on the text(s)
      
    # quanteda package loaded during setup
      
    # use the VCorpus object loaded via tm package
      docs <- VCorpus(DirSource(choose.dir()))
      quantedaCorpus <- corpus(docs)
      rm(docs) # cleanup
    
      # check structure
        summary(quantedaCorpus, showmeta = TRUE)

  # Advanced Requirement #1
  # perform a search for a word across the corpuses, and view the contexts in which it occurs
        
    # note: it is necessary to manually specify the word.  See "America" below.
      kwic(quantedaCorpus, "China")
      kwic(quantedaCorpus, "America") # JKJ need to return these results as one result set
    
  # Advanced Requirement #2: Sentiment Analysis
    
    # tidyr package loaded during setup
      
      datafr_sentiment <- datafr %>%    # JKJ 2018/05/08 - need to figure out how to use the CLEANED data source ()
        unnest_tokens(word, text) %>%
        select_if(has_data) %>% # strip empty columns
        inner_join(get_sentiments("bing"), by = "word") %>%
        count(word, index = 10, sentiment) %>% 
        spread(sentiment, n, fill = 0) %>% 
        mutate(sentiment = positive - negative)
    
    # show results
      datafr_sentiment
    
    # viz results
      # TO DO
  
  # Advanced Requirement #3: Similarity among Documents

    docDfm <- dfm(quantedaCorpus, remove = stopwords("english"), stem = TRUE, remove_punct = TRUE)
    docSim <- textstat_simil(docDfm, "Trump CIA Speech.txt", margin = "documents", method = "cosine")  
    docSim # need a way to sort this descending !!!