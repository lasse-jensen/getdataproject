library(dplyr)

## Create data frames from imported data

##reading training data into three r data frames
training_X <- read.table('UCI HAR Dataset/train/X_train.txt', header=FALSE, fill=TRUE)
training_Y <- read.table('UCI HAR Dataset/train/y_train.txt', header=FALSE, fill=TRUE)
training_S <- read.table('UCI HAR Dataset/train/subject_train.txt', header=FALSE, fill=TRUE)

##reading testing data into three r data frames
testing_X <- read.table('UCI HAR Dataset/test/X_test.txt', header=FALSE, fill=TRUE)
testing_Y <- read.table('UCI HAR Dataset/test/y_test.txt', header=FALSE, fill=TRUE)
testing_S <- read.table('UCI HAR Dataset/test/subject_test.txt', header=FALSE, fill=TRUE)

##using cbind to bind the three dataframes in one big datafra fro testing and training each
trainingDF <- cbind(training_S, training_Y, training_X)
testingDF <- cbind(testing_S, testing_Y, testing_X)

##changing variable names to avoid three columns called V1 in each dataframe
colnames(trainingDF)[1] <- "ID"
colnames(trainingDF)[2] <- "Activity"
colnames(testingDF)[1] <- "ID"
colnames(testingDF)[2] <- "Activity"

##merging the training and the testing data frames to create one big data set
mergedDF <- merge(trainingDF, testingDF, all = TRUE)

## Extract only the measurements on the mean and standard deviation 
## for each measurement

##make sorted list of features containing mean() or std()
features <- read.table('UCI HAR Dataset/features.txt', header=FALSE, fill=TRUE)
mean_feat <- filter(features, grepl('mean()', V2, fixed = TRUE))
std_feat <- filter(features, grepl('std()', V2, fixed = TRUE))
meanstd_feat <- rbind(select(mean_feat, V1), select(std_feat, V1))
##to keep ID and Activity columns in beginning of data frame we manipulate like this
meanstd_list <- sort(c(1, 2, meanstd_feat$V1 + 2))

##select only the mean and std columns from the mergedDF
meanstdDF <- select(mergedDF, meanstd_list)

##add descriptive names to the activity column
meanstdDF$Activity[meanstdDF$Activity==1] <- "WALKING"
meanstdDF$Activity[meanstdDF$Activity==2] <- "WALKING_UPSTAIRS"
meanstdDF$Activity[meanstdDF$Activity==3] <- "WALKING_DOWNSTAIRS"
meanstdDF$Activity[meanstdDF$Activity==4] <- "SITTING"
meanstdDF$Activity[meanstdDF$Activity==5] <- "STANDING"
meanstdDF$Activity[meanstdDF$Activity==6] <- "LAYING"

##label the data set with descriptive variable names
var_names <- merge(mean_feat, std_feat, all = TRUE)
label_names <- c("ID", "Activity", as.vector(var_names$V2))
colnames(meanstdDF)  <- label_names

## Create a second, independent tidy data set with the average of 
## each variable for each activity and each subject
tidy_dataset <- meanstdDF %>% 
  group_by(ID, Activity) %>% 
  summarise_each(funs(mean))
