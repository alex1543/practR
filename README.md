# practR
Как можно работать с таблицами в MySQL на языке R (R lang)

Пример не требует web-сервера Apache. Достаточно запустить файл test.bat и открыть страницу: http://127.0.0.1:4321/

![image](https://github.com/alex1543/practR/assets/10297748/589b8c56-cab8-493c-af83-1e77f0ad2494)


Для работы с таблицей, необходимо выполнить скрипт import_test.sql из каталога с примером.

Пример гарантированно работает, если установить:
1) Язык R-4.3.0 for Windows, скаченный например отсюда: https://cran.mirrors.hoobly.com (из файла: R-4.3.0-win.exe)
2) Установить пакеты RMySQL, servr с помощью команд:
    - install.packages('RMySQL', repos = "http://cran.us.r-project.org")
    - install.packages('servr', repos = "http://cran.us.r-project.org")
