







    # refine tidy_docs 
      
        
    

      
        
    # clean the data environment
      rm(docs)
      rm(docs_tidy)

  # --- Start of some basic reporting on the text(s)
      
    # -- Summary tables
      

      

        





# --- Start of advanced reporting on the text(s)
    
  # quanteda package
    library(quanteda)
    
    # use the VCorpus object loaded via tm package
      myCorpus <- corpus(docs)
    
      summary(myCorpus, showmeta = TRUE)
    
    # perform a search for a word across the corpuses, and view the contexts in which it occurs
      # note: it is necessary to manually specify the word
        kwic(myCorpus, "people")
    
    # make a dfm, removing stopwords and applying stemming (dfm = document frequency matrix)
    myStemMat <- dfm(myCorpus, remove = stopwords("english"), stem = TRUE, remove_punct = TRUE)
    myStemMat[, 1:5]
    myStemMat
    
    # compare how documents may be similar
    docDfm <- dfm(myCorpus, remove = stopwords("english"), stem = TRUE, remove_punct = TRUE)
    docSim <- textstat_simil(docDfm, "Trump CIA Speech.txt", margin = "documents", method = "cosine")  

    docSim # need a way to sort this descending !!!


  