
# Autor: Javier Rey
# Date : 01-15-2015
# Project: Getting and Cleaning Data
# URL Project: https://class.coursera.org/getdata-010/human_grading/view/courses/973497/assessments/3/submissions
# David's Project FAQ
# https://class.coursera.org/getdata-010/forum/thread?thread_id=49#post-185
# Note: before install package: dplyr 
# install.packages("dplyr")
# This code assumes that the working directory is the unzipped file: zip getdata-projectfiles-UCI HAR Dataset
# the dity and summarized data is dataSummarized object
# For cleannig objects from working directory: rm(list = ls())

library(dplyr)

###########################################################################
# 1. Merges the training and the test sets to create one data set.
# Read files
# read observations for test
dataTest = read.table("./test/X_test.txt")
# read observations for train
dataTrain = read.table("./train/X_train.txt")
# read subjects for test
dataSubjectTest = read.table("./test/subject_test.txt")
# read subjects for train
dataSubjectTrain = read.table("./train/subject_train.txt")
# read activities for test
dataYTest = read.table("./test/y_test.txt")
# read activities for train
dataYTrain = read.table("./train/y_train.txt")
# merge test data and train data
dataComplete =  rbind(dataTest, dataTrain)

###########################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# read features
features = read.table("./features.txt")

# create vector positions with mean and std measures
columnSelectedMean = features[grep("mean", features$V2),1]
columnSelectedStd = features[grep("std", features$V2),1]
columnSelected = c(columnSelectedMean, columnSelectedStd)
dataSelected = dataComplete[,columnSelected]

# removes characters specials in the labels

# replace "-" with empty value
features$V2 = gsub("-", "", features$V2)
# replace "(" with empty value
features$V2 = gsub("\\(", "", features$V2)
# replace ")" with empty value
features$V2 = gsub(")", "", features$V2)
# replace "," with empty value
features$V2 = gsub("\\,", "", features$V2)

###########################################################################
# 4. Appropriately labels the data set with descriptive variable names.
j = 1
for(i in columnSelected) {
  colnames(dataSelected)[j] = features[features$V1 == i,2]
  j = j + 1
} 

# Merge data selected with other columns -> subjects and activities
dataSelected = cbind(dataSelected,rbind(dataSubjectTest,dataSubjectTrain))
dataSelected = cbind(dataSelected,rbind(dataYTest,dataYTrain))

# last position rename columns
columnsdataSelected = length(colnames(dataSelected))
colnames(dataSelected)[columnsdataSelected - 1] = "Subject"
colnames(dataSelected)[columnsdataSelected] = "Activity"

###########################################################################
# 3.Uses descriptive activity names to name the activities in the data set
dataSelected[dataSelected$Activity == 1, columnsdataSelected] = "WALKING"
dataSelected[dataSelected$Activity == 2, columnsdataSelected] = "WALKING_UPSTAIRS"
dataSelected[dataSelected$Activity == 3, columnsdataSelected] = "WALKING_DOWNSTAIRS"
dataSelected[dataSelected$Activity == 4, columnsdataSelected] = "SITTING"
dataSelected[dataSelected$Activity == 5, columnsdataSelected] = "STANDING"
dataSelected[dataSelected$Activity == 6, columnsdataSelected] = "LAYING"

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Using library dplyr
dataSummarized <-
dataSelected %>%
group_by(Subject,Activity) %>%
summarise_each(funs(mean))

# for submmit
write.table(dataSummarized, file="dataSummarized.csv", sep = ",", row.name=FALSE)
    