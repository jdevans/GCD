## run_analysis.R ######################################
Assembles and summarizes data collected from accelerometers from the Samsung Galaxy S smartphone. 
* Here are the data for the project:
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 
* A full description of the data of is available at
   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This script performes the following operations on the input data:
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set 
    with the average of each variable for each activity and each subject.
