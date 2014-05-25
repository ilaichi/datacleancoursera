# dataSource - test or train
loadData <- function(rootFolder, dataSource, colClassesFilter, colNames, actLabels) {
  ssub <-read.csv(paste0(rootFolder, "/", dataSource, "/subject_", dataSource, ".txt"), header=FALSE)
  names(ssub) <- "SubjectId"
  sact <-read.csv(paste0(rootFolder, "/", dataSource, "/y_", dataSource, ".txt"), header=FALSE)
  names(sact) <- "ActivityId"
  
  sdata <- read.table(paste0(rootFolder, "/", dataSource, "/X_", dataSource, ".txt"), colClasses = colClassesFilter, header = FALSE)
  names(sdata) <- colNames
  
  sdata <- cbind(SubjectId = ssub$SubjectId, Activity = as.factor(sact$ActivityId), sdata)
  levels(sdata$Activity) <- actLabels
  
  sdata
}



zipFile <- "getdata-projectfiles-UCI HAR Dataset.zip"
extractFolder <- "ex"
dataFolder <- paste0(extractFolder, "/UCI HAR Dataset")
if (!file.exists(zipFile)) stop(paste0("Samsung data file (", zipFile ,") missing in the working directory"))
unzip(zipFile, exdir=extractFolder)


sactlabels <-read.table(paste0(dataFolder, "/activity_labels.txt"), header=FALSE)
names(sactlabels) <- c("ActivityId","Activity")

# specify the selected columns
stdMeanIndices <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)
filteredColLabels <- c("tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z","tBodyAcc-std()-X","tBodyAcc-std()-Y","tBodyAcc-std()-Z","tGravityAcc-mean()-X","tGravityAcc-mean()-Y","tGravityAcc-mean()-Z","tGravityAcc-std()-X","tGravityAcc-std()-Y","tGravityAcc-std()-Z","tBodyAccJerk-mean()-X","tBodyAccJerk-mean()-Y","tBodyAccJerk-mean()-Z","tBodyAccJerk-std()-X","tBodyAccJerk-std()-Y","tBodyAccJerk-std()-Z","tBodyGyro-mean()-X","tBodyGyro-mean()-Y","tBodyGyro-mean()-Z","tBodyGyro-std()-X","tBodyGyro-std()-Y","tBodyGyro-std()-Z","tBodyGyroJerk-mean()-X","tBodyGyroJerk-mean()-Y","tBodyGyroJerk-mean()-Z","tBodyGyroJerk-std()-X","tBodyGyroJerk-std()-Y","tBodyGyroJerk-std()-Z","tBodyAccMag-mean()","tBodyAccMag-std()","tGravityAccMag-mean()","tGravityAccMag-std()","tBodyAccJerkMag-mean()","tBodyAccJerkMag-std()","tBodyGyroMag-mean()","tBodyGyroMag-std()","tBodyGyroJerkMag-mean()","tBodyGyroJerkMag-std()","fBodyAcc-mean()-X","fBodyAcc-mean()-Y","fBodyAcc-mean()-Z","fBodyAcc-std()-X","fBodyAcc-std()-Y","fBodyAcc-std()-Z","fBodyAccJerk-mean()-X","fBodyAccJerk-mean()-Y","fBodyAccJerk-mean()-Z","fBodyAccJerk-std()-X","fBodyAccJerk-std()-Y","fBodyAccJerk-std()-Z","fBodyGyro-mean()-X","fBodyGyro-mean()-Y","fBodyGyro-mean()-Z","fBodyGyro-std()-X","fBodyGyro-std()-Y","fBodyGyro-std()-Z","fBodyAccMag-mean()","fBodyAccMag-std()","fBodyBodyAccJerkMag-mean()","fBodyBodyAccJerkMag-std()","fBodyBodyGyroMag-mean()","fBodyBodyGyroMag-std()","fBodyBodyGyroJerkMag-mean()","fBodyBodyGyroJerkMag-std()")

selColClasses <- rep("NULL", 561)
selColClasses[stdMeanIndices] <- "numeric"

testdata <- loadData(dataFolder, "test", selColClasses, filteredColLabels, sactlabels$Activity)
traindata <- loadData(dataFolder, "train", selColClasses, filteredColLabels, sactlabels$Activity)

alldata <- rbind(testdata, traindata)
alldata <- alldata[order(alldata$SubjectId,alldata$Activity),]
row.names(alldata) <- paste(seq_along(alldata$Activity),"-",alldata$SubjectId, "-", alldata$Activity)
write.csv(alldata, "tidydata1.csv")

# now create the second tidy data set 
# for this load all columns
allColClasses <- rep("numeric", 561)
features <-read.table(paste0(dataFolder, "/features.txt"), header=FALSE, stringsAsFactors=FALSE)
allColLabels <- features[,2]

testdata <- loadData(dataFolder, "test", allColClasses, allColLabels, sactlabels$Activity)
traindata <- loadData(dataFolder, "train", allColClasses, allColLabels, sactlabels$Activity)

alldata <- rbind(testdata, traindata)
alldata <- alldata[order(alldata$SubjectId,alldata$Activity),]
row.names(alldata) <- paste(seq_along(alldata$Activity),"-",alldata$SubjectId, "-", alldata$Activity)

avgdata <- aggregate(alldata[,3:563], alldata[,1:2], FUN=mean)
write.csv(avgdata, "tidydata2.csv")

