# create a variable with the directory name

mainDir <- dirname(normalizePath(file.choose())) # pick a file in the target directory
subDir <- "myDir" # name this what you want

# create the folder and setwd to it (if needed); otherwise, setwd to the existing folder

if (file.exists(subDir)){
  setwd(file.path(mainDir, subDir))
} else {
  dir.create(file.path(mainDir, subDir))
  setwd(file.path(mainDir, subDir))
  
}

# confirm wd
getwd()

# checks

basename(mainDir)
basename(file.choose())
dirname(file.choose())

installed.packages()
