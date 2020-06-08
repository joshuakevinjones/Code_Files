getwd()
setwd("C:/Users/jonesjosh/OneDrive - Time Warner/Code_Files/R_Scripts/Development/Text Mining Project 2018")
wd <- getwd()
folder <- file.path(wd)
dir("texts")

# install / load required packages
library(dplyr)
library(stringr)
library(tidytext)
install.packages("tm")
library(tm)

install.packages("quanteda")
library(quanteda)

# pdftools pkg needed to read pdfs
install.packages("pdftools")
library(pdftools)

# pdftools pkg (test to read in pdf files)

  # grab pdf files
  files <- list.files(recursive = TRUE, pattern = "pdf$")

  # convert to text for text mining
  files2 <- lapply(files, pdf_text)
  
  # create the corpus
    # using the VectorSource function to tell the Corpus function to treat each element of files2 as a document
  corp <- Corpus(VectorSource(files2))
  
  corp.tdm <- TermDocumentMatrix(corp, 
    control = list(removePunctuation = TRUE,
    stopwords = TRUE,
    tolower = TRUE,
    stemming = TRUE,
    removeNumbers = TRUE,
    bounds = list(global = c(3, Inf)))) 
  
    inspect(corp.tdm)

# tm package
  docs <- VCorpus(DirSource("texts"))

  # basic info
  summary(docs)

  # more info  
  inspect(docs[1])
  
# quanteda package
  
  # use the VCorpus object loaded via tm package
  myCorpus <- corpus(docs)

  summary(myCorpus, showmeta = TRUE)
  
  # perform a search for a word across the corpuses, and view the contexts in which it occurs
  kwic(myCorpus, "global")
  
  # make a dfm, removing stopwords and applying stemming
  myStemMat <- dfm(myCorpus, remove = stopwords("english"), stem = TRUE, remove_punct = TRUE)
  myStemMat[, 1:5]
  myStemMat
  
  # compare how documents may be similar
    docDfm <- dfm(myCorpus, remove = stopwords("english"), stem = TRUE, remove_punct = TRUE)
    docSim <- textstat_simil(docDfm, "Trump CIA Speech.txt", margin = "documents", method = "cosine")  
docSim
                             