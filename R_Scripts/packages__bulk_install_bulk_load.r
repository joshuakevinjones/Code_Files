
# bulk install packages

# list by line the packages
pkgs <- c(
	"dplyr",
	"tidyr", 
	"broom"
	)

	
install.packages(pkgs) # install for everything in the list

sapply(pkgs, require, character.only = T) # load the packages