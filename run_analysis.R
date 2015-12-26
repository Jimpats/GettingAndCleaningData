suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(dplyr)) 

if (!dir.exists("UCI HAR Dataset")) 
  {
      cat("Downloading and extracting raw data set from internet ... " , "\n")
      fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileUrl , destfile="./getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",method="curl" ,quiet=TRUE)
      suppressMessages(unzip(zipfile="getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",overwrite=TRUE))
      file.remove("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
  }

setwd("UCI HAR Dataset/")
cat("Reading and merging the data sets ...", "\n")

xTest <- read.table("test/X_test.txt",sep="")
xTrain <- read.table("train/X_train.txt",sep="")
xFinal <- rbind(xTest,xTrain)

yTest <- read.table("test/Y_test.txt",sep="")
yTrain <- read.table("train/Y_train.txt",sep="")
yFinal <- rbind(yTest,yTrain)

subjectTest <- read.table("test/subject_test.txt",sep="")
subjectTrain <- read.table("train/subject_train.txt",sep="")
subjectFinal <- rbind(subjectTest,subjectTrain)

activityUse <- read.table("activity_labels.txt",stringsAsFactors=FALSE , sep="")
colnames(activityUse) <- c("ActivityID","Activity")


features <- read.table("features.txt", stringsAsFactors=FALSE , sep="")
featuresUse <- (features[,2])

colnames(xFinal) <- featuresUse
colnames(yFinal) <- c("ActivityID")
colnames(subjectFinal) <- c("Subject")

activityLabel <- join(yFinal,activityUse,by="ActivityID")

cat("  Number of rows in merged data set: ",nrow(xFinal),"\n")
cat("  Number of columns in merged data set: ",ncol(xFinal),"\n")

cat("\n")
cat("Selecting only the columns with mean and std in names. Tidying up the column names to make them more readable ...","\n")

myDataSet <- xFinal[,grep("mean|std",featuresUse)]

myLeanDataSet <- cbind(subjectFinal,Activity=activityLabel[,"Activity"],myDataSet)
  

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

ColumnHeaders <- names(myLeanDataSet)
sink(file="../ColumnHeaders.txt")
cat(ColumnHeaders,sep="\n")
sink()

  cat("Creating and summarizing data sets ...","\n")


TidyData <- myLeanDataSet
SummaryTidyData <- group_by(TidyData,Subject,Activity) 
SummaryTidyData <- summarise_each(SummaryTidyData, funs(mean))
#%>% summarise_each(funs(mean))

  cat("  Total # of rows in the tidy data set is: ", nrow(TidyData) , "\n")
  cat("  Total # of rows in the summarized data set by Subject and Activity is: ", nrow(SummaryTidyData), "\n")
  
write.table(TidyData,file="../TidyData.txt",sep="\t",row.names=FALSE)
write.table(SummaryTidyData,file="../SummaryTidyData.txt",sep="\t",row.names=FALSE)

  cat("\n")
  cat("Cleaning up environment ..." , "\n")
  rm(list = ls()[!ls() %in% c('TidyData','SummaryTidyData','ColumnHeaders')])
  cat("Following objects are in enrvironment for use ..." , "\n")
  cat("   ", ls(),"\n")
  cat("\n")
  cat("Check for ColumnHeaders.txt file for all the column headings","\n")
  cat("Check for TidyData.txt and SummaryTidyData.txt in working directory","\n")

  setwd("../")