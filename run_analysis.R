library(dplyr)
library(tidyr)

# Downloading the file
if(!file.exists("data")) {
    dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filePath <- "./data/accelerometers.zip"
download.file(fileUrl, destfile = filePath, method = "curl")

# Unzip file
unzip(zipfile="./data/accelerometers.zip", exdir="./data")

# Show all files contain in the new unzipped folder
new_path <- "./data/UCI HAR Dataset/"
all_files <- list.files(new_path, recursive = TRUE) #recursive argument allows to list files in sub-directories
###--------------------------------------------------
### Create training and test datasets
###     Read features and activity_labels files
###     Read X_*, Y_* files of train and test folders; from those files we will want the mean and SD
###--------------------------------------------------
## Features file & Activity labels
features_path <- "./data/UCI HAR Dataset/features.txt"
features <- read.table(features_path, header = FALSE)

activity_path <- "./data/UCI HAR Dataset/activity_labels.txt"
activity_labels <- read.table(activity_path, header = FALSE)
colnames(activity_labels) <- c("activityID", "activityNAME")

## Training data set
# Reading data in R
training_path_x <- "./data/UCI HAR Dataset/train/X_train.txt"
training_path_y <- "./data/UCI HAR Dataset/train/Y_train.txt"
training_path_subject <- "./data/UCI HAR Dataset/train/subject_train.txt"
x_train <- read.table(training_path_x, header = FALSE)
y_train <- read.table(training_path_y, header = FALSE)
subject_train <- read.table(training_path_subject, header = FALSE)

# Tidying column names of train datasets
colnames(x_train) <- features[, 2]
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectID"

# Merging those three datasets to get the train_data dataset
train_data <- cbind(x_train, y_train, subject_train)

## Test data set
# Reading data in R
test_path_x <- "./data/UCI HAR Dataset/test/X_test.txt"
test_path_y <- "./data/UCI HAR Dataset/test/Y_test.txt"
test_path_subject <- "./data/UCI HAR Dataset/test/subject_test.txt"
x_test <- read.table(test_path_x, header = FALSE)
y_test <- read.table(test_path_y, header = FALSE)
subject_test <- read.table(test_path_subject, header = FALSE)

# Tidying column names of test datasets
colnames(x_test) <- features[, 2]
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"

# Merging those three datasets to get the test_data dataset
test_data <- cbind(x_test, y_test, subject_test)

###--------------------------------------------------
### Merge the train_data and the test_data datasets to create one data set (all_data)
###--------------------------------------------------
# Check if we have the right columns names in the right order before merging data sets
all(colnames(train_data) == colnames(test_data))
# Merge
all_data <- rbind(train_data, test_data)

###--------------------------------------------------
### Extract only the measurements on the mean and standard deviation for each measurement
###--------------------------------------------------
# Identifying the columns that we need
column_keep <- (grepl("mean", colnames(all_data)) | grepl("std", colnames(all_data)) 
                | grepl("subjectID", colnames(all_data)) 
                | grepl("activityID", colnames(all_data)))

# Select only the columns identified
all_data_MeanSD <- all_data[, column_keep == TRUE] 

###--------------------------------------------------
### Uses descriptive activity names to name the activities in the data set
###--------------------------------------------------
all_data_final <- merge(all_data_MeanSD, activity_labels, by = "activityID", all.x = TRUE)

###--------------------------------------------------
### Appropriately labels the data set with descriptive variable names. 
###     This step was performed when creating the datasets
###--------------------------------------------------

###--------------------------------------------------
### From the data set in step 4, creates a second, independent tidy data set with 
### the average of each variable for each activity and each subject.
###--------------------------------------------------
data_summary <- aggregate(. ~subjectID + activityID, all_data_final, mean)
data_summary <- data_summary[order(data_summary$subjectID, data_summary$activityID),]
rownames(data_summary) <- NULL

# Exporting the tidy data set as a text file
write.table(data_summary, "data_summary.txt")





