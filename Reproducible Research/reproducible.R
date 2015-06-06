#rm(list = ls())
library(dplyr)

setwd("E:/repos_git/datasciencecoursera/Reproducible Research")

# Load data
complete.data <- read.csv("activity.csv")
complete.data <- na.omit(complete.data)

# tructure of data
str(complete.data)

# 1.Calculate the total number of steps taken per day
steps.day <- complete.data %>% group_by(date) %>% summarise(sum = sum(steps))

# 2.Make a histogram of the total number of steps taken each day
