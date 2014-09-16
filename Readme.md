**********************************************
Coursera - Getting and Cleaning Data project
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 

This fie describes the R script called run_analysis.R that does the following:
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
**********************************************

#1.Merge the training and the test sets to create one data set:
The script uses read.table() to read the text files X_train.txt,y_train.txt and subject_train.txt. y_train column is named as activity_code and subject_train is named subject_code. cbind() is used to combine all these tables into a single data set named train.
The script uses read.table() to read the text files X_test.txt,y_test.txt and subject_test.txt. y_test column is named as activity_code and subject_test is named subject_code. cbind() is used to combine all these tables into a single data set named test.
rbind() is used to combine the train and test datasets into a dataset named fulldata.

#2.Extract only the measurements on the mean and standard deviation for each measurement:
The script extracts the variables activity_code and subject_code so that they can be remerged with the mean and std related variables.
A subset of fulldata is created by extracting all variables related to mean and std measurements. This is done using grep() for pattern matching.
The script combines the subset and activity_code and subject_code to create dataset named newdata.

#4.Appropriately label the data set with descriptive variable names:
The third step is done at the end since activity_code numeric value is required for step 5. 
In order to label variables appropriately, the brackets are removed from the names using gsub(). The column names are assigned to the dataset.

#5.From the data set in step 4, create a second, independent tidy data set with the 
#average of each variable for each activity and each subject:
Average of the activity measurements per activity for each subject,  is calculated using ddply(). The dataset is named result.

#3.Use descriptive activity names to name the activities in the data set:
The activity_code values are replaced with descriptive names as given in activity_labels.txt using lapply(). The activity_code variable is renamed Activity_name. The final dataset 'result' is returned.
 








