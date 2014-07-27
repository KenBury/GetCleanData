GetCleanData
============

R Script and results for Getting and Cleaning Data course assignment

The run_analysis.R is an R script that does the following:

1. Sets the working directory
2. Downloads the UCI HAR dataset.zip file and extracts it
3. There are several data files that are read into data frames; x_train.txt, y_train.txt, x_test.txt, y_test.txt into xtrain, ytrain, xtest, ytest repectively.
4. There is a subject code data files that are read into data frames; subjecct_train.txt, subject_test.txt into subjecttrain, subjecttest repectively.
5. There is an activity code/labels file activity_labels.txt that is read into a data frame.
6. The ytrain and xtrain data frames have activity codes that need to be joined with the corresponding activity code in the activitylabels data frame.
	This is done with a merge and the results are two data files activitytrain and activity test.
7. The train data frames; activitytrain,subjecttrain,xtrain are column joined together into the alldatatrain data frame. The columns for ActivityType, and SubjectCode renamed.
8. The test data frames; activitytest,subjecttest,xtest are column joined together into the alldatatest data frame. The columns for ActivityType, and SubjectCode renamed.
9. The two data frames; alldatatrain and alldatatest are row joined together into the alldata data frame.
10. The features.txt file has all the descriptive names for the measured variables, it is read into a the data frame features.
11. The assignment is only interested in the mean and standard deviation variables. Each of the variables mean() or std() in the name. 
	A vector of the index locations of those variables is formed using a matched grep of the mean() variables resulting in meanvector
	A vector of the index locations of those variables is formed using a matched grep of the std() variables resulting in stdvector
12. The index locations of both the mean() and std() are formed with a combination of the meanvector and stdvector resulting in featuresvector
13. The column names of the variables in the the alldata data frame are changed using the descriptive names in the features data frame.
14. The data needs the ActivityType and SubjectCode and the mean() and std() variables. Select just those columns to form a keepdata data frame.
15. The average of the variables for the subject codes by activity is neede. Melt keepdata into meltkeepdata with the ActivityType and SubjectCode as IDs and the rest variables.
16. Cast meltkeepdata by ActivityType and the averages of each variable into a tidydata data frame.
17. The column names of the tidydata frame need to be renamed to refect the average of the original descriptive name. 
18. Write the tidydata data frame out to a tidydata.txt file.

The script was run using Rstudio Version 0.98.953, R version 3.1.1, Windows 7 platform
