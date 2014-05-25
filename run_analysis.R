##############################################
## FUNCTIONS
##############################################
#
# loadData - loads testing or training data for the Samsung data set. 
#
# rootFolder - the path for the folder which contains the extracted Samsung data. 
#               This path ends in "UCI HAR Dataset"  
# dataSegment - testing or training portion, acceptable values are "test" and "train"
# colClassesFilter - column classes as acceptable for read.table. This selects
#                 which columns will be read
# colNames - names of columns, this should correspond to colClassesFilter
# actLabels - labels for activities - values correspond to 1:6
#
# returns - data frame created based on the arguments. It includes
#             SubjectId and Activity columns along with the measurement data.
#
loadData <- function(rootFolder, dataSegment, colClassesFilter, colNames, actLabels) {
  ssub <-read.csv(paste0(rootFolder, "/", dataSegment, "/subject_", dataSegment, ".txt"), header=FALSE)
  names(ssub) <- "SubjectId"
  sact <-read.csv(paste0(rootFolder, "/", dataSegment, "/y_", dataSegment, ".txt"), header=FALSE)
  names(sact) <- "ActivityId"
  
  sdata <- read.table(paste0(rootFolder, "/", dataSegment, "/X_", dataSegment, ".txt"), colClasses = colClassesFilter, header = FALSE)
  names(sdata) <- colNames
  
  sdata <- cbind(SubjectId = ssub$SubjectId, Activity = as.factor(sact$ActivityId), sdata)
  levels(sdata$Activity) <- actLabels
  
  sdata
}


##############################################
## PREPARE
##############################################

# Set path variables and extract the data zip
# The zip must be named "getdata-projectfiles-UCI HAR Dataset.zip"
# and must be present in the working directory
dataZipFileName <- "getdata-projectfiles-UCI HAR Dataset.zip"
extractFolder <- "ex"
dataFolder <- paste0(extractFolder, "/UCI HAR Dataset")

# check if the extract folder already exists
# this is to avoid overwriting a pre-existing folder
if (file.exists(extractFolder)) {
  stop(paste0("Please delete or rename the folder ", extractFolder ," in the working directory"))
}


# unzip data zip if it exists
if (file.exists(dataZipFileName)) {
  unzip(dataZipFileName, exdir=extractFolder)
  
} else {
  stop(paste0("Samsung data file (", dataZipFileName ,") missing in the working directory"))
}

# read activity labels
activityLabels <-read.table(paste0(dataFolder, "/activity_labels.txt"), header=FALSE)
names(activityLabels) <- c("ActivityId","Activity")


##############################################
## CREATE TIDY DATA SET 1
## All columns containing mean() or std()
## Union of training and testing data records
##############################################

# Identify columns for measurements pertaining to mean() and std()
# These columns were identified using the features.txt file as a preparation step
# for writing this script
stdMeanIndices <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)
stdMeanColLabels <- c("tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z","tBodyAcc-std()-X","tBodyAcc-std()-Y","tBodyAcc-std()-Z","tGravityAcc-mean()-X","tGravityAcc-mean()-Y","tGravityAcc-mean()-Z","tGravityAcc-std()-X","tGravityAcc-std()-Y","tGravityAcc-std()-Z","tBodyAccJerk-mean()-X","tBodyAccJerk-mean()-Y","tBodyAccJerk-mean()-Z","tBodyAccJerk-std()-X","tBodyAccJerk-std()-Y","tBodyAccJerk-std()-Z","tBodyGyro-mean()-X","tBodyGyro-mean()-Y","tBodyGyro-mean()-Z","tBodyGyro-std()-X","tBodyGyro-std()-Y","tBodyGyro-std()-Z","tBodyGyroJerk-mean()-X","tBodyGyroJerk-mean()-Y","tBodyGyroJerk-mean()-Z","tBodyGyroJerk-std()-X","tBodyGyroJerk-std()-Y","tBodyGyroJerk-std()-Z","tBodyAccMag-mean()","tBodyAccMag-std()","tGravityAccMag-mean()","tGravityAccMag-std()","tBodyAccJerkMag-mean()","tBodyAccJerkMag-std()","tBodyGyroMag-mean()","tBodyGyroMag-std()","tBodyGyroJerkMag-mean()","tBodyGyroJerkMag-std()","fBodyAcc-mean()-X","fBodyAcc-mean()-Y","fBodyAcc-mean()-Z","fBodyAcc-std()-X","fBodyAcc-std()-Y","fBodyAcc-std()-Z","fBodyAccJerk-mean()-X","fBodyAccJerk-mean()-Y","fBodyAccJerk-mean()-Z","fBodyAccJerk-std()-X","fBodyAccJerk-std()-Y","fBodyAccJerk-std()-Z","fBodyGyro-mean()-X","fBodyGyro-mean()-Y","fBodyGyro-mean()-Z","fBodyGyro-std()-X","fBodyGyro-std()-Y","fBodyGyro-std()-Z","fBodyAccMag-mean()","fBodyAccMag-std()","fBodyBodyAccJerkMag-mean()","fBodyBodyAccJerkMag-std()","fBodyBodyGyroMag-mean()","fBodyBodyGyroMag-std()","fBodyBodyGyroJerkMag-mean()","fBodyBodyGyroJerkMag-std()")

# create column classes list for selectively reading the std and mean columns
selColClasses <- rep("NULL", 561)
selColClasses[stdMeanIndices] <- "numeric"

# load testing data for the std/mean columns
testData <- loadData(dataFolder, "test", selColClasses, stdMeanColLabels, activityLabels$Activity)

# load training data for the std/mean columns
traindata <- loadData(dataFolder, "train", selColClasses, stdMeanColLabels, activityLabels$Activity)

# perform union of testing and training records
alldata <- rbind(testData, traindata)
# sort by subject, activity
alldata <- alldata[order(alldata$SubjectId,alldata$Activity),]
# create descriptive row names - unique ID + subject ID + activity
row.names(alldata) <- paste(seq_along(alldata$Activity),"-",alldata$SubjectId, "-", alldata$Activity)
# save tidy data set 1
write.csv(alldata, "tidydata1.txt")

##############################################
## CREATE TIDY DATA SET 2
## All columns 
## Union of training and testing data records
## Aggregated - mean by subject+activity
##############################################
# Need to load all columns to find averages for all of them
allColClasses <- rep("numeric", 561)
# descriptive column headings are in festures.txt
features <-read.table(paste0(dataFolder, "/features.txt"), header=FALSE, stringsAsFactors=FALSE)
# extract the column labels
allColLabels <- features[,2]

# load testing data for the all columns
testData <- loadData(dataFolder, "test", allColClasses, allColLabels, activityLabels$Activity)
# load training data for the all columns
traindata <- loadData(dataFolder, "train", allColClasses, allColLabels, activityLabels$Activity)

# perform union of testing and training records
alldata <- rbind(testData, traindata)
# sort by subject, activity
alldata <- alldata[order(alldata$SubjectId,alldata$Activity),]
# find averages grouped by subject ID and activity
avgdata <- aggregate(alldata[,3:563], alldata[,1:2], FUN=mean)
# create descriptive row names - unique ID + subject ID + activity
row.names(avgdata) <- paste(seq_along(avgdata$Activity),"-",avgdata$SubjectId, "-", avgdata$Activity)
# save tidy data set 2
write.csv(avgdata, "tidydata2.txt")


##############################################
## CLEAN UP THE EXTRACTED FOLDER
##############################################
# check if the extract folder exists
if (file.exists(extractFolder)) {
  unlink(extractFolder, recursive = TRUE)
}
