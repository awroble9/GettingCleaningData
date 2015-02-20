# install.packages("plyr")
library(plyr)

# this folder is created when unzipping the data source
  dataFolder = "UCI HAR Dataset/"

  getFilePath <- function(filepath) {
      paste(dataFolder, filepath, sep="")
}

# 0. Bring the data in and combine them in "like" tables
#   a. Data sets X, Y, Subject
#   b. Variables Train and Test

  XTrain <- read.table(getFilePath("train/X_train.txt"))
  XTest <- read.table(getFilePath("test/X_test.txt"))
  XData <- rbind(XTrain, XTest)

  YTrain <- read.table(getFilePath("train/y_train.txt"))
  YTest <- read.table(getFilePath("test/y_test.txt"))
  YData <- rbind(YTrain, YTest)

  subjectTrain <- read.table(getFilePath("train/subject_train.txt"))
  subjectTest <- read.table(getFilePath("test/subject_test.txt"))
  SubjectData <- rbind(subjectTrain, subjectTest)

# Save space and remove old variables
  rm(XTrain, XTest, YTrain, YTest, subjectTrain, subjectTest)

# 2. Extracts only the mean and standard deviation for each measurement.

  features <- read.table(getFilePath("features.txt"))
  keptMesurePositions <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
  XData <- XData[, keptMesurePositions]

# Set and clean column names
  names(XData) <- features[keptMesurePositions, 2]

# Remove unwanted characters from column names
  names(XData) <- gsub("\\(|\\)", "", names(XData))
  names(XData) <- tolower(names(XData))

# Save space and remove old variables
  rm(keptMesurePositions, features)

# 3 & 4. Use descriptive activity names to name the activities in the data set

  activityLabels <- read.table(getFilePath("activity_labels.txt"))
# Tidy the names
  activityLabels[, 2] = gsub("_", "", 
                             tolower(as.character(activityLabels[, 2])))
  YData[,1] = activityLabels[YData[,1], 2]
# Name the column
  names(YData) <- "activity"
# Label SubjectData
  names(SubjectData) <- "subjectnumber"

# 1. Merge data sets
#   a. Erase double hash if you wish to save huge file

  merged <- cbind(SubjectData, YData, XData)
##  write.table(merged, "tidy.txt")

# 5. Create and save a 2nd data set with the average of each variable for each 
# activity and each subject.
  excludedColumns = which(names(merged) %in% c("subjectnumber", "activity"))
  result <- ddply(merged, .(subjectnumber, activity), 
                  .fun=function(x){ colMeans(x[,-excludedColumns]) })

write.table(result, "average.txt", row.names = FALSE)