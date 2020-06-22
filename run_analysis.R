library(data.table)

# read train data sets and combine
train_subject <- fread("./test/subject_test.txt",col.names = "subject")
train_measure <- fread("./test/X_test.txt")
train_activity <- fread("./test/y_test.txt", col.names = "activity")
train <- cbind(train_subject, train_activity, train_measure)

# read test data sets and combine
test_subject <- fread("./train/subject_train.txt",col.names = "subject")
test_measure <- fread("./train/X_train.txt")
test_activity <- fread("./train/y_train.txt", col.names = "activity")
test <- cbind(test_subject, test_activity, test_measure)

# combine train and test data sets
full_set <- rbind(train,test)

# give activity field descriptive names
full_set$activity <- as.character(full_set$activity)
full_set$activity <- sub("1","walking",full_set$activity); full_set$activity <- sub("2","walking upstairs",full_set$activity)
full_set$activity <- sub("3","walking downstairs",full_set$activity); full_set$activity <- sub("4","sitting",full_set$activity)
full_set$activity <- sub("5","standing",full_set$activity); full_set$activity <- sub("6","laying",full_set$activity)

# ready for next step