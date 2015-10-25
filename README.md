# Getting-and-Cleaning-Data
Coursera: Getting and Cleaning Data - Project

Description of the process used for creating the final tidy dataset as part of the data scientist course "Getting and Cleaning Data"

by Gopal Venugopal.

First, thanks to the help provided by my peers in this class through the suggestions they offered on the project discussion boards.  Looking at those suggestions I was able to improve upon my logic.  And indeed some issues that I had grappled unsuccessfully with for hours, I was able to solve after trying out the suggestions from the discussions.  This is truly a collaborative approach and I am grateful to all those who willingly shared their knowledge for the benefit of others.

This project takes the dataset from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

 The working directory is the current folder where the R program is, and all the data files need to be in this same directory.  In this folder the following datafiles are needed:
 
 activity_labels.txt
 features.txt
 subject_test.txt
 subject_train.txt
 x_test.txt
 y_test.txt
 x_train.txt
 y_train.txt
 
 The R Program is in the file run_analysis.R
 
 The program performs the following steps:
 
 1. It reads in the input file activity_labels.txt and stores it in a data frame "activity"
 
 2.  Reads in the test datasets: x_test.txt into xtestData, y_test.txt into ytestData, and subject_test.txt into subtestData.
 
 These three files relates the 561 variable measurements for the test data, for the 2947 observations (records), with the actual subject IDs that are contributing to the dataset, along with the activity codes.
 
 3. Similarly read in the x_train.txt - which contains the 561 measurements for the variables for each of the 7352 records, along with y_train.txt that contsins the corresponding activity codes for each record, and subject_train.txt that contains the corresponding activity codes.
 
 4. Next we convert the activities tables into a vector "acts" that contains the descriptive label for each activity.
 
 5. We next convert the ytestData into its proper activity names by using the factor function and passing in the "acts" vector as the label.  The new vector ytestActs is then converted into a data frame to keep it consistent with the other test data.
 
 6. Now the three  test data tables: subtestData, ytestActs and xtestData are combined into a single data frame called "testData" using the cbind function.
 
 7. We do a similar process with the training data and create a single data table "trainData" that contains the subtrainData, ytrainActs, and xtrainData.
 
 8. We now combine the trainData and testData together to create one table called "allData" consisting of 10299 rows and 563 columns.
 
 9  We now name the columns of the "allData" data frame.  For this we read in the "features.txt" file which contains the names of the 561 variables and convert this into a vector called "varNames".  We create a second vector "addNames" that contains the headings "SubjectID" and "Activity" for the first two columns we combined previously.  We create a single vector "allNames" that has the descriptive name for the 563 columns of "allData"
 
 10. Using the colnames() function we replace the default colnames of "allData", with that in "allNames".
 
 11. Using the "grepl()" function, we create a data frame "tidyData" that only includes those of the 561 variables, that has a substrin "min()" and "std()" in its name.  We also include the colnames "SubjectID" and "Activity" so that the first two columns are also subsetted.
 
 12. "tidyData" now has 68 columns and 10299 rows.  Using the "order()" function we order the rows in "tidyData" by the "SubjectID" and "Activity".
 
 13. We can now use the "group_by()" function to group the tidyData by "SubjectID" and "Activity". 
 
 14. Finally, we create the required tidy dataset, "finaltidyData" that will contain for each "SubjectID" and "Activity" the mean of the 66 observations that we kept for this study.  We do this by using the "dplyr" package function "summarise_each()"
 
 15. The final data set consists of 180 rows and 68 columns.

