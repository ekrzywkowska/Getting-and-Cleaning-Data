# Getting-and-Cleaning-Data-Course-Project


This is script to load, clean and analysis data


1. Merges the training and test sets to create one data ser
 
 First, load data into R
     - check working directory and change if needed
     - load data into data frames

Secondly, merge both dataset with label & together

2. Extraxts only the measurements on the mean and standard deviation for each measures

Read columns names in features.txt and use it as column names (apart from first & second columns)

Extraxt all columns with mean or std in it. Remove meanFreq() columns as it is not needed. 


3. Use descriptive activity names to name the acitivity in the data set

Add again label y column and subject column (first and second columns from original data) - it got removed when filtering for meand ans sdt.

Load activity table for lookup from local. Merge and lookup activity with column y. Now just drop column y after merging and rename the new column V2 to Activity

4. Appropriately labels the data set with descriptive variable names

My columns names was already changed in point 2 so I dont need to import features again. 
Now, I will remove "()" ahd change "t" to time (only from third column) and change f to frequency

5. From the data set in step 4, create second, independent tidy data set with the average of eacg variable for each activity and each subject

use reshape to use metl & decast function
library(reshape2)
melt data to use dcast and then, use dcast to get data in right shape
The last step is to save this data frame to txt file
  
  #the end

