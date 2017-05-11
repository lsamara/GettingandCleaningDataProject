#Louis Samara
# File: run_analysis.R
#
# Overview
# This R script (run_analysis.R) does the following:
#   1. Merges the training data and the test sets to create one data set.
#   2. Extracts only the measurements on the mean and standardard deviation for each measurement.
#   3. Uses descriptive activity names to name the activities in the data set.
#   4. Appropriately labels the data set with descriptive variables names.
#   5. From the data set in step 4, creates a second, independent tidy data set with the average
#       of each variable for each activity and each subject. The name of the this output is 
#       "tidy_data.txt".
#
# add appropriate libraries: at least dplyr
library(dplyr)

# accessing the data from the following repositories:
# a) http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# b) https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
#
# Getting the data
# download zip file containing data if it hasn't already been downloaded
#
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"
#
if (!file.exists(zipFile)) {
    download.file(zipUrl, zipFile, mode= "wb")
}

# Unarchive zip file containing the data if the repository doesn't already exist
dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)) {
  unzip(zipFile)
}
#
# Reading training data
#
trainingSubjects <- read.table(file.path(dataPath, "train", "subject_train.txt"))
trainingValues <- read.table(file.path(dataPath, "train", "X_train.txt"))
trainingActivities <- read.table(file.path(dataPath, "train", "Y_train.txt"))
#
# Reading test data
#
testSubjects <- read.table(file.path(dataPath, "test", "subject_test.txt"))
testValues <- read.table(file.path(dataPath, "test", "X_test.txt"))
testActivities <- read.table(file.path(dataPath, "test", "Y_test.txt"))
#
# Read features keeping the integrity
#
features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)
#
#read activity labels 
#
activities <- read.table(file.path(dataPath, "activity_labels.txt"))
colnames(activities) <- c("activity_Id", "activity_Label")
#
#
#   1. Merges the training data and the test sets to create one data set.
#
#

merged_Activities <- rbind(
                    cbind(trainingSubjects, trainingValues, trainingActivities),
                    cbind(testSubjects, testValues, testActivities)
)
#
# formating columns
colnames(merged_Activities) <- c("subject", features[,2], "activity")
#
#   2. Extracts only the measurements on the mean and standardard deviation for each measurement.
#
columnsLabels <- grepl("subject|activity|mean|std", colnames(merged_Activities))
#
#
merged_Activities <- merged_Activities[,columnsLabels]
#
#
#
#   3. Uses descriptive activity names to name the activities in the data set.
#
#
merged_Activities$activity <- factor(merged_Activities$activity,
                                      levels = activities[, 1], labels = activities[,2])
#
#   4. Appropriately labels the data set with descriptive variables names.
merged_ActivitiesCols <- colnames(merged_Activities)
# cleaning up 
#
merged_ActivitiesCols <- gsub( "[\\(\\)-]", "", merged_ActivitiesCols)
#
#
# introducing readibility to keep every body's sanity! 
#
#
merged_ActivitiesCols <- gsub("^f", "frequencyDomain", merged_ActivitiesCols)
merged_ActivitiesCols <- gsub("^t", "timeDomain", merged_ActivitiesCols)
merged_ActivitiesCols <- gsub("Acc", "Accelerometer", merged_ActivitiesCols)
merged_ActivitiesCols <- gsub("Gyro", "Gyroscope", merged_ActivitiesCols)
merged_ActivitiesCols <- gsub("Mag", "Magnitude", merged_ActivitiesCols)
merged_ActivitiesCols <- gsub("Freq", "Frequency", merged_ActivitiesCols)
merged_ActivitiesCols <- gsub("mean", "Mean", merged_ActivitiesCols)
merged_ActivitiesCols <- gsub("std", "StandardDeviation", merged_ActivitiesCols)
merged_ActivitiesCols <- gsub("BodyBody", "Body", merged_ActivitiesCols)
colnames(merged_Activities) <- merged_ActivitiesCols
#
#
#
#   5. From the data set in step 4, creates a second, independent tidy data set with the average
#       of each variable for each activity and each subject. 
#
#
merged_ActivitiesMeans <- merged_Activities %>%
  group_by(subject, activity) %>%
  summarize_each(funs(mean))
#
# write to output file "tidy_data.txt"
#
write.table(merged_ActivitiesMeans, "tidy_data.txt", row.names = FALSE, quote = FALSE)
