# Load library packages
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(dplyr)) 


# Check is the Samsung data set exists in "UCI HAR Dataset" directory or not, if not then download and extract from internet. If data exists move on to next set of commands

if (!dir.exists("UCI HAR Dataset")) 
  {
      cat("Downloading and extracting raw data set from internet ... " , "\n")
      fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileUrl , destfile="./getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",method="curl" ,quiet=TRUE)
      suppressMessages(unzip(zipfile="getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",overwrite=TRUE))
      file.remove("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
  }

# Set working directory to the data directory

setwd("UCI HAR Dataset/")
    cat("Reading and merging the data sets ...", "\n")


# Read and merge data sets in next set of commands. rbind is used because columns match in both files and we are just appending rows
xTest <- read.table("test/X_test.txt",sep="")
xTrain <- read.table("train/X_train.txt",sep="")
xFinal <- rbind(xTest,xTrain)

yTest <- read.table("test/Y_test.txt",sep="")
yTrain <- read.table("train/Y_train.txt",sep="")
yFinal <- rbind(yTest,yTrain)

subjectTest <- read.table("test/subject_test.txt",sep="")
subjectTrain <- read.table("train/subject_train.txt",sep="")
subjectFinal <- rbind(subjectTest,subjectTrain)

# Read activity labels and rename the column names
activityUse <- read.table("activity_labels.txt",stringsAsFactors=FALSE , sep="")
colnames(activityUse) <- c("ActivityID","Activity")

# Read column names for variables, we only need 2nd column
features <- read.table("features.txt", stringsAsFactors=FALSE , sep="")
featuresUse <- (features[,2])

# Apply column names to merged data
colnames(xFinal) <- featuresUse
colnames(yFinal) <- c("ActivityID")
colnames(subjectFinal) <- c("Subject")

# Join activity data with activity label to get more descriptive names

activityLabel <- join(yFinal,activityUse,by="ActivityID")

    cat("  Number of rows in merged data set: ",nrow(xFinal),"\n")
    cat("  Number of columns in merged data set: ",ncol(xFinal),"\n")
    cat("\n")
    cat("Selecting only the columns with mean and std in names. Tidying up the column names to make them more readable ...","\n")

# Reduce number of columns to only those with mean and std in the column heading
myDataSet <- xFinal[,grep("mean|std",featuresUse)]

# Use cbind to gather data from various sets
myLeanDataSet <- cbind(subjectFinal,Activity=activityLabel[,"Activity"],myDataSet)
  
# Cleanse the names of columns
names(myLeanDataSet) <- gsub("\\(|\\-|\\)","",names(myLeanDataSet))
names(myLeanDataSet) <- gsub("^t","Time",names(myLeanDataSet))
names(myLeanDataSet) <- gsub("^f","Freq",names(myLeanDataSet))
names(myLeanDataSet) <- gsub("mean","Mean",names(myLeanDataSet))
names(myLeanDataSet) <- gsub("std","StdDev",names(myLeanDataSet))
names(myLeanDataSet) <- gsub("Acc","Accelerometer",names(myLeanDataSet))
names(myLeanDataSet) <- gsub("Gyro","Gyroscope",names(myLeanDataSet))
names(myLeanDataSet) <- gsub("Mag","Magnitude",names(myLeanDataSet))
names(myLeanDataSet) <- gsub("BodyBody","Body",names(myLeanDataSet))

    cat("  Number of rows in lean data set: ",nrow(myLeanDataSet),"\n")
    cat("  Number of columns in lean data set: ",ncol(myLeanDataSet),"\n")
    cat("\n")
    cat("Creating column headers text file ...", "\n")

# Create a file with column headers for review
  ColumnHeaders <- names(myLeanDataSet)
  sink(file="../ColumnHeaders.txt")
  cat(ColumnHeaders,sep="\n")
  sink()

  
# Create TidyData and SummaryTidyData data sets
  
    cat("Creating and summarizing data sets ...","\n")
TidyData <- myLeanDataSet
SummaryTidyData <- group_by(TidyData,Subject,Activity) 
SummaryTidyData <- summarise_each(SummaryTidyData, funs(mean))

    cat("  Total # of rows in the tidy data set is: ", nrow(TidyData) , "\n")
    cat("  Total # of rows in the summarized data set by Subject and Activity is: ", nrow(SummaryTidyData), "\n")

# Create text files using write.table as per project specification  
write.table(TidyData,file="../TidyData.txt",sep="\t",row.names=FALSE)
write.table(SummaryTidyData,file="../SummaryTidyData.txt",sep="\t",row.names=FALSE)

# Clean up the environment by removing temporary/staging data sets and variables
    cat("\n")
    cat("Cleaning up environment ..." , "\n")
    rm(list = ls()[!ls() %in% c('TidyData','SummaryTidyData','ColumnHeaders')])
    cat("Following objects are in enrvironment for use ..." , "\n")
    cat("   ", ls(),"\n")
    cat("\n")
    
    cat("Check for ColumnHeaders.txt file for all the column headings","\n")
    cat("Check for TidyData.txt and SummaryTidyData.txt in working directory","\n")

# Reset working directory
setwd("../")