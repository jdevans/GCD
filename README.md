## run_analysis.R
Assembles and summarizes data collected from accelerometers in the Samsung Galaxy S smartphone. Reads accelerometer data resulting from a series of activities, such as walking, sitting, etc. See the file "input_codebook.txt" for details on the input data. (A full description of the data is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.)

The data used by this script are at the following URL:
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

After unpacking the zip file, place this R routine alongside the "test" and "train" directories.

This script takes no arguments; it reads from the following files:
* features.txt
* train/{X,y,subject}_train.txt
* test/{X,y,subject}_test.txt

It performes the following operations on the input data:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Specifically, the script computes the means of 66 different measurements for each of 6 activities and for each of 30 test subjects. It writes this table (180 rows x 68 columns) into the file "GCD_Project_output.txt". See the file "output_codebook.txt" for details on the output data.
