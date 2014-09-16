setwd("F:/R/DataCleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset");

#1.Merge the training and the test sets to create one data set.
#Combine training data with its activity and subjects data. Assign column name for activity and subject variables.
X_train <- read.table("F:/R/DataCleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", quote="\"");
y_train <- read.table("F:/R/DataCleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", quote="\"");
colnames(y_train)<-c("Activity_code")
subject_train <- read.table("F:/R/DataCleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", quote="\"");
colnames(subject_train)<-c("Subject_code");
train <- cbind(X_train,y_train,subject_train);

#Combine test data with its activity and subjects data. Assign column name for activity and subject variables.
X_test <- read.table("F:/R/DataCleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", quote="\"");
y_test <- read.table("F:/R/DataCleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", quote="\"");
colnames(y_test)<-c("Activity_code")
subject_test <- read.table("F:/R/DataCleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", quote="\"");
colnames(subject_test)<-c("Subject_code");
test <- cbind(X_test,y_test,subject_test);

fulldata <- rbind(train,test);

#2.Extract only the measurements on the mean and standard deviation for each measurement.
#Before subsetting variables related to mean and std values, extract the activity and subject variables
act_subj_codes <- fulldata[c('Activity_code','Subject_code')];

features <- read.table("F:/R/DataCleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", quote="\"");

#Use grep to specify pattern matching for "mean" and "std" variables
v.names <- c('mean','std');
patt<- sub(',\\s','|',(toString(v.names)));
id.group <- grep(patt,features$V2);

mean_std_data <- fulldata[,id.group];#has only columns related to mean or std
newdata <- cbind(mean_std_data,act_subj_codes);#new dataset with mean, std, activity_code and subject_code variables

#4.Appropriately label the data set with descriptive variable names. 
newnames <- features[id.group,];
newnames1<- gsub("\\()","",newnames$V2);#remove () from names
newnames1 <- as.vector(newnames1);
newnames1 <- c(newnames1,"Activity_code","Subject_code");
colnames(newdata) <- newnames1;

#5.From the data set in step 4, create a second, independent tidy data set with the 
#average of each variable for each activity and each subject.
library(plyr);
result <- ddply(newdata,.(Subject_code,Activity_code),colMeans);

#3.Use descriptive activity names to name the activities in the data set
activitylabels <- read.table("F:/R/DataCleaning/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", quote="\"");

#Replace activity codes with activity descriptive names in result dataset using lapply
labelactivities <- function(x){  
  if(x == 1){x = as.vector(as.character(activitylabels[1,2]));}
  else if(x == 2){x = as.vector(as.character(activitylabels[2,2]));}
  else if(x == 3){x = as.vector(as.character(activitylabels[3,2]));}
  else if(x == 4){x = as.vector(as.character(activitylabels[4,2]));}
  else if(x == 5){x = as.vector(as.character(activitylabels[5,2]));}
  else if(x == 6){x = as.vector(as.character(activitylabels[6,2]));}
};

result$Activity_code <- sapply(as.vector(result$Activity_code),labelactivities);
colnames(result)[80] <- "Activity_name";
result;

