---
title: "Code Book"
author: "Jimmy Patel"
date: "December 25, 2015"
output: html_document
---


##Data sets
On executing run_analysis.R we get two data sets in text files:  
1.  TidyData.txt  
2.  SummaryTidyData.txt

### TidyData.txt
In this data set we merged the training and test data which was separate in original data provided. Upon merging the two, we added the subject data and activity labels.   
We reduced the number of columns to only include columns with mean and std in the labels for data provided.

First column in the output is `Subject`, it represents a participant in the study. Values for `Subject` are in the range from 1 to 30.  
Second column in the output is `Activity`, it represents an activity `Subject` took part in during the study. Each of the 30 subjects took part in all 6 of these activities.   
  
Activity has following values:     
- WALKING  
- WALKING_UPSTAIRS  
- WALKING_DOWNSTAIRS  
- SITTING  
- STANDING  
- LAYING  
  
As part of data cleanup we reduced original 561 columns of data collected to 79 columns of data with mean or std in column headers.  
These cryptic names were then made more readable by performing transformation of the column names.  
Some liberty was taken to keep names little short which deviate from standard practice to not abbreviate words in title.  
For example "std" was changed to "StdDev" instead of Standard Deviation".  
Also removed from the names were "(", "-",")".  
InitCap was applied to column names.  
In the original column headers first letter of f in the observation headers was indicated of frequency, it was changed to "Freq" and first letter of t in the observation headers was representation of time, it was changed to "Time".  
Repetitive occurence of "BodyBody" was changed to "Body".  

Some examples are:  
tBodyAcc-mean()-X was changed to `TimeBodyAccelerometerMeanX`  
tBodyAccMag-std() was changed to `TimeBodyAccelerometerMagnitudeStdDev`  
fBodyGyro-std()-X was changed to `FreqBodyGyroscopeStdDevX`  



### SummaryTidyData.txt
This data set is created from the TidyData data set. This data set provides summary using mean each variable for every `Subject` and `Activity`.
This reduces number of rows of data to each combination of 30 `Subject` and 6 `Activity` totalling to 180 observations.
TidyData was grouped by `Subject` and `Activity` and mean was calculated for rest of the variables.





