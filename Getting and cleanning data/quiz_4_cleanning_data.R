# question 1

# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# and load the data into R. The code book, describing the variable names is here:   
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

# answer
data <- read.csv("./getdata-data-ss06hid.csv")
names(data)[123]
strsplit(names(data)[123], "wgtp")

# question 2
# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average? 
# Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table

#answer
data <- read.csv("./getdata-data-GDP.csv", skip = 4)
# select only countries
cleanedData <- gsub(",", "", data[1:190, 5])
tidyData <- as.numeric(cleanedData)
mean(tidyData) 

# question 3

# In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? Assume that the variable with the country names in it is named countryNames. How many countries begin with United?

# Answer

countryNames <- data[1:190,4]
#^ indicate start of line
grep("^United",countryNames)


# question 4

# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 

# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# Load the educational data from this data set: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
# Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June? 
# Original data sources: 
# http://data.worldbank.org/data-catalog/GDP-ranking-table 
# http://data.worldbank.org/data-catalog/ed-stats 

# answer
data <- read.csv("./getdata-data-GDP.csv")
filterData <- data[6:194, c(1, 2, 4, 5)]
# drop columnn with sequence number
rownames(filterData) <- NULL
colnames(filterData) <- c("CountryCode", "Ranking", "Economy", "GDP")
educationData <- read.csv("./getdata-data-EDSTATS_Country.csv")
# union data joining by country code (it is a like a join two tables in SQL)
combinedData <- merge(filterData, educationData, by.x="CountryCode", by.y="CountryCode", all=TRUE)
# count condition and casting
notes <- as.character(combinedData[,13])
# how many end in June?
length(grep("Fiscal year end: June", notes))

# question 5

# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.

# answer
# install package

install.packages('quantmod')
install.packages('lubridate') 
library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
length(sampleTimes)
yearSelected = year(sampleTimes) == 2012
days = length(sampleTimes[yearSelected]) #250 days in 2012
## ojo porque depende del idioma en el que este R
daySelected <- weekdays(sampleTimes)=="lunes"
# compare boolean expresions
mondays = length(sampleTimes[yearSelected & daySelected]) #47 mondays