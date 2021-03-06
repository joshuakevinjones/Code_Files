# read csv into R - simple
MyData <- read.csv(file = "c:/TheDataIWantToReadIn.csv", header = TRUE, sep = ",")

# read csv into R - full
MyData <- read.csv(
	file = file.choose(),		# file name
	skip = 0,					# number of lines to skip
	stringsAsFactors = FALSE,	# whether to load string fields as factors
	header = TRUE,  			# first line as header? yes/no
	sep = ",",					# field separator
	quote = "\"", 				# quoting characters
	strip.white = TRUE,			# strip whitespace?
	na.strings=c("", "NA"), 	# what to do with NAs (captures blanks and "NA")
	)
	
	# stringsAsFactors is case sensitive

