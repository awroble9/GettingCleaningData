# Introduction

This repository contains R scripts to merge and clean data for the JHU Getting and Cleaning Data Project.

# Instructions

## Steps

1. Download the data source zip file
4. Unzip the source zip file in your working directory
5. Run run_analysis.R

# Output

run_analysis.R generates 2 files:
* tidy.txt: (this has currently been commented out) a space-delimited value file that contains mean and standard deviation for each measurement from the train and test data
* average.txt: a space-delimited value file that contains a tidy data set with the average of each variable for each activity and each subject

To read the files, use:

```
read.table('tidy.txt', header = T)
read.table('average.txt', header = T)
```