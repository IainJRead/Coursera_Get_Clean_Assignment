# Coursera_Get_Clean_Assignment
Repo for week 4 assignment of getting and cleaning data

# Overview
This repo contains a single R script, `run_analysis.R` which imports six datasets from the `UCI HAR Dataset` folder:
- `train/X_train.txt`
- `train/Y_train.txt`
- `train/subject_train.txt`
- `test/X_test.txt`
- `test/Y_test.txt`
- `test/subject_test.txt`

These six text files are imported as tables via `read.table()` and merged into a single data set, `XY_full`.

`XY_full` is then summarised by `Subject` and `Activity` to produce the `summary_set` table.