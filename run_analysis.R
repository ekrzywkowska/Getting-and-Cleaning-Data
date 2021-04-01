#This is script to load, clean and analysis data
library(dplyr)
# 1. Merges the training and test sets to create one data ser
# First, load data into R
#     - check working directory and change if needed
#     - load data into data frames

getwd()
setwd("C:/Users/Ewa/Documents/Getting-and-Cleaning-Data")
train = read.table("C:/Users/Ewa/Documents/Getting-and-Cleaning-Data/train/X_train.txt")
test = read.table("C:/Users/Ewa/Documents/Getting-and-Cleaning-Data/test/X_test.txt")
train_label = read.table("C:/Users/Ewa/Documents/Getting-and-Cleaning-Data/train/y_train.txt")
test_label = read.table("C:/Users/Ewa/Documents/Getting-and-Cleaning-Data/test/y_test.txt")
subject_train = read.table("C:/Users/Ewa/Documents/Getting-and-Cleaning-Data/train/subject_train.txt")
subject_test = read.table("C:/Users/Ewa/Documents/Getting-and-Cleaning-Data/test/subject_test.txt")

#Secondly, merge both dataset with label & together

train_df = cbind(subject_train,train_label,train)
test_df = cbind(subject_test, test_label, test)

data = rbind(test_df,train_df)

# 2. Extraxts only the measurements on the mean and standard deviation for each measures

# read columns names in features.txt
features = read.table("C:/Users/Ewa/Documents/Getting-and-Cleaning-Data/features.txt")

colnames(data)[3:563] = features[,2]
colnames(data)[1] = "subject"
colnames(data)[2] = "y"

# extraxt all columns with mean or sd
data1 = data[, grepl("mean()|std()",names(data))]
# remove meanFreq() columns
data2 = data1[, -which(grepl("meanFreq()",names(data1)))]

# 3. Use descriptive activity names to name the acitivity in the data set

#add again label y column and subject column (first and second columns from original data)
data3 = cbind(data[,1:2],data2)

#load activity table for lookup
activity = read.table("C:/Users/Ewa/Documents/Getting-and-Cleaning-Data/activity_labels.txt")
colnames(activity)[1] = "y"

#merge and lookup activity with column y
data4 = merge(activity, data3, by = "y")
#drop column y
data5=select(data4,-y)
#rename column V2 for Activity
colnames(data5)[1] = "activity"

# 4. Appropriately labels the data set with descriptive variable names

# My columns names was already changed in point 2
# Now, I will remove "()"
colnames(data5) = gsub("\\(\\)","", colnames(data5))
# Change t to time
colnames(data5)[3:67] = sub("t","time", colnames(data5)[3:67])
#change f to frequency
colnames(data5) = sub("f","frequency", colnames(data5))

# 5. From the data set in step 4, create second, independent tidy data set with the average of eacg variable for each activity and each subject

library(reshape2)
#melt data to use dcast
dataMelt = melt(data5, id = c("activity", "subject"))
#use dcast to get data in right shape
data6 = dcast(dataMelt, subject + activity ~ variable, mean)
#save it to txt file
write.table(data6,"data-frame.txt",row.names = FALSE)
#the end

