run.analysis.R can be used to create a tidy data set of means and standard deviations out of the data found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Place the data in the working directory, run "run.analysis.R", and a tidy data table will be written to your working directory as "tidy.txt".
NOTE: The table may be two wide to be read cleanly by a standard text-rendering window. It should be read into R for review.
The data table can be read into r with the following code:
tidy <- read.table("./tidy.txt")
See CodeBook.md for a description of the data set and variables.

The code operates as follows:
-installs necessary packages (plyr, dplyr, and reshapes2)
-reads the training and test data files
-merges the training and test data tables
-reads the features file
-identifies features measuring mean and standard deviation (by their respective tags "mean()" and "std()")
-creates table of only the mean and standard deviation feature measurements
-replaces the activity code numbers found in y_train.txt and y_test.txt with their descriptive activity names
-gets subject number labels from subject_train.txt and subject_test.txt, combines them
-labels table rows by activity and subject
-melts table using activity and subject as id variables
-recasts data into wide form