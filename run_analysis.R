library(plyr)
library(dplyr)
library(reshape2)
train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, nrow =7352)
test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, nrow =2947)
comb <- rbind(train, test) #combines training and test
#identify mean and std columns
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, nrow =561)
mean.logical <- grepl("mean()", features[,2], fixed =TRUE)
std.logical <- grepl("std()", features[,2], fixed =TRUE)
#subset data for mean and std columns
ext <- comb[,mean.logical | std.logical]
#get activity number labels and combine train and test
act.train <- read.table("./UCI HAR Dataset/train/y_train.txt")
act.test <- read.table("./UCI HAR Dataset/test/y_test.txt")
acts <- rbind(act.train, act.test)
#replace activity codes with descriptive names, add to table
act.names <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
Activity <- act.names[acts[,1]]
data <- cbind(Activity, ext)
#make variable names descriptive using list of features
feature.labels <- as.vector(features[,2][mean.logical | std.logical])
colnames(data) <- c("Activity", feature.labels)
#get subject number labels, combine train and test, add to data
sub.train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
sub.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subs <- rbind(sub.train, sub.test)
data <- cbind(subs, data)
#melt, recast data to display mean variable value by subject and activity
data <- rename(data, Subject = V1)
datamelt <- melt(data, id=c("Activity", "Subject"))
tidywide <- dcast(datamelt, Subject + Activity ~ variable, mean)
write.table(tidywide, "./tidywide.txt", row.names=FALSE)
#tidytall <- melt(tidywide, id=c("Subject", "Activity"))
#tidytall <- rename(tidytall, Measurement = variable, Mean = value)
#write.table(tidytall, "./tidytall.txt", row.names=FALSE)