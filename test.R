
myString <- "Loading..."
print(myString)

# Install package
#install.packages('RMySQL', repos = "http://cran.us.r-project.org")
 
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


#install.packages('servr', repos = "http://cran.us.r-project.org")

# always return 'Success:' followed by the requested path
s = servr::create_server(handler = function(req) {
list(status = 200L, body = paste("Success:", req$PATH_INFO))
})
s$url
browseURL(paste0(s$url, "/hello"))
browseURL(paste0(s$url, "/world"))
s$stop_server()


print("ok")
