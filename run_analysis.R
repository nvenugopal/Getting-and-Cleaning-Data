##
## This program implements the project for Getting
## and Cleaning Data

## First read in the activity labels
con <- file("activity_labels.txt")
open(con, "r")
activity <- read.table(con, FALSE)
close(con)
activity

## Read in the test data
con <- file("./x_test.txt")
open(con, "r")
xtestData <- read.table(con, FALSE)
close(con)

con <- file("./y_test.txt")
open(con, "r")
ytestData <- read.table(con, FALSE)
close(con)

con <- file("./subject_test.txt")
open(con, "r")
subtestData <- read.table(con, FALSE)
close(con)

head(xtestData)
head(ytestData)
head(subtestData)

## Read in the train data
con <- file("./x_train.txt")
open(con, "r")
xtrainData <- read.table(con, FALSE)
close(con)

con <- file("./y_train.txt")
open(con, "r")
ytrainData <- read.table(con, FALSE)
close(con)

con <- file("./subject_train.txt")
open(con, "r")
subtrainData <- read.table(con, FALSE)
close(con)

head(xtrainData)
head(ytrainData)
head(subtrainData)

##Convert the activities table into a vector
acts <- activity[[2]]
acts

##convert ytestData into proper activity names
ytestActs <- unlist(ytestData)
ytestActs <- factor(ytestActs, labels = acts)
tail(ytestData)
tail(ytestActs)

##Convert ytestActs into a dataframe
ytestActs <- data.frame(ytestActs)

## column bind the subtestData, ytestActs, xtestData to get
## one set of test data which has the subject id, the activity
## and the observations for the variables.
testData <- cbind(subtestData, ytestActs, xtestData)

##convert ytrainData into proper activity names
ytrainActs <- unlist(ytrainData)
ytrainActs <- factor(ytrainActs, labels = acts)

## In order to keep the column name the same, recast
## ytrainActs as ytestActs
ytestActs <- ytrainActs

## column bind the subtrainData, ytrainActs, xtrainData to get
## one set of test data which has the subject id, the activity
## and the observations for the variables.
trainData <- cbind(subtrainData, ytestActs, xtrainData)

##Now row bind the testData and trainData to get the complete data set
allData <- rbind(trainData, testData)

## Read in the descriptive column heading from features.txt
con <- file("./features.txt")
open(con, "r")
featureNames <- read.table(con, FALSE)
close(con)
##
## The featureNames data frame must be converted to a vector
## of names for the variables.  Additionally create a vector
## for the column names for the first two columns
varNames <- as.vector(featureNames[,2])
addNames <- c("SubjectID", "Activity")

## Now concatenate the two name vectors together
allNames <- c(addNames, varNames)

## Now apply the allNames vector containing the column names to the
## combined data set allData
colnames(allData) <- allNames

## Now using the grepl function only get those columns
## that represent variables of mean() and std()
## Include the first two columns also: Subject ID and
## Activity
tidyData <-allData[,grepl("\\bSubjectID\\b|\\bActivity\\b|\\bmean()\\b|\\bstd()\\b",colnames(allData))]
head(tidyData[1])
head(tidyData[2])
head(tidyData[3])
head(tidyData[36])

## Order the tidyData by SubjectID and Activity
newtidyData <- tidyData[order(tidyData$SubjectID,tidyData$Activity),]
head(newtidyData[1:2],n = 350)

## Now apply the dplyr function group_by() to group by the
## SubjectID and the Activity
groupedtidyData <- group_by(newtidyData,SubjectID, Activity)

## Generate the final tidy dataset by calculating the mean
## for the grouped data
finaltidyData <- summarise_each(groupedtidyData,funs(mean))
head(finaltidyData[1:4],n = 12)

## Write the finaltidyData into a text file.
con <- file("./finaltidyData.txt")
open(con, "w")
write.table(finaltidyData,con,row.names = FALSE)
close(con)

