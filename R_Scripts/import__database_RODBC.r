
# SQL Server
```{r}
	# The RODBC package provides access to databases (including Microsoft Access and Microsoft 
	SQL Server) through an ODBC interface.
```

# Load RODBC package
```{r}
require(RODBC)

	# final form, all-inclusive
	if(!is.element("RODBC", installed.packages())){
		install.packages("RODBC")
		}else{
		library(RODBC)}
```

# standard function to show formulas within the package

```{r}
lsp <- function(package, all.names = FALSE, pattern) 
	{
	package <- deparse(substitute(package))
		ls(
		pos = paste("package", package, sep = ":"), 
		all.names = all.names, 
		pattern = pattern
		)
	}

lsp(RODBC)
```
		
# connect to database
channel <- odbcDriverConnect('driver={SQL Server};server=CQW-DBS001236.stage.twi.com; database=IAACE1; uid=IAACE1User; pwd=9n5B1RIc')


# Check that connection works
odbcGetInfo(channel)






# Find out which tables are available
Tables <- sqlTables(channel)

```{r}
# Function	Description
# odbcConnect(dsn, uid="", pwd="")	...Open a connection to an ODBC database
# sqlFetch(channel, sqtable)	...Read a table from an ODBC database into a data frame
# sqlQuery(channel, query)	...Submit a query to an ODBC database and return the results
# sqlSave(channel, mydf, tablename = sqtable, append = FALSE)	...Write or update (append=True) a data frame to a table in the ODBC database
# sqlDrop(channel, sqtable)	...Remove a table from the ODBC database
# close(channel)	...Close the connection
# odbcCloseAll()


sqlQuery(channel, "SELECT * FROM dbname.schema.myTable");


user_tables <- sqlQuery(channel, "SELECT * FROM sysobjects WHERE xtype='U'")
nel, "SELECT * FROM sysobjects WHERE xtype='U'")
all_tables <- sqlQuery(channel, "SELECT * FROM INFORMATION_SCHEMA.TABLES")

```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEzMTcxODcxMjldfQ==
-->