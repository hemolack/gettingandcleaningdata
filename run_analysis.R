# Create directory if it doesn't already exist
if(!file.exists("project_data")) {
  dir.create("project_data")
}

# Download the data set
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'project_data/dataset.zip')

# Uncompress data set
unzip('project_data/dataset.zip', overwrite = TRUE)

# Read in test data
testX <- read.table('UCI HAR Dataset/test/X_test.txt')

# Read in training data
trainX <- read.table('UCI HAR Dataset/train/X_train.txt')

# Add test / train indicator to both data sets
testX$test <- TRUE
trainX$test <- FALSE

# Read in the activity labels
activity_labels <- read.csv('UCI HAR Dataset/activity_labels.txt', header=FALSE, sep = " ")

# Bind the activities to the data frame
test_activity_number <- scan('UCI HAR Dataset/test/y_test.txt')
activity = factor(test_activity_number, labels=activity_labels$V2)
testX <- cbind(testX, activity)
  #testX <- cbind(test_activity, testX)
train_activity_number <- scan('UCI HAR Dataset/train/y_train.txt')
activity = factor(train_activity_number, labels=activity_labels$V2)
trainX <- cbind(trainX, activity)
  #trainX <- cbind(train_activity, trainX)

# Merge data sets into one
combined <- rbind(testX, trainX)

# Read feature names from file
features <- read.table('UCI HAR Dataset/features.txt')

# Add a new feature label for test column
features <- rbind(features, data.frame(V1 = nrow(features) + 1, V2 = "Test"))
features <- rbind(features, data.frame(V1 = nrow(features) + 1, V2 = "Activity"))

# Set feature names for combined data set
colnames(combined) <- features[, 2]

# Subset the date to only columns containing the strings "mean" and "std"
tidy_set <- combined[, features[grep('.*mean.*|.*std.*', features$V2), 2]]

# Add in the Test flag and Activity label
tidy_set$Test <- combined[, "Test"]
tidy_set$Activity <- combined[, "Activity"]

# Get the mean of each column as grouped by Test and Activity
  # Subset out the numeric data
data <- subset(tidy_set, select = (1:79))
  # Subset out the factors
factors <- subset(tidy_set, select = (80:81))
  # Use the aggregate function to get the mean for each
agg <- aggregate(data, factors, mean)

# Finally, write out the aggregated data set
write.table(agg, row.name=FALSE, file='aggregated_data.txt')