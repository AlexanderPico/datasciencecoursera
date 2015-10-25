## R Code for Course Project: Getting and Cleaning Data
#
# Download and uncompress the data for the project into your local working directory:
#    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
# A full description is available at the site where the data was obtained:
#    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# You should have a folder named "UCI HAR Dataset" in your working directory. Now run the R code in the following sections to process the files in this folder into a tidy dataset.
#
### Reading data sets
# The test and train datasets space-delimited tables without headers. They should have 561 columns.

ftest<-"UCI HAR Dataset/test/X_test.txt"
test<-read.delim(ftest,sep="", header=F)

ftrain<-"UCI HAR Dataset/train/X_train.txt"
train<-read.delim(ftrain,sep="", header=F)

### Add descriptive column names
# The columns are given in the features.txt file.

fcols<-"UCI HAR Dataset/features.txt"
collabels<-read.delim(fcols,sep="", header=F)
colnames(test)<-collabels[[2]]
colnames(train)<-collabels[[2]]

### Add new column with descriptive activity names
#The rows are coded in the corresponding "Y" files and decoded by the activity_labels.txt file.

ftestrows<-"UCI HAR Dataset/test/Y_test.txt"
testrows<-read.delim(ftestrows,sep="", header=F)
colnames(testrows)<-"id"

ftrainrows<-"UCI HAR Dataset/train/Y_train.txt"
trainrows<-read.delim(ftrainrows,sep="", header=F)
colnames(trainrows)<-"id"

frows<-"UCI HAR Dataset/activity_labels.txt"
rowlabels<-read.delim(frows,sep="", header=F)
colnames(rowlabels)<-c("id","label")

library(plyr)
testrowlabels<-join(testrows,rowlabels,by="id")
test$activityLabel<-testrowlabels[[2]]

trainrowlabels<-join(trainrows,rowlabels,by="id")
train$activityLabel<-trainrowlabels[[2]]

### Add new column with subject code

ftestsubs<-"UCI HAR Dataset/test/subject_test.txt"
testsubs<-read.delim(ftestsubs,sep="", header=F)
test$subjectId<-testsubs[[1]]

ftrainsubs<-"UCI HAR Dataset/train/subject_train.txt"
trainsubs<-read.delim(ftrainsubs,sep="", header=F)
train$subjectId<-trainsubs[[1]]

### Merge test and train
# They have identical columns, so just combine the rows.

combo<-rbind(test,train)

### Extract only mean and stdev columns
# These are the first 6 columns of every XYZ set of features (+40, +79) and the first 2 columns of every Mag set of features (+13), and each of the angle features. Plus keep final columns with activityLabel and subjectId

tidy1<-combo[,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543,555:563)]
colnames(tidy1)

### Generate new tidy data set with averages of each variable for each activity and each subject
# Use aggregate function to perform mean() on each column based on unique grouping of activtyLabel and subjectID (i.e., the last two columns). 

tidy2<-aggregate(tidy1[,1:73],list(tidy1$activityLabel,tidy1$subjectId) ,mean)

# This will generate a new tidy data set with unique groups defined in the first two columns followed by means of all the other columns. There are 6 activity types and 30 subjects, so the new tidy data set should have 180 rows.

### Write data set out as text file

write.table(tidy2, file="final_tidy.txt", row.names=F)

#Enjoy!
    