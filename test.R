# Install package
#install.packages('RMySQL', repos = "http://cran.us.r-project.org")
#install.packages('servr', repos = "http://cran.us.r-project.org")
#install.packages('sjmisc', repos = "http://cran.us.r-project.org")


myString <- "Loading..."
print(myString)


# Loading library
library("RMySQL")
library("sjmisc")
 
# Create connection
mysqlconn = dbConnect(MySQL(), user = 'root', password = '', dbname = 'test', host = 'localhost', port = 3306)
res = dbSendQuery(mysqlconn, "SELECT * FROM myarttable WHERE id>14 ORDER BY id DESC")
 
# Fetch first 3 rows in data frame
df = fetch(res, n = 3)
print(df)

GetHTML <- function() {
	list_file <- read.table("select.html", sep="\t", as.is=TRUE, check.names=FALSE, comment.char="")

	print(typeof(list_file))
	
	for(line_file in list_file){
	
		if (str_contains(line_file, c("@tr", "@ver"), logic = "or") == TRUE) {
			print(line_file)
		}
		if(str_contains(line_file, "@tr") != FALSE){
			print("TR!!!")
		}
		if(str_contains(line_file, "@ver") != FALSE){
			print("VER!!!")
		}
		
		print(str_contains("trtrtr", "tr"))
		print(line_file)
	}
	
    return(list_file)
}

# запуск сервера и ожидание подключений ...
servr::create_server(handler = function(req) {list(status = 200L, body = paste(unlist(GetHTML()), collapse=''))})
