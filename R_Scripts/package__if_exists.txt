
# is package installed?
any( grepl( "<name of your package>" , installed.packages()))

# is package installed?  then load or install with messages suppressed
if(!is.element( "<name of your package>", installed.packages())){
  install.packages( "<name of your package>")
}else{
  suppressMessages( library( <name of your package>))}

# does variable exist in a certain object?
"x" %in% names( <dataobject>)

# does column called "x" exist in a certain object?
"x" %in% colnames( <dataobject>)

