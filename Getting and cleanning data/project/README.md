==================================================================
Tidy data generation for Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Javier Samir Rey 
Coursera data specialization 
January 2015
==================================================================

This script takes data and merges in the files:

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt'

Performing the following steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

For each record in tidy dataframe: dataSummarized
======================================

- Subject and activity agruped.
- A 79-columns with measures for mean and std.
- Its activity label. 
- Its Subejct.

Notes: 
======
- This code assumes that the working directory is the unzipped file: zip getdata-projectfiles-UCI HAR Dataset
- Before install package: dplyr, install.packages("dplyr").

For more information about this script: jreyro@gmail.com

