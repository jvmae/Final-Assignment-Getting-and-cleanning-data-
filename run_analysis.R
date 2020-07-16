filename <- "FinalAssg.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(URL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
#1. Merges the training and the test sets to create one data set.
features <- read.table("UCI HAR Dataset/features.txt")
features<-select(features, "n"= V1,"functions"= V2)

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities<- select(activities, "code"= V1, "activity"= V2)

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_test<-select(subject_test, "subject"= V1)

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)

y_test <- read.table("UCI HAR Dataset/test/y_test.txt") 
y_test<- select(y_test, "code"= V1)

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt") 
subject_train<- select(subject_train, "subject"= V1 )

x_train <- read.table("UCI HAR Dataset/train/X_train.txt",  col.names = features$functions)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt") 
y_train <-select(y_train, "code"= V1)

#1. Merges the training and the test sets to create one data set
xData<- rbind(x_train, x_test)
yData <- rbind(y_train, y_test)
Subject_data <- rbind(subject_train, subject_test)
Merged_data <- cbind(Subject_data, yData, xData)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
TidyData <-select(Merged_data, subject, code, contains("mean"), contains("std"))

#3. Uses descriptive activity names to name the activities in the data set
TidyData$code <- activities[TidyData$code, 2]
names(TidyData)[2] = "activity"

#4. Appropriately labels the data set with descriptive variables name
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))

#5. From the data in step 4, create another one, avg of each variable for each var.
TidyData2 <-group_by(TidyData, subject, activity) 
TidyData2<-summarise_all(TidyData2, funs(mean))
write.table(TidyData2, "TidyData2.txt", row.name=FALSE)
str(TidyData2)