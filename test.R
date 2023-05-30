# Install package
#install.packages('RMySQL', repos = "http://cran.us.r-project.org")
#install.packages('servr', repos = "http://cran.us.r-project.org")

myString <- "Loading..."
print(myString)


# Loading library
library("RMySQL")

# Создание подключения ...
mysqlconn = dbConnect(MySQL(), user = 'root', password = '', dbname = 'test', host = 'localhost', port = 3306)

# формирование строк таблицы ...
ViewSelect <- function() {
	s_out <- list()
	
	# заголовок таблицы.
	res = dbSendQuery(mysqlconn, "SELECT COLUMN_NAME from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'myarttable' AND TABLE_SCHEMA = 'test'")
	df <- dbFetch(res)

	for(sRow in df){
		s_out = c(s_out, "<tr>")
		s_out = c(s_out, paste("<td>", sRow, "</td>"))
		s_out = c(s_out, "</tr>")
	}

	dbClearResult(res)
	
	# строки таблицы.
	res = dbSendQuery(mysqlconn, "SELECT * FROM myarttable WHERE id>14 ORDER BY id DESC")
	df <- dbFetch(res)
	
	# транспонирование строк и столбцов.
	df <- as.data.frame(t(df))

	for(sRow in df){
		s_out = c(s_out, "<tr>")
		s_out = c(s_out, paste("<td>", sRow, "</td>"))
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

	list_out <- list()
	# построчное чтение файла.
	con = file("select.html", "r")
	while ( TRUE ) {
		line = readLines(con, n = 1)
		if (length(line) == 0) {break}
		#print(line)
		if ((!grepl("@tr", line)) && (!grepl("@ver", line))) {
			list_out = c(list_out, line)
		}
		if (grepl("@tr", line)) {
			list_out = c(list_out, ViewSelect())
			print("This is TR.")
		}
		if (grepl("@ver", line)) {
			list_out = c(list_out, ViewVer())
			print("This is VER.")
		}	
	
	}
	close(con)
	return(list_out)
}

# запуск сервера и ожидание подключений ...
print("Listening for connections at http://127.0.0.1:4321/ ...")
servr::create_server(handler = function(req) {list(status = 200L, body = paste(unlist(GetHTML()), collapse=''))})
