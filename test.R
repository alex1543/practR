# Install package
#install.packages('RMySQL', repos = "http://cran.us.r-project.org")
#install.packages('servr', repos = "http://cran.us.r-project.org")


myString <- "Loading..."
print(myString)


# Loading library
library("RMySQL")
 
# Create connection
mysqlconn = dbConnect(MySQL(), user = 'root', password = '',
                      dbname = 'test', host = 'localhost')
 
# Show tables in database
# dbListTables(mysqlconn)

# Select all rows from articles table
res = dbSendQuery(mysqlconn, "SELECT * FROM myarttable WHERE id>14 ORDER BY id DESC")
 
# Fetch first 3 rows in data frame
df = fetch(res, n = 3)
print(df)

viewSelect <- function() {
list_file <- read.table("select.html", 
                sep="\t", as.is=TRUE, 
                check.names=FALSE, comment.char="")

	print(typeof(list_file))
	
	for(line_file in list_file){
	
		print(line_file)
		
		#if (grepl("@tr", line_file, fixed = TRUE) == TRUE) {
		
		#}
  
	}
	
	#print(y1)
	#v1 <- list_file
    return(list_file)
}




# always return 'Success:' followed by the requested path
s = servr::create_server(handler = function(req) {

list(status = 200L, body = paste(unlist(viewSelect()), collapse=''))

#list(status = 200L, body = paste("Success:", req$PATH_INFO))
})
s$url
browseURL(paste0(s$url, "/hello"))
browseURL(paste0(s$url, "/world"))
s$stop_server()


print("ok")
