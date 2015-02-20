# Code Book

## Data source

The data has been downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data source zip file contains a README.txt file with information about the experiment and the way data was collected. 

## Variables

All the column names are described in README.txt data source zip file, except for the following columns that were added:

* subjectnumber: the string that corresponds to the subject of the experiment
* activity: a string that represent the activity of the subject while collecting data points

Because the code did not use hardcoding for the column names or positions, these are the rules applied by R code to get clean column names: it removes parentheses and uses lowercase on the original names.

Ex: tBodyAcc-mean()-X` becomes tbodyacc-mean-x`.

# Output

* tidy.txt: (this has currently been commented out) a space-delimited value file that contains mean and standard deviation for each measurement from the train and test data
* average.txt: a space-delimited value file that contains a tidy data set with the average of each variable for each activity and each subject

To load those files using R, use the following commands:

```
read.table('tidy.txt', header = T)
read.table('average.txt', header = T)
```
