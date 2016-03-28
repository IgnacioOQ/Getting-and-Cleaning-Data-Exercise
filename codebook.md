
I am not clear at all what information is meant to be in the codebook. The requirement is that it should be "a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data".

The variables in the last file submitted are the following:


 [1] "Subject Id"                      "Activity Id"                     "Activity Label"                  "tBodyAcc-std()-X"
 [5] "tBodyAcc-std()-Y"                "tBodyAcc-std()-Z"                "tGravityAcc-std()-X"             "tGravityAcc-std()-Y"
 [9] "tGravityAcc-std()-Z"             "tBodyAccJerk-std()-X"            "tBodyAccJerk-std()-Y"            "tBodyAccJerk-std()-Z"
[13] "tBodyGyro-std()-X"               "tBodyGyro-std()-Y"               "tBodyGyro-std()-Z"               "tBodyGyroJerk-std()-X"
[17] "tBodyGyroJerk-std()-Y"           "tBodyGyroJerk-std()-Z"           "tBodyAccMag-std()"               "tGravityAccMag-std()"
[21] "tBodyAccJerkMag-std()"           "tBodyGyroMag-std()"              "tBodyGyroJerkMag-std()"          "fBodyAcc-std()-X"
[25] "fBodyAcc-std()-Y"                "fBodyAcc-std()-Z"                "fBodyAccJerk-std()-X"            "fBodyAccJerk-std()-Y"
[29] "fBodyAccJerk-std()-Z"            "fBodyGyro-std()-X"               "fBodyGyro-std()-Y"               "fBodyGyro-std()-Z"
[33] "fBodyAccMag-std()"               "fBodyBodyAccJerkMag-std()"       "fBodyBodyGyroMag-std()"          "fBodyBodyGyroJerkMag-std()"
[37] "tBodyAcc-mean()-X"               "tBodyAcc-mean()-Y"               "tBodyAcc-mean()-Z"               "tGravityAcc-mean()-X"
[41] "tGravityAcc-mean()-Y"            "tGravityAcc-mean()-Z"            "tBodyAccJerk-mean()-X"           "tBodyAccJerk-mean()-Y"
[45] "tBodyAccJerk-mean()-Z"           "tBodyGyro-mean()-X"              "tBodyGyro-mean()-Y"              "tBodyGyro-mean()-Z"
[49] "tBodyGyroJerk-mean()-X"          "tBodyGyroJerk-mean()-Y"          "tBodyGyroJerk-mean()-Z"          "tBodyAccMag-mean()"
[53] "tGravityAccMag-mean()"           "tBodyAccJerkMag-mean()"          "tBodyGyroMag-mean()"             "tBodyGyroJerkMag-mean()"
[57] "fBodyAcc-mean()-X"               "fBodyAcc-mean()-Y"               "fBodyAcc-mean()-Z"               "fBodyAcc-meanFreq()-X"
[61] "fBodyAcc-meanFreq()-Y"           "fBodyAcc-meanFreq()-Z"           "fBodyAccJerk-mean()-X"           "fBodyAccJerk-mean()-Y"
[65] "fBodyAccJerk-mean()-Z"           "fBodyAccJerk-meanFreq()-X"       "fBodyAccJerk-meanFreq()-Y"       "fBodyAccJerk-meanFreq()-Z"
[69] "fBodyGyro-mean()-X"              "fBodyGyro-mean()-Y"              "fBodyGyro-mean()-Z"              "fBodyGyro-meanFreq()-X"
[73] "fBodyGyro-meanFreq()-Y"          "fBodyGyro-meanFreq()-Z"          "fBodyAccMag-mean()"              "fBodyAccMag-meanFreq()"
[77] "fBodyBodyAccJerkMag-mean()"      "fBodyBodyAccJerkMag-meanFreq()"  "fBodyBodyGyroMag-mean()"         "fBodyBodyGyroMag-meanFreq()"
[81] "fBodyBodyGyroJerkMag-mean()"     "fBodyBodyGyroJerkMag-meanFreq()"

The first three variables are basically Id variables; for the Subject, the activity and the label for activities.
The second group of variables, from the 4th to the 36th, are standard deviation variables. The rest, from 37th to 82nd, are mean variables.

Each row in the data submitted corresponds, as required, to the average of each variable for each activity and each subject.

The transformation I have done has seven parts. The code has detailed comments for further understanding. 

The first part is meant to load the data into R (Studio). The names of the data frames correspond precisely with the names of the *.txt in the assignment.

The second part is meant to assign the variables in the data frames X_test and X_train a descriptive name according to the features data frame. I here use the package data.table, which makes things far more easy.

The third part is very short and the purpose of it is to associate each activity id number with its label. Some steps here are done by brute force, and I am sure things could be done in a more elegant way, but my method works just fine.

The fourth part is meant to combine all the data in one very big data frame. First I combine the test data set. Second I combine the train data set. Finally, I combine both.

The fifth step is meant to give us a data frame with the variables in which mean and standard deviation appear. First, I look at the columns in which "std" and "mean" appear. Second, I subset appropriately. Finally, I bind the relevant data subsets.

The sixth step is to find the means and creating a data frame with them. First, I define a function that given a subject and activity id, it gives you the means of the relevant columns. Second, I apply the function iteratively so to consider all the cases and build a data frame with them.

The final step is there just to write the data frames into the relevant files. 

Note: "combined.data.txt" is all the data combined. It should not be confused with "subsetted.data.txt" which is what is required in assignment 2. The file required in assigment 5 is called "data.id.means.txt".
