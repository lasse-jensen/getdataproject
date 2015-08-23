# ReadMe
The data originates from the Human Activity Recognition Using Smartphones Data Set from the UC Irvine Machine Learning Repository.

The data set is described as a “Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.” (Quoted from link below).

More information about the original dataset on the project website:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis.R script takes the data from the repository and tidies and transforms it through the following steps:

1.	Merges the training and the test sets to create one data set.

2.	Extracts only the measurements on the mean and standard deviation for each measurement. 

3.	Uses descriptive activity names to name the activities in the data set

4.	Appropriately labels the data set with descriptive variable names. 

5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#tidy_dataset.txt
The tidy_dataset.txt contains the average for each activity and each subject, so that each of the 30 subjects will have an average for each of the 6 activities: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS and WALKING_UPSTAIRS.

To view the tidy_dataset.txt file in R you can run the following commands: 

data <- read.table(file_path, header = FALSE) 

View(data)

Please refer to the code book for variable names.

