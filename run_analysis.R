library(data.table)

    #   1.Merges the training and the test sets to create one data set.
# read train data sets and combine

subjectTest <- fread("./UCI HAR Dataset/test/subject_test.txt",col.names = "subject")
xTest <- fread("./UCI HAR Dataset/test/X_test.txt")
yTest <- fread("./UCI HAR Dataset/test/y_test.txt", col.names = "activity")
test <- cbind(subjectTest, yTest, xTest)

# read test data sets and combine
subjectTrain <- fread("./UCI HAR Dataset/train/subject_train.txt",col.names = "subject")
xTrain <- fread("./UCI HAR Dataset/train/X_train.txt")
yTrain <- fread("./UCI HAR Dataset/train/y_train.txt", col.names = "activity")
train <- cbind(subjectTrain, yTrain, xTrain)

# combine train and test data sets and set as data.table format
mergedSet <- as.data.table(rbind(train,test))

    #   2.Extracts only the measurements on the mean and standard deviation for each measurement.

mergedSet <- mergedSet[,c(1:8,43:48,83:88,123:128,163:168,203,204,216,217,229,230,242,243,255, 256,
    268:273, 347:352, 426:431,505,506,518,519,531,532,544,545)]

    #   3.Uses descriptive activity names to name the activities in the data set

mergedSet$activity <- as.character(mergedSet$activity)
mergedSet$activity <- sub("1","walking",mergedSet$activity); mergedSet$activity <- sub("2","walking upstairs",mergedSet$activity)
mergedSet$activity <- sub("3","walking downstairs",mergedSet$activity); mergedSet$activity <- sub("4","sitting",mergedSet$activity)
mergedSet$activity <- sub("5","standing",mergedSet$activity); mergedSet$activity <- sub("6","laying",mergedSet$activity)

    #   4.Appropriately labels the data set with descriptive variable names.

names(mergedSet)[3] <- "timeBodyAccX_mean"
names(mergedSet)[4] <- "timeBodyAccY_mean"
names(mergedSet)[5] <- "timeBodyAccZ_mean"
names(mergedSet)[6] <- "timeBodyAccX_stddev"
names(mergedSet)[7] <- "timeBodyAccY_stddev"
names(mergedSet)[8] <- "timeBodyAccZ_stddev"
names(mergedSet)[9] <- "timeGravityAccX_mean"
names(mergedSet)[10] <- "timeGravityAccY_mean"
names(mergedSet)[11] <- "timeGravityAccZ_mean"
names(mergedSet)[12] <- "timeGravityAccX_stddev"
names(mergedSet)[13] <- "timeGravityAccY_stddev"
names(mergedSet)[14] <- "timeGravityAccZ_stddev"
names(mergedSet)[15] <- "timeBodyAccJerkX_mean"
names(mergedSet)[16] <- "timeBodyAccJerkY_mean"
names(mergedSet)[17] <- "timeBodyAccJerkZ_mean"
names(mergedSet)[18] <- "timeBodyAccJerkX_stddev"
names(mergedSet)[19] <- "timeBodyAccJerkY_stddev"
names(mergedSet)[20] <- "timeBodyAccJerkZ_stddev"
names(mergedSet)[21] <- "timeBodyGyroX_mean"
names(mergedSet)[22] <- "timeBodyGyroY_mean"
names(mergedSet)[23] <- "timeBodyGyroZ_mean"
names(mergedSet)[24] <- "timeBodyGyroX_stddev"
names(mergedSet)[25] <- "timeBodyGyroY_stddev"
names(mergedSet)[26] <- "timeBodyGyroZ_stddev"
names(mergedSet)[27] <- "timeBodyGyroJerkX_mean"
names(mergedSet)[28] <- "timeBodyGyroJerkY_mean"
names(mergedSet)[29] <- "timeBodyGyroJerkZ_mean"
names(mergedSet)[30] <- "timeBodyGyroJerkX_stddev"
names(mergedSet)[31] <- "timeBodyGyroJerkY_stddev"
names(mergedSet)[32] <- "timeBodyGyroJerkZ_stddev"
names(mergedSet)[33] <- "timeBodyAccMag_mean"
names(mergedSet)[34] <- "timeBodyAccMag_stddev"
names(mergedSet)[35] <- "timeGravityAccMag_mean"
names(mergedSet)[36] <- "timeGravityAccMag_stddev"
names(mergedSet)[37] <- "timeBodyAccJerkMag_mean"
names(mergedSet)[38] <- "timeBodyAccJerkMag_stddev"
names(mergedSet)[39] <- "timeBodyGyroMag_mean"
names(mergedSet)[40] <- "timeBodyGyroMag_stddev"
names(mergedSet)[41] <- "timeBodyGyroJerkMag_mean"
names(mergedSet)[42] <- "timeBodyGyroJerkMag_stddev"
names(mergedSet)[43] <- "frequencyBodyAccX_mean"
names(mergedSet)[44] <- "frequencyBodyAccY_mean"
names(mergedSet)[45] <- "frequencyBodyAccZ_mean"
names(mergedSet)[46] <- "frequencyBodyAccX_stddev"
names(mergedSet)[47] <- "frequencyBodyAccY_stddev"
names(mergedSet)[48] <- "frequencyBodyAccZ_stddev"
names(mergedSet)[49] <- "frequencyBodyAccJerkX_mean"
names(mergedSet)[50] <- "frequencyBodyAccJerkY_mean"
names(mergedSet)[51] <- "frequencyBodyAccJerkZ_mean"
names(mergedSet)[52] <- "frequencyBodyAccJerkX_stddev"
names(mergedSet)[53] <- "frequencyBodyAccJerkY_stddev"
names(mergedSet)[54] <- "frequencyBodyAccJerkZ_stddev"
names(mergedSet)[55] <- "frequencyBodyGyroX_mean"
names(mergedSet)[56] <- "frequencyBodyGyroY_mean"
names(mergedSet)[57] <- "frequencyBodyGyroZ_mean"
names(mergedSet)[58] <- "frequencyBodyGyroX_stddev"
names(mergedSet)[59] <- "frequencyBodyGyroY_stddev"
names(mergedSet)[60] <- "frequencyBodyGyroZ_stddev"
names(mergedSet)[61] <- "frequencyBodyAccMag_mean"
names(mergedSet)[62] <- "frequencyBodyAccMag_stddev"
names(mergedSet)[63] <- "frequencyBodyBodyAccJerkMag_mean"
names(mergedSet)[64] <- "frequencyBodyBodyAccJerkMag_stddev"
names(mergedSet)[65] <- "frequencyBodyGyroMag_mean"
names(mergedSet)[66] <- "frequencyBodyGyroMag_stddev"
names(mergedSet)[67] <- "frequencyBodyBodyGyroJerkMag_mean"
names(mergedSet)[68] <- "frequencyBodyBodyGyroJerkMag_stddev"

    #   5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
    #   for each activity and each subject.
    
mergedSet <- as.data.table(melt(mergedSet, id = c("subject","activity"), measure.vars = c(3:68)))
summarized_data <- mergedSet[, .(Average=mean(value)), by=.(subject,activity,variable)]
write.table(summarized_data,"summarized.txt", row.names=FALSE,sep = ",")