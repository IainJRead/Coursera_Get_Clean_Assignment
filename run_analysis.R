#!/usr/bin/Rscript

## Getting and Cleaning Data Week 4 Assignment
## 1. Import test and train datasets from UCI HAR Dataset
## 2. Merge into a single dataset
## 3. Extract only the mean and stdev for each measurement
## 4. Use descriptive activity names to name the activities in the dataset
## 5. Use descriptive variable names
## 6. Create a second, independent tidy data aset with the average of each var
##    for each activity and subject

library(dplyr)
library(plyr)

run_analysis <- function(){
    # Read in data sets from UCI HAR directory and merge
    X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
    X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
    X_full <- rbind(X_train, X_test)
    
    # Use features.txt to get X column names
    features <- read.table("UCI HAR Dataset/features.txt")
    colnames(features) <- c("Column.Index", "Feature.Label")
    
    # Keep only the mean and stdev per measurement
    names_to_keep <- features[grepl("mean\\(\\)", features$Feature.Label) | grepl("std\\(\\)", features$Feature.Label),]
    
    # Select from merged dataset based on names, and relabel columns accordingly
    X_full <- select(X_full, names_to_keep$Column.Index)
    colnames(X_full) <- names_to_keep$Feature.Label
    
    subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
    subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
    subject_full <- rbind(subject_train, subject_test)
    colnames(subject_full) <- c("Subject")
    
    Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
    Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
    Y_full <- rbind(Y_train, Y_test)
    
    colnames(Y_full) <- c("Activity_Category")
    
    # Use activity_labels.txt to get activity names
    activities <- read.table("UCI HAR Dataset/activity_labels.txt")
    colnames(activities) <- c("Category", "Activity")
    
    # Assign labels to each activity in Y, then drop the numerical category
    Y_full <- merge(Y_full, activities, by.x="Activity_Category", by.y="Category", all.x=TRUE)
    Y_full <- select(Y_full, -Activity_Category)
    
    # Combine all three datasets together
    XY_full <- cbind(subject_full, Y_full, X_full)
    
    # Generate dataset of mean values per variable, grouped by Subject and Activity
    summary_set <- ddply(XY_full, .(Subject, Activity), numcolwise(mean))   
}

# runs only when script is run by itself
if (sys.nframe() == 0){
    run_analysis()
}
