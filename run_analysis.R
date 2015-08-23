# run_analysis.R ######################################
# Assembles and summarizes data collected from accelerometers from the Samsung Galaxy S smartphone. 
#
# Here are the data for the project:
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 
#
# A full description of the data of is available at
#     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# This script performes the following operations on the input data:
# 1 - Merges the training and the test sets to create one data set.
# 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3 - Uses descriptive activity names to name the activities in the data set
# 4 - Appropriately labels the data set with descriptive variable names. 
# 5 - From the data set in step 4, creates a second, independent tidy data set 
#     with the average of each variable for each activity and each subject.
########################################################

# First we read in the feature (field) names to associate with (headerless) data
# Requirement 4: Appropriately label the data set with descriptive variable names. 
features <- read.table ("features.txt", colClasses=c("NULL","character"), col.names=c("num", "name"))
features <- features[,1]  # Reshape 1-column dataframe to a vector

# Extract only means and standard deviations -- the fields containing "mean()" and "std()"
# Use make.names to ensure syntactically valid column names, for use at read.table below
# (e.g., "tBodyAcc-mean()-Z" becomes "tBodyAcc.mean...Z")
means <- make.names(features[grep ("mean\\(", features)])
stds <-  make.names(features[grep ("std\\(",  features)])

# Read in the (6) activity names and their codes
activities <- read.table ("activity_labels.txt", col.names=c("activityCode", "activity"))

# Requirement 2: Extract (only) the means and standard deviations for each measurement. 
# Read in the training data set: X (accelerometer readings), y (activities), and test subjects
X_train <- read.table("train/X_train.txt",col.names=features)[,c(means,stds)]
## Only the columns listed in "means" and "stds" get stored in X_train
## Note that read.table implicitly runs "make.names" on "features" to ensure valid column names: 
## e.g., "tBodyAcc-mean()-Z" becomes "tBodyAcc.mean...Z". (We'll tidy up these names later.)

y_train <- read.table("train/y_train.txt", col.names=c("activityCode"))
subject_train <- read.table("train/subject_train.txt", col.names="subject")

# Repeat last three steps for test data set
X_test <- read.table("test/X_test.txt",col.names=features)[,c(means,stds)]
y_test <- read.table("test/y_test.txt", col.names="activityCode")
subject_test <- read.table("test/subject_test.txt", col.names="subject")

# Requirement 1: Merge the training and the test sets to create one data set.
# Combine training and test data (just append one below the other)
X <- rbind(X_train,X_test)
y <- rbind(y_train,y_test)
subjects <- rbind(subject_train,subject_test)
# Combine measurements, activity labels, and test subjects
data <- cbind (X,y, subjects)

# Requirement 3: Use descriptive activity names to name the activities in the data set
# Merge in the activity names (1-6)
## (NOTE: "merge" reorders everything! Make sure we're done with rbind/cbind operations.)
data <- merge(data, activities)  # Implicitly use the shared field "activityCode"
data$activityCode <- NULL        # Drop the activityCode field - we don't need it anymore

# Tidy up those variable names a bit (remove all occurrences of "..")
names(data) <- gsub ("\\.\\.","", names(data))
# means <- gsub ("\\.\\.","", means)
# stds <- gsub ("\\.\\.","", stds)

# Finally, Requirement 5: From this data set, create a second, independent tidy data set
# with the average of each variable by subject and by activity.
dataMelt <- melt(data,id=c("subject","activity")) # (Use all other columns as measure vars)
output <- dcast(dataMelt, subject + activity ~ variable, mean) # Produce averages by subject & activity
# And write out this table
write.table (output, file="GCD_Project_output.txt", row.names=FALSE)
