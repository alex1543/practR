# Install package
#install.packages('RMySQL', repos = "http://cran.us.r-project.org")
#install.packages('servr', repos = "http://cran.us.r-project.org")
#install.packages('sjmisc', repos = "http://cran.us.r-project.org")

myString <- "Loading..."
print(myString)


# Loading library
library("RMySQL")
library("sjmisc")

# Создание подключения ...
mysqlconn = dbConnect(MySQL(), user = 'root', password = '', dbname = 'test', host = 'localhost', port = 3306)

# формирование строк таблицы ...
ViewSelect <- function() {
	res = dbSendQuery(mysqlconn, "SELECT * FROM myarttable WHERE id>14 ORDER BY id DESC")
	 
	df <- dbFetch(res)
	#print(df)
	s_out <- list()
	for(sRow in df){
		s_out = c(s_out, "<tr>")
		for(sCol in sRow){
			s_out = c(s_out, paste("<td>", sCol, "</td>"))
			print(sCol)
		}
		s_out = c(s_out, "</tr>")
	}
	
	dbClearResult(res)
	return(s_out)
}

# вервия базы данных ...
ViewVer <- function() {
	res = dbSendQuery(mysqlconn, "SELECT VERSION() AS ver")
	s_ver <- dbFetch(res)
	dbClearResult(res)
	return(s_ver)
}


GetHTML <- function() {
	list_file <- read.table("select.html", sep="\t", as.is=TRUE, check.names=FALSE, comment.char="")

	print(typeof(list_file))
	list_out <- list()
	
	for(line_file in list_file){
	
		#if ((!str_contains(line_file, "@tr")) && (!str_contains(line_file, "@ver"))) {
		if ((!grepl(line_file, "@tr")) && (!grepl(line_file, "@ver"))) {
			list_out = c(list_out, line_file)
		}
		if (str_contains(line_file, "@tr")) {
			list_out = c(list_out, ViewSelect())
			print("This is TR.")
		}
		if (str_contains(line_file, "@ver")) {
			list_out = c(list_out, ViewVer())
			print("This is VER.")
		}
	}
	
    return(list_out)
}

print("Listening for connections at http://127.0.0.1:4321/ ...")
# запуск сервера и ожидание подключений ...
servr::create_server(handler = function(req) {list(status = 200L, body = paste(unlist(GetHTML()), collapse=''))})
