# Data management example

#1
options(digits=2)
  # 1: The original student roster is given. options(digits=2) limits the number of 
  # digits printed after the decimal place and makes the printouts easier to read.

#2
Student <- c("John Davis", "Angela Williams", "Bullwinkle Moose",
               "David Jones", "Janice Markhammer", "Cheryl Cushing",
               "Reuven Ytzrhak", "Greg Knox", "Joel England",
               "Mary Rayburn")
Math <- c(502, 600, 412, 358, 495, 512, 410, 625, 573, 522)
Science <- c(95, 99, 80, 82, 75, 85, 80, 95, 89, 86)
English <- c(25, 22, 18, 15, 20, 28, 15, 30, 27, 18)
roster <- data.frame(Student, Math, Science, English, stringsAsFactors=FALSE)

z <- scale(roster[,2:4])

#3
score <- apply(z, 1, mean)
roster <- cbind(roster, score)

  # 2: Standardize variables such that each is reported in SD units.
  # 3: Calculate row means using mean() function, and add them to df using cbind() function.

#4
y <- quantile(score, c(.8,.6,.4,.2))
y

#5
roster$grade[score >= y[1]] <- "A"
roster$grade[score < y[1] & score >= y[2]] <- "B"
roster$grade[score < y[2] & score >= y[3]] <- "C"
roster$grade[score < y[3] & score >= y[4]] <- "D"
roster$grade[score < y[4]] <- "F"

  #4: Use quantile() function to get a percentile rank of each student's performance score.
  #5: Using logical operators, recode students' percentile ranks into a new categorical grade variable.
    # This code creates variable $grade in the roster df.

#6
name <- strsplit((roster$Student), " ")

  #6: Use strsplit() function to parse $Student at the space character.
    # Note: Applying strsplit() to a vector of strings returns a list.

#7
Lastname <- sapply(name, "[", 2)
Firstname <- sapply(name, "[", 1)
roster <- cbind(Firstname,Lastname, roster[,-1])

  #7: Use sapply() function to take the first element of each component and put it into a Firstname vector.
    # Put the second element of each component into a Lastname vector.
    # "[" is a function that extracts part of an object - here the first or second component of the list name.
    # Use cbind() to add the elements to the roster.
    # Drop the $Student variable.

#8
roster <- roster[order(Lastname, Firstname), ]
roster

  #8: Using the order() function, sort the dataset by first and last name.
