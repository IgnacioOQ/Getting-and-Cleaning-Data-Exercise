Hello! I hope you are doing well. This project was far more demanding than expected.

The analysis I have done has seven parts. The code has detailed comments for further understanding. 
I added a third file to the github repo, "combined.data.txt", which is all the data combined. It should not be confused with "subsetted.data.txt" which is what is required in assignment 2. The file required in assigment 5 is called "data.id.means.txt".

The first part is meant to load the data into R (Studio). The names of the data frames correspond precisely with the names of the *.txt in the assignment.

The second part is meant to assign the variables in the data frames X_test and X_train a descriptive name according to the features data frame. I here use the package data.table, which makes things far more easy.

The third part is very short and the purpose of it is to associate each activity id number with its label. Some steps here are done by brute force, and I am sure things could be done in a more elegant way, but my method works just fine.

The fourth part is meant to combine all the data in one very big data frame. First I combine the test data set. Second I combine the train data set. Finally, I combine both.

The fifth step is meant to give us a data frame with the variables in which mean and standard deviation appear. First, I look at the columns in which "std" and "mean" appear. Second, I subset appropriately. Finally, I bind the relevant data subsets.

The sixth step is to find the means and creating a data frame with them. First, I define a function that given a subject and activity id, it gives you the means of the relevant columns. Second, I apply the function iteratively so to consider all the cases and build a data frame with them.

The final step is there just to write the data frames into the relevant files. 

Note: I added a third file to the github repo, "combined.data.txt", which is all the data combined. It should not be confused with "subsetted.data.txt" which is what is required in assignment 2. The file required in assigment 5 is called "data.id.means.txt".# Getting-and-Cleaning-Data
