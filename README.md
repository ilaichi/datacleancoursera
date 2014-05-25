Getting and Cleaning Data Course Project
========================================

The submissions for this project include: 

1. A tidy data set
 * contains records from both training and testing data sets
 * only the columns containg mean and std for measurements are used
 * activity names are descriptive
 * descriptive row names are provided
2. A second tidy data set
 * contains records from both training and testing data sets
 * all the columns are used
 * all measurements are averaged, grouped by subject ID and activity
 * activity names are descriptive
 * descriptive row names are provided
3. A link to a Github repository containing the script that creates the tidy data sets
4. This README.md. 
5. A code book that describes the variables, the data, and any transformations or work that was performed to clean up the data called CodeBook.md. 

## Script
There is only one script - run_analysis.R

It expects the Samsung data zip file named "getdata-projectfiles-UCI HAR Dataset.zip" to be present in the working directory.

When the script is run (sourced), it extract the zip file contents to a folder named "ex"" in the working directory. If the "ex" directory is already present, the script will stop with a warning. Otherwise, it extracts the contents and proceeds.

Next it performs the processing for the first tidy data set. It loads the selected columns (only containing mean() or std()) for the test data set. It also loads the corresponding subject and activity data and joins them to create a data frame. It similarly loads the training set. Activity IDs are converted to factors using activity labels. Then it performs the union of the two data frames and orders them by subject ID and activity. Finally, it labels rows using row number, subject ID, and activity. This data is saved as CSV in a file name tidydata1.txt. It overwrites any file with the same name in the working directory.

Next it performs the processing for the second tidy data set. It loads all the columns for the test data set. It also loads the corresponding subject and activity data and joins them to create a data frame. It similarly loads the training set. Activity IDs are converted to factors using activity labels. Then it performs the union of the two data frames. At this point, the average is computed for all the columns grouped by subject ID and activity. The resulting rows are ordered by subject ID and activity. Finally, it labels rows using row number, subject ID, and activity. This data is saved as CSV in a file name tidydata2.txt. It overwrites any file with the same name in the working directory.

At the end, it removes the "ex" folder that was created at the start for holding the extracted data.
