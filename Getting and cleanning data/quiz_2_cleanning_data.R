# Question 1

install.packages("httr")
install.packages("XML")
install.packages("httpuv")
install.packages("jsonlite", repos="http://cran.r-project.org")


library(httr)
library(jsonLite)

oauth_endpoints("github")
# 
myapp <- oauth_app("github", "2c302968944332d7f12c", "9d706104fc4996ddbcdda2d58e6e622be8d1a06e")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
req <- GET("https://api.github.com/rate_limit", config(token = github_token))
stop_for_status(req)
content(req)

rawData <- content(req)

jsonData = fromJSON("https://api.github.com/users/jtleek/repos")

jsonData[jsonData$name=="datasharing",45]

#question 2

install.packages("sqldf")
library(sqldf)

# setear el directorio de trabajo
setwd("E:/getting_cleanning_data")
    
acs <- read.csv("./getdata-data-ss06pid.csv", header=T, sep=",")

head(acs)

sqldf("select pwgtp1 from acs where AGEP < 50")

#question 3

sqldf("select distinct AGEP from acs")

## es el unico que corre y además, por el lenght da los mismo que el unique

#question  4

link = "http://biostat.jhsph.edu/~jleek/contact.html"

con <- url(link)

htmlLines <- readLines(con)

close(con)

lapply(htmlLines[c(10, 20, 30, 100)], nchar)


#question 5

df <- read.fwf(file="getdata-wksst8110.for",widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)

sum(df[, 4])
