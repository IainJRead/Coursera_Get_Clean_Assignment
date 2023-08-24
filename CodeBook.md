#Code Book
Description of variables, data and transformations within this repo, and in particular `run_analysis.R`

## Variables
###X_train - data.frame
`data.frame` containing the contents of `UCI HAR Dataset/train/X_train.txt`, a set of measurements from Samsung Galaxy S sensors.
7532 obs. of 561 variables.

###X_test - data.frame
`data.frame` containing the contents of `UCI HAR Dataset/test/X_test.txt`, a set of measurements from Samsung Galaxy S sensors.
2947 obs. of 561 variables.

###Y_train - data.frame
`data.frame` containing the contents of `UCI HAR Dataset/train/Y_train.txt`.
7532 obs. of 1 variable, an activity label: `{WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING}`.

###Y_test - data.frame
`data.frame` containing the contents of `UCI HAR Dataset/train/Y_train.txt`.
2947 obs. of 1 variable, an activity label: `{WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING}`.

###subject_train - data.frame
`data.frame` containing the contents of `UCI HAR Dataset/train/subject_train.txt`.
7532 obs. of 1 variable, the subject label.

###subject_test - data.frame
`data.frame` containing the contents of `UCI HAR Dataset/test/subject_test.txt`.
2947 obs. of 1 variable, the subject label.

###X_full - data.frame
`data.frame` row binding `X_test` to `X_train`

###Y_full - data.frame
`data.frame` row binding `Y_test` to `Y_train` 

###subject_full - data.frame
`data.frame` row binding `subject_test` to `subject_train`

###features - data.frame
`data.frame` containing the contents of `UCI HAR Dataset/features.txt`.
561 obs. of 2 variables, the column indices and column labels of the `X_train` and `X_test` data sets

###names_to_keep - data.frame
`data.frame` containing the desired subset of column names of `features`, i.e. the mean and std measurements of each sensor

###activities - data.frame
`data.frame` containing the contents of `UCI HAR Dataset/activity_labels.txt`.
6 obs. of 2 variables, the activity category (integer 1-6) and the associated activity label `{WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING}`

###XY_full - data.frame
`data.frame` column binding `subject_full`, `Y_full` and `X_full`

###summary_Set - data.frame
`data.frame` containing the means of each variable from `XY_full`, grouped by `Subject` and `Activity`

##Transformations
###X_train, X_test, X_full and features
The test and train datasets are loaded via `read.table()` and combined into `X_full` by row binding with the train dataset occupying the uppermost rows and the test dataset occupying the lowermost rows.

`features.txt` is loaded via `read.table()` and given the column names "Column.Index" and "Feature.Label"

To filter the 561 features down to the 66 desired (mean and standard deviation per sensor), the `features` `data.frame` is filtered using `grepl`, searching for matches to "mean\\(\\)" and "std\\(\\)", and the resultant subset is stored in `names_to_keep`

`X_full` is filtered down to the desired columns using a `select()` statement, taking as an input `names_to_keep$Column.Index` as a selection criteria

Finally, the column labels are added to `X_full` using `names_to_keep$Feature.Label` as the list of names.

This results in the set of required measurements only, with descriptive feature labels for each one.

###subject_train, subject_test and subject_full
The train and test subject lists are loaded via `read.table()` and combined into `subject_full` by row binding with the train dataset occupying the uppermost rows and the test dataset occupying the lowermost rows.

Finally. `subject_full` is given the column title "Subject".

This results in the set of subjects being loaded into the workspace, with a descriptive label for the column.

###Y_train, Y_test, Y_full and activities
The test and train labels are loaded via `read.table()` and combined into `Y_full` by row binding with the train dataset occupying the uppermost rows and the test dataset occupying the lowermost rows.

`Y_full` is given the column label "Activity_Category"

`activity_labels.txt` is loaded via `read.table()` as `activities` and given the column names "Category" and "Activity"

A `merge()` operation is applied to `Y_full` and `activites`, joining on `Y_full$Activity_Category` and `activities$Category`, with `all.x = TRUE`, where `x` here refers to `Y_full`

Finally, a `select()` statement is used on `Y_full` to remove the `Activity_Category` column.

This results in a set of activity categories per record with descriptive activity labels and feature labels.

###XY_full and summary_set
`XY_full` is created by column binding `subject_full`, `Y_full` and `X_full`. This creates a single dataset from the test and train data, with descriptive feature and activity labels.

Finally, `summary_set` is generated using `ddply` to aggregate each feature via the mean of that column, grouping by `Subject` and `Activity`

##Data
###From the UCI HAR Dataset README.txt

Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

