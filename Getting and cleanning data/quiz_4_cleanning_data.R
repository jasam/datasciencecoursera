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
grep("^United",countryNames)
