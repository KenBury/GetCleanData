setwd("~/Coursera/getdata-005/Assignment")
## the getdata-projectfiles-UCI HAR Dataset.zip file downloaded and extracted
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## into the /UCI HAR Dataset/ directory
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "./getdata-projectfiles-UCI HAR Dataset.zip",method="auto")
unzip("./getdata-projectfiles-UCI HAR Dataset.zip")
## read in "~\getdata-005\Assignment\UCI HAR Dataset\train\X_train.txt
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
## read in "~\getdata-005\Assignment\UCI HAR Dataset\train\y_train.txt
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
## read in "~\getdata-005\Assignment\UCI HAR Dataset\test\X_test.txt
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
## read in "~\getdata-005\Assignment\UCI HAR Dataset\test\y_test.txt
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
## read in "~\getdata-005\Assignment\UCI HAR Dataset\train\subject_txt
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
## read in "~\getdata-005\Assignment\UCI HAR Dataset\test\subject_txt
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
## read in the "~\getdata-005\Assignment\UCI HAR Dataset\activity_labels.txt"
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
## the 'y' files have the activity code, merge them
activitytrain <- merge(ytrain,activitylabels,by.x="V1",by.y="V1",all=TRUE)
activitytest <- merge(ytest,activitylabels,by.x="V1",by.y="V1",all=TRUE)

## start joining the data.frames and set the activity and subject 
## column names
alldatatrain <- cbind(activitytrain$V2,subjecttrain,xtrain)
colnames(alldatatrain)[1] <- "ActivityType"
colnames(alldatatrain)[2] <- "SubjectCode"
alldatatest <- cbind(activitytest$V2,subjecttest,xtest)
colnames(alldatatest)[1] <- "ActivityType"
colnames(alldatatest)[2] <- "SubjectCode"
alldata <- rbind(alldatatrain,alldatatest)
## cleaning up the column headings using the features.txt file
features <- read.table("./UCI HAR Dataset/features.txt")
## get a vector of the index locations of the headings with only mean() and stg()
meanvector <- grep("mean()",features$V2,fixed = TRUE)
stdvector <- grep("std()",features$V2,fixed = TRUE)
featuresvector <- c(meanvector,stdvector)
## now change the column headings for the alldata frame,  
for (i in featuresvector) {
        ## alldata already has two new columns so offset the index by 2
        colnames(alldata)[i+2] <- as.character(features[i,2])
        }
## now keep only the good columns
keepdata <- alldata [,c(1:2, 2+featuresvector)]
## now compute the average for each variable for each activity and each subject
library(reshape2)
keepdatamelt <- melt(keepdata, id=1:2, measure.vars=c(colnames(keepdata)[3:length(colnames(keepdata))]))
## cast it back with the mean of the variables for each activity and subject
tidydata <- dcast (keepdatamelt, ActivityType ~ variable,mean)
## tidy up the variable names
for (i in 2:length(colnames(tidydata))){
        colnames(tidydata)[i] <- paste ("Average of the", colnames(tidydata)[i], "variable for all subjects", sep=" ")
}

## now write out the tidydata.txt file
write.table(tidydata, file = "./tidydata.txt", row.names=FALSE)

