##The original data description:
The following original data files are used in this R programing project.
The Original Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

##The result tidy data description:

* 'ProjectDataResult.txt": the outcome tidy data file, which includes the average of each variable for each activity and each subject.

subject: 1 - 30 volunteers in this experiment.
activity: 1 - 6 activities being monitored.
other variables are feature names, described in features_info.txt.
