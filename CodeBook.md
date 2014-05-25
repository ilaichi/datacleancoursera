Code Book for Getting and Cleaning Data Course Project
======================================================

## Data
The data under consideration was collected from the accelerometers from the Samsung Galaxy S smartphone worn by variious subjects performing one of six activitis at a time. The data is describe here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Variables
The variables in the data are described in two files - features_info.txt and features.txt, which are present in the data zip file. The file - features.txt lists all the column names in order and features_info.txt provides an overview of how the various columns were derived. 

Essentially, the features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. These raw signals were processed to derive all the variables in the data set.

## Analysis and Cleanup 
A script called r_analysis.R was created to produce two tidy data sets from the provided data set. The working of the script is described in the file README.md. The script itself is well-documented and easy to follow.

Some analysis was performed before writing the script to identify which columns contain mean and std variables. The following columns were selected for creating the first tidy data set:
 * 1 tBodyAcc-mean()-X
 * 2 tBodyAcc-mean()-Y
 * 3 tBodyAcc-mean()-Z
 * 4 tBodyAcc-std()-X
 * 5 tBodyAcc-std()-Y
 * 6 tBodyAcc-std()-Z
 * 41 tGravityAcc-mean()-X
 * 42 tGravityAcc-mean()-Y
 * 43 tGravityAcc-mean()-Z
 * 44 tGravityAcc-std()-X
 * 45 tGravityAcc-std()-Y
 * 46 tGravityAcc-std()-Z
 * 81 tBodyAccJerk-mean()-X
 * 82 tBodyAccJerk-mean()-Y
 * 83 tBodyAccJerk-mean()-Z
 * 84 tBodyAccJerk-std()-X
 * 85 tBodyAccJerk-std()-Y
 * 86 tBodyAccJerk-std()-Z
 * 121 tBodyGyro-mean()-X
 * 122 tBodyGyro-mean()-Y
 * 123 tBodyGyro-mean()-Z
 * 124 tBodyGyro-std()-X
 * 125 tBodyGyro-std()-Y
 * 126 tBodyGyro-std()-Z
 * 161 tBodyGyroJerk-mean()-X
 * 162 tBodyGyroJerk-mean()-Y
 * 163 tBodyGyroJerk-mean()-Z
 * 164 tBodyGyroJerk-std()-X
 * 165 tBodyGyroJerk-std()-Y
 * 166 tBodyGyroJerk-std()-Z
 * 201 tBodyAccMag-mean()
 * 202 tBodyAccMag-std()
 * 214 tGravityAccMag-mean()
 * 215 tGravityAccMag-std()
 * 227 tBodyAccJerkMag-mean()
 * 228 tBodyAccJerkMag-std()
 * 240 tBodyGyroMag-mean()
 * 241 tBodyGyroMag-std()
 * 253 tBodyGyroJerkMag-mean()
 * 254 tBodyGyroJerkMag-std()
 * 266 fBodyAcc-mean()-X
 * 267 fBodyAcc-mean()-Y
 * 268 fBodyAcc-mean()-Z
 * 269 fBodyAcc-std()-X
 * 270 fBodyAcc-std()-Y
 * 271 fBodyAcc-std()-Z
 * 345 fBodyAccJerk-mean()-X
 * 346 fBodyAccJerk-mean()-Y
 * 347 fBodyAccJerk-mean()-Z
 * 348 fBodyAccJerk-std()-X
 * 349 fBodyAccJerk-std()-Y
 * 350 fBodyAccJerk-std()-Z
 * 424 fBodyGyro-mean()-X
 * 425 fBodyGyro-mean()-Y
 * 426 fBodyGyro-mean()-Z
 * 427 fBodyGyro-std()-X
 * 428 fBodyGyro-std()-Y
 * 429 fBodyGyro-std()-Z
 * 503 fBodyAccMag-mean()
 * 504 fBodyAccMag-std()
 * 516 fBodyBodyAccJerkMag-mean()
 * 517 fBodyBodyAccJerkMag-std()
 * 529 fBodyBodyGyroMag-mean()
 * 530 fBodyBodyGyroMag-std()
 * 542 fBodyBodyGyroJerkMag-mean()
 * 543 fBodyBodyGyroJerkMag-std()

All the columns are used for creating the second data set.