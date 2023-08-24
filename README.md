# Coursera_Get_Clean_Assignment
Repo for week 4 assignment of getting and cleaning data

# Overview
This repo contains a single R script, `run_analysis.R` which imports a series of datasets from the `UCI HAR Dataset` folder:
- `train/X_train.txt`
- `train/Y_train.txt`
- `train/subject_train.txt`
- `test/X_test.txt`
- `test/Y_test.txt`
- `test/subject_test.txt`
- `features.txt`
- `activity_labels.txt`

These text files are all imported via `read.table()`.

The X datasets (feature observations) are vertically concatenated. Using regex on the features data set, the columns of interest (mean and stdev measurements) are selected. The X data set is then filtered and labelled by these selected columns.

The Y and subject data sets are similarly vertically concatenated, and column names are manually assigned since they have one column each.

The Y data set is modified from numerical categories to descriptive character categories using the activity labels dataset.

All of the above data sets are then merged into a single data set, `XY_full`.

`XY_full` is summarised by `Subject` and `Activity` using `ddply` to produce the `summary_set` table.