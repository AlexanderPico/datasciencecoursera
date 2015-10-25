## CodeBook for Course Project: Getting and Cleaning Data

See either the output final_tidy.txt or execute the R code in run_analysis.R to generate a new tidy data set from the original UCI HAR Dataset found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The description of the original dataset can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Files
* run_analysis.R - R code to generate a new tidy dataset
* final_tidy.txt - the output of run_analysis.R

### Tidy dataset
There are 75 columns in the new tidy dataset. The first 2 columns identify groups based on:

1. Group.1 = Activity (6 types)
2. Group.2 = Subject identifier (1-30)

The other 73 columns are means of the original mean() and std() for the following measurements:

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag
* angle(XYZ,gravityMean)
* angle(tBodyAccMean)
* angle(tBodyAccJerkMean)
* angle(tBodyGyroMean)
* angle(tBodyGyroJerkMean)

See the original documentation in UCI HAR Datasets for additional details.