#---------final project -------------------------------------------------------------#

library(dplyr)
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "C:/Users/Suba/Documents/data/UCI.zip")
data <- unzip("C:/Users/Suba/Documents/data/UCI.zip", list = TRUE)
label <- read.table("UCI HAR Dataset/activity_labels.txt", header = F)
features <- read.table("UCI HAR Dataset/features.txt", header = F)
#--------------- reading train variables--------------------------------------------------------------# 
bodytrain_acc_x <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", header = F)
bodytrain_acc_y <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", header = F)
bodytrain_acc_z <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", header = F)
totaltrain_acc_x <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", header = F)
totaltrain_acc_y <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", header = F)
totaltrain_acc_z <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", header = F)
bodytrain_gyro_x <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", header = F)
bodytrain_gyro_y <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", header = F)
bodytrain_gyro_z <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", header = F)
train_x <- read.table("UCI HAR Dataset/train/X_train.txt", header = F)
train_y <- read.table("UCI HAR Dataset/train/y_train.txt", header = F)
train_y <- rename(train_y, Activities = "V1")
names(train_x) <- features$V2 #changing column names in train data using features

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = F)

#-----------------------reading test variables ---------------------------------------------------------#
bodytest_acc_x <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", header = F)
bodytest_acc_y <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", header = F)
bodytest_acc_z <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", header = F)
bodytest_gyro_x <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", header = F)
bodytest_gyro_y <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", header = F)
bodytest_gyro_z <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", header = F)
totaltest_acc_x <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", header = F)
totaltest_acc_y <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", header = F)
totaltest_acc_z <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", header = F)
test_x <- read.table("UCI HAR Dataset/test/X_test.txt", header = F)
test_y <- read.table("UCI HAR Dataset/test/y_test.txt", header = F)
test_y <- rename(test_y, Activities = "V1")
names(test_x) <- features$V2 # changing column names in test data using features

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = F)
#-----------------------------------------------------------------------------------------------#

subject_train <- rename(subject_train, Subjects = "V1") # renaming the "subject column" in the train dataset
subject_test <- rename(subject_test, Subjects = "V1") # renaming the "subject column" in the test dataset
#Step 1:  Combining test_y, test_x, subject_test
test_all <- cbind(test_x, subject_test, test_y)
train_all <- cbind(train_x, subject_train, train_y)
# Merging the train and test datasets
test_train <- rbind(test_all, train_all)
TestTrain$Activities <- as.factor(TestTrain$Activities) # labelling the activities
TestTrain$Activities <-factor(test_train$Activities, levels = c(1:6), labels = label$V2)

#Step2: Extracting only mean and std 
test_train <- test_train[ , !duplicated(colnames(test_train))]
TestTrain <- select(test_train, matches('mean|std'))
Subjects <- select(test_train, "Subjects")
Activities <- select(test_train, "Activities")
TestTrain <- cbind(Subjects, Activities, TestTrain)

# Step3 : Descriptive activity names for names of activities and 
names(TestTrain) <- gsub("-", "", names(TestTrain))
names(TestTrain) <- gsub("( )", "", names(TestTrain))

# tidydata
tidydata <- group_by(TestTrain, Activities, Subjects)
summarised_tidydata <- summarise_all(tidydata, mean)
summarised_tidydata$Activities <- factor(summarised_tidydata$Activities, levels = c(1:6), labels = label$V2)







 

