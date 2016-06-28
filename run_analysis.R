## Getting and Cleaning Data Course Project

# Import libraries
library(dplyr)


## This script does the following:
## 0.  Downloads raw data
## 1.  Merges the training and the test sets to create one data set.
## 2.  Extracts only the measurements on the mean and the standard deviation
##     for each measurement.
## 3.  Uses descriptive activity names to name the activites in the data set.
## 4.  Appropriately labels the data set with descriptive variable names.
## 5.  From the data in step 4, create a second, independent tidy data set
##     with the average of each variable for each activity and each subject.


run_analysis <- function() {
    fname <- "UCI_HAR_Dataset.zip"
    if (!file.exists(fname)) {
        download.file(
            "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
            destfile = fname
        )
        unzip(fname)
    }
    
    activity_map <- read.fwf("UCI HAR Dataset/activity_labels.txt", c(2, 18))
    names(activity_map) <- c("id", "activity")

    # Read the names of the data columns.
    cnames <- read.table("UCI HAR Dataset/features.txt", sep=" ", 
                         stringsAsFactors=FALSE)
    cnames <- make.names(cnames$V2, unique=TRUE)
    
    ###### TODO!!!!! Remove the limits!!!
    # Load the training data. The training data is in 3 files:
    ##  X_train.txt = data in a fixed width format with 561 columns.
    ##  y_train.txt = the activity label
    ##  subject_train.txt = the subject id who performed the activity.
    # Convert the activity to a descriptive value and create a combined
    # recordset.
    training <- read.fwf("UCI HAR Dataset/train/X_train.txt", rep(16, 561), n=700)
    names(training) <- cnames
    activity <- read.table("UCI HAR Dataset/train/y_train.txt", nrows=700)
    names(activity) <- c("id")
    subject <- read.table("UCI HAR Dataset/train/subject_train.txt", nrows=700)
    names(subject) <- c("subject")
    activity <- activity %>% left_join(activity_map) %>% select(activity)
    training <- cbind(subject, activity, training)
    
    test <- read.fwf("UCI HAR Dataset/test/X_test.txt", rep(16, 561), n=300)
    names(test) <- cnames
    activity <- read.table("UCI HAR Dataset/test/y_test.txt", nrows=300)
    names(activity) <- c("id")
    subject <- read.table("UCI HAR Dataset/test/subject_test.txt", nrows=300)
    names(subject) <- c("subject")
    activity <- activity %>% left_join(activity_map) %>% select(activity)
    test <- cbind(subject, activity, test)
    
    # Merge the two datasets.
    data <- rbind(training, test)
    
    
    # Extract the mean and standard deviation for each measurement. In order
    # to maintain the order of the columns, we exclude by pattern instead of
    # include by pattern.
    data <- tbl_df(data)
    data <- select(data,
                   -contains(".mad.."),
                   -contains(".max.."),
                   -contains(".min.."),
                   -contains(".sma.."),
                   -contains(".energy.."),
                   -contains(".iqr.."),
                   -contains(".entropy.."),
                   -contains(".arCoeff.."),
                   -contains(".correlation.."),
                   -contains(".maxInds"),
                   -contains(".meanFreq.."),
                   -contains(".skewness.."),
                   -contains(".kurtosis.."),
                   -contains("bandsEnergy.."),
                   -contains("angle")
    )
    
    # Enhance the column names to be more descriptive.
    new <- names(data)
    new <- sub("tBody", "timeBody", new)
    new <- sub("fBody", "frequencyBody", new)
    new <- sub("tGravity", "timeGravity", new)
    new <- sub("Acc", "Acceleration", new)
    new <- sub("BodyBody", "Body", new)
    new <- sub("\\.\\.\\.", "\\.", new)
    new <- sub("\\.\\.", "", new)
    names(data) <- new
    
    # Write the data to a file.
    write.csv(data, file="activitydata.csv", row.names=FALSE)
    
    data
}

summarize.activity <- function(data) {
    ## Create the summary statistics - the average of each
    ## column for each subject and each activity.
    
    sum_data <- 
        data %>%
        group_by(subject, activity) %>%
        summarize_each(c("mean"))

    # Write the data to a file.
    write.csv(sum_data, file="summarydata.csv", row.names=FALSE)
    
    sum_data
}


# Call both functions to generate the data.
data <- run_analysis()
sum_data <- summarize.activity(data)
