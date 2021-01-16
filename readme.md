# GETTING AND CLEANING DATA PROJECT

## DESCRIPTION OF THE PROJECT
This is the end of course project of getting and cleaning data class on coursera. The goal is to get and clean data, in order to generate a tidy dataset.\
* Data can be downloaded from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones \
* Description of the data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip \

The R script called run_analysis.R does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## FILES
* *run_analysis.R*: this is the R code for getting and cleaning the dataset. This code also generates the data_summary.txt file, which is discussed below.\
* *data_summary.txt* file: this contains the average of each variable for each activity and each subject of the initial dataset\
* *codebook.md*: contains a description of the study design as well as a description of the variables with corresponding units\


