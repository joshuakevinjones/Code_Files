
# Formula
lsp <- function(package, all.names = FALSE, pattern) 
 {
   package <- deparse(substitute(package))
   ls(
     pos = paste("package", package, sep = ":"), 
     all.names = all.names, 
     pattern = pattern
   )
 }

# Example usage
lsp(RODBC)

	# This would list all functions in the RODBC package.