# GettingandCleaningDataProject
This repository contain scripts that demonstrate the ability to collect, work, with, and clean a data set (as per the course instructions)

This project emphasizes the principles on how to make a tidy data set.  The data used was collected from an accelerometer, and gyroscope of a Samsung Galaxy S2 smart phone.  

This repository contains the following files:
README.md, this file provides a brief overview of the data set and how it was created
tidy_data.txt, this file contains the cleaned version
CodeBook.md.docx, the codebook, which describes the content of the data set, its variables, and manipulations, also called transformations.  
run_analysis.R, the R script that was used to generate the data set.

Study Design
The source of the data set for this project was obtained from the Human Activity Recognition Using Smartphones Data Set.
The experiment was carried out using 30 volunteers of ages 19-48.  Each person performed 6 actitives.

The data set was partitioned in two 70% of the participants generating the training set, and the other 30% generating the test data.

Both training and test data set were merged to generate the combined data set and only the mean and standard deviation were kept to generate average per participant and activity.

Creating the data set
The R script "run_analysis.R" can be used to create the data set.  This script included the retrieving, manipulating, formating as follows:
  Downloading and un archiving if the data didn't exists
  Reading the data
  Merging both data sets (training and test)
  Extracting only the mean and standard deviation measurements
  Introduced extended descriptions for activities for ease on readebility
  Create the second tidy set with the average of each variable for each activity for each participant
  Write the "tidy_data.txt" file.
  
  
  Environment:
  OS: Windows 10, 32 bit
  R Version: 3.3.2
  
  It is necessary to load the "dplyr" package.  
