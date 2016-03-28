#STEP 1: READING THE DATA INTO R (STUDIO)

setwd("./UCI HAR Dataset")

features <- read.table("features.txt")

actvity_labels <- read.table("activity_labels.txt")

setwd("./test")

subject_test <- read.table("subject_test.txt")

X_test <- read.table("X_test.txt")

y_test <- read.table("y_test.txt")
setwd("..")
setwd("./train")

subject_train <- read.table("subject_train.txt")

X_train <- read.table("X_train.txt")

y_train <- read.table("y_train.txt")

setwd("..")


#STEP 2: TIDY THE DATA, ASSIGNING THE RIGHT NAMES TO THE VARIABLES

# the best way of changing the names that I found is by using the package data.table.

library(data.table)

#Now for the training and test sets
#extract the names of the variables into a character list.

variable.names <- as.character(features[,2])

#rename them

X_train.renamed <- setnames(X_train, old = names(X_train), new = variable.names)

X_test.renamed <- setnames(X_test, old = names(X_test), new = variable.names)

#do something similar for the subject train and test, assigning "Subject Id" to the left variable

subject_train.renamed <- subject_train
colnames(subject_train.renamed)[1] <- "Subject Id"


subject_test.renamed <- subject_test
colnames(subject_test.renamed)[1] <- "Subject Id"
head(subject_test.renamed)

#similarly for the training and test labels

y_test.renamed <- y_test
colnames(y_test.renamed)[1] <- "Activity Id"

y_train.renamed <- y_train
colnames(y_train.renamed)[1] <- "Activity Id"


#STEP 3: ASSOCIATING EACH ACTIVITY ID WITH ITS LABEL

#We start by duplicating the columns in the training and test files, and by naming the second column "Activity Label"

y_test.renamed <- cbind(y_test.renamed,y_test.renamed)
colnames(y_test.renamed)[2] <- "Activity Label"

y_train.renamed <- cbind(y_train.renamed,y_train.renamed)
colnames(y_train.renamed)[2] <- "Activity Label"

#We then replace the numbers by the activity name. There is probably a better way of doing this, but this one works just fine.

y_train.renamed$`Activity Label` <- gsub("1","WALKING",y_train.renamed$`Activity Label`)
y_train.renamed$`Activity Label` <- gsub("2","WALKING_UPSTAIRS",y_train.renamed$`Activity Label`)
y_train.renamed$`Activity Label` <- gsub("3","WALKING_DOWNSTAIRS",y_train.renamed$`Activity Label`)
y_train.renamed$`Activity Label` <- gsub("4","SITTING",y_train.renamed$`Activity Label`)
y_train.renamed$`Activity Label` <- gsub("5","STANDING",y_train.renamed$`Activity Label`)
y_train.renamed$`Activity Label` <- gsub("6","LAYING",y_train.renamed$`Activity Label`)

y_test.renamed$`Activity Label` <- gsub("1","WALKING",y_test.renamed$`Activity Label`)
y_test.renamed$`Activity Label` <- gsub("2","WALKING_UPSTAIRS",y_test.renamed$`Activity Label`)
y_test.renamed$`Activity Label` <- gsub("3","WALKING_DOWNSTAIRS",y_test.renamed$`Activity Label`)
y_test.renamed$`Activity Label` <- gsub("4","SITTING",y_test.renamed$`Activity Label`)
y_test.renamed$`Activity Label` <- gsub("5","STANDING",y_test.renamed$`Activity Label`)
y_test.renamed$`Activity Label` <- gsub("6","LAYING",y_test.renamed$`Activity Label`)


#STEP 4: COMBINE ALL THE DATA INTO A BIG DATA FRAME CALLED combined.data

#First I combine the test data set.
combined.test <- cbind(subject_test.renamed,y_test.renamed,X_test.renamed)

#Second I combine the train data set.
combined.train <- cbind(subject_train.renamed,y_train.renamed,X_train.renamed)

#Finally, I combine both.
combined.data <- rbind(combined.test,combined.train)


#STEP 5: SUBSETTING THE STANDARD DEVIATION AND THE MEAN

#First, I look at the columns in which "std" and "mean" appear.
stdcols <- grep("std",names(combined.data))
meancols <- grep("mean",names(combined.data))

#Second, I subset appropriately.
first.cols.data <- combined.data[,1:3]
std.subsetted.data <- combined.data[,stdcols]
mean.subsetted.data <- combined.data[,meancols]

#Finally, I bind the relevant data subsets.
subsetted.data <- cbind(first.cols.data,std.subsetted.data,mean.subsetted.data)


#STEP 6: FINDING THE MEANS AND CREATING A DATA FRAME WITH THEM

library(dplyr)

#First, I define a function that given a subject and activity id, it gives you the means of the relevant columns.
calculatemeans <- function(x,y){
  temp.data.1 <- subset(subsetted.data, subsetted.data$`Subject Id` == x)
  temp.data.2 <- subset(temp.data.1, temp.data.1$`Activity Id` == y)
  temp.data.id <- temp.data.2[1,1:3]
  temp.data.means <- as.data.frame(t(colMeans(temp.data.2[,4:82])))
  temp.data.id.means <<- cbind(temp.data.id,temp.data.means)
}


data.id.means <- data.frame()
temp.data.id.means <- data.frame()

#Second, I apply the function iteratively so to consider all the cases and build a data frame with them.
for(i in 1:30){
  for(j in 1:6){
    calculatemeans(i,j)  
    data.id.means <<- rbind(data.id.means,temp.data.id.means)
  }}


#STEP 7: WRITING THE RELEVANT DATA FRAMES INTO .txt FILES

write.table(combined.data, file = "combined.data.txt")
write.table(subsetted.data, file ="subsetted.data.txt")
write.table(data.id.means, file = "data.id.means.txt")