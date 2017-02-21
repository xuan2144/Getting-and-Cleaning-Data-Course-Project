#download zip file
fileurl <- c("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
download.file(url = fileurl, destfile = "./project.zip")

##check the file names under zip file
unzip("project.zip", list = T)

#read feature data
features <- read.table(unz("project.zip","UCI HAR Dataset/features.txt"))

#read activity_labels data 
activity <- read.table(unz("project.zip","UCI HAR Dataset/activity_labels.txt"))

#read training data sets
subject_train <- read.table(unz("project.zip","UCI HAR Dataset/train/subject_train.txt"))
x_train <- read.table(unz("project.zip","UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(unz("project.zip","UCI HAR Dataset/train/y_train.txt"))

#read test data sets
subject_test <- read.table(unz("project.zip","UCI HAR Dataset/test/subject_test.txt"))
x_test <- read.table(unz("project.zip","UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(unz("project.zip","UCI HAR Dataset/test/y_test.txt"))

#load library
library(dplyr)
library(data.table)

#rename column name in subject and lable data file
#add "category" to record the data source (train or test) before merge
y_train <- rename(y_train, activity = V1) %>% mutate(category = "train") 
y_test <- rename(y_test, activity = V1) %>% mutate(category = "test")
subject_train <- rename(subject_train, subject = V1)
subject_test <- rename(subject_test, subject = V1)

#task1: Merges the training and the test sets to create one data set
train_data <- cbind(subject_train, y_train, x_train)
test_data <- cbind(subject_test, y_test, x_test)
merge_data <- rbind(train_data, test_data)

#task2: Extracts only the measurements on the mean and standard deviation
feature_lines <- grep("(mean\\(\\))|(std\\(\\))", features$V2)
mean_std_data <- merge_data[, c(1, 2, 3, (feature_lines + 3))]

#task3: Uses descriptive activity names to name the activities in the data set
mean_std_data_actname <- mutate(mean_std_data, act_name = factor(mean_std_data$activity, labels = activity$V2))

#task4: Appropriately labels the data set with descriptive variable names
#step1 - substruct needed feature names
#step2 - assign names vector to data
match_feature_name <- features[feature_lines, 2]
names(mean_std_data_actname) <- c("subject", "activity", "category", as.character(match_feature_name), "act_name")

#task5: creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject
#step1 - melt data with id: subject & activity, measure all other variables
#step2 - cast data to get mean for variables
datamelt <- melt(select(mean_std_data_actname, -category, -act_name), id=c("subject", "activity"))
newdataset <- dcast(datamelt, subject+activity ~ variable, mean)

#write result tidy data into txt file
write.table(newdataset, file = "./ProjectDataResult.txt", row.names = F)
