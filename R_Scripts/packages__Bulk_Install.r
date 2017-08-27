
# bulk install packages

pkgs <- c("dplyr", "tidyr", "broom")
install.packages(pkgs) #install 
sapply(pkgs, require, character.only = T) #load 