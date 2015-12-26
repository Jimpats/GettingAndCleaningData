---
title: "Readme"
author: "Jimmy Patel"
date: "December 26, 2015"
output: html_document
---

##Introduction 
This document and files in this repository have been created to illustrate ways to clean and tidy up data.
Script run_analysis.R in the repository creates two data sets from the observations from original data available from:   
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip   
More details about the experiment and data is available at <BR> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

## Packages  
For successful execution of these scripts plyr and dplyr packages are required to be installed.  
If they are not installed, install the two packages using following commands in R:  
    &nbsp;&nbsp;&nbsp;&nbsp; `install.packages("plyr")`   
    &nbsp;&nbsp;&nbsp;&nbsp; `install.packages("dplyr")`    
      
## Files
1.  README.md   
    &nbsp;&nbsp;&nbsp;&nbsp;Provides details about all the files, and procedure to create data sets and sample output.  
2.  CodeBook.md   
    &nbsp;&nbsp;&nbsp;&nbsp;Provides details about data sets and how they were created.
3.  run_analysis.R
    &nbsp;&nbsp;&nbsp;&nbsp;R script to merge and clean the data and provide resulting data sets in a file.
    
## 
##Steps to create data sets
1.  Download the git repo.   
2.  Set working directory to the directory where run_analysis.R is download from git.    
3.  If the Samsung data does not exist in code directory in directory named "UCI HAR Dataset" then script downloads the data from intenet(active internet connection is required in that case).   
3.  Execute `run_analysis.R`    
4.  Review files which are created in working directory   
      a.  ColumnHeaders.txt
      b.  TidyData.txt
      c.  SummaryTidyData.txt
5.  Following objects are in workspace if intended to use them in R
      a.  ColumnHeaders  
      b.  TidyData
      c.  SummaryTidyData

##Output
Some helpful text is displayed on the screen when script is executed.

On R prompt from working directory execute `source ("run_analysis.R")`

If the data set is not present in same directory as `run_analysis.R` then first line of output will be:    
`Downloading and extracting raw data set from internet ...  `   

Output from the command should look like:
> source("run_analysis.R")  

Reading and merging the data sets ...   
    &nbsp;&nbsp;&nbsp;&nbsp;Number of rows in merged data set:  10299    
    &nbsp;&nbsp;&nbsp;&nbsp;Number of columns in merged data set:  561    
   
Selecting only the columns with mean and std in names. Tidying up the column names to make them more readable ...    
  &nbsp;&nbsp;&nbsp;&nbsp;Number of rows in lean data set:  10299   
  &nbsp;&nbsp;&nbsp;&nbsp;Number of columns in lean data set:  81   
   
Creating column headers text file ...   
Creating and summarizing data sets ...   
  &nbsp;&nbsp;&nbsp;&nbsp;Total # of rows in the tidy data set is:  10299   
  &nbsp;&nbsp;&nbsp;&nbsp;Total # of rows in the summarized data set by Subject and Activity is:  180   
   
Cleaning up environment ...    
Following objects are in enrvironment for use ...    
    &nbsp;&nbsp;&nbsp;&nbsp;ColumnHeaders SummaryTidyData TidyData    
    
Check for ColumnHeaders.txt file for all the column headings    
Check for TidyData.txt and SummaryTidyData.txt in working directory   
   
  
##License     

Human Activity Recognition Using Smartphones Dataset   
Version 1.0    
--------------------------------------------------------------------------------------------------------   
  
Use of this dataset in publications must be acknowledged by referencing the following publication [1]   

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012   

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.   
   
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.    