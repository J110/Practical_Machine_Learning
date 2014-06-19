
## Reads the training raw file
UCD_train = read.table('~/UCI HAR Dataset/train/X_train.txt', header = FALSE);


## Reads the testing raw file
UCD_test = read.table('~/UCI HAR Dataset/test/X_test.txt', header = FALSE);


## Reads the feature list for column names
feature_list = read.table('~/UCI HAR Dataset/features.txt',header=FALSE);


## Reads the description of all 6 activity types
activity_type = read.table('~/UCI HAR Dataset/activity_labels.txt',header=FALSE);


## Reads the subject IDentification for training data
subjectID_train = read.table('~/UCI HAR Dataset/train/subject_train.txt',header=FALSE);


## Reads the subject IDentification for testing data
subjectID_test = read.table('~/UCI HAR Dataset/test/subject_test.txt',header=FALSE);


## Reads the activity IDentification for training data
activity_train = read.table('~/UCI HAR Dataset/train/y_train.txt',header=FALSE);

## Reads the activity IDentification for testing data
activity_test = read.table('~/UCI HAR Dataset/test/y_test.txt',header=FALSE);


## ProvIDe column names to activity type data
colnames(activity_type) = c('activity_ID','activity_type');


## ProvIDe column names to subject ID in raw data
colnames(subjectID_train)  = "subject_ID";
colnames(subjectID_test)  = "subject_ID";

## Copy feature list as column names for raw training and testing data
colnames(UCD_train) = feature_list[,2];
colnames(UCD_test) = feature_list[,2];


## ProvIDe column names to activity ID in raw data
colnames(activity_train) = "activity_ID";
colnames(activity_test) = "activity_ID";


## Column Binding Training and Testing data with respective subject ID and activity ID
Train_Final = cbind(subjectID_train, activity_train, UCD_train)
Test_Final = cbind(subjectID_test, activity_test, UCD_test)


## Mergining Training and Testing Data
merged_Data = rbind(Train_Final, Test_Final)


##--------------------- Completion of Step 1------------------------------##

## Create a list of column names from merged Data to pick up relevant columns only
column_list = colnames(merged_Data)


## Create logical vector to pick up mean, std, activity ID and subject ID columns (exclude meanFreq column name)
column_pick = ((grepl('mean()', column_list) & !grepl('meanFreq', column_list)) | grepl('std()', column_list) | grepl('activity', column_list) | grepl('subject', column_list))

## Pick selected column in merged Data
merged_Data = merged_Data[column_pick == TRUE]

##--------------------- Completion of Step 2------------------------------##

## merge Data with activity type to get activity description in the data
merged_Data = merge(merged_Data, activity_type, by = 'activity_ID', all = TRUE)

##--------------------- Completion of Step 3------------------------------##

## create modified list of column names to clean 
column_list = colnames(merged_Data)

## Create a function to provIDe descriptions to abbreviations in column names
for (i in 1:length(column_list)){
	column_list[i] = gsub("^(t)","time-",column_list[i])
	column_list[i] = gsub("^(f)","freq-",column_list[i])
	column_list[i] = gsub("Acc","-Acceleration",column_list[i])
	column_list[i] = gsub("Gyro","-Gyroscope",column_list[i])
	column_list[i] = gsub("Mag","-Magnitude",column_list[i])
	column_list[i] = gsub("mean","Mean",column_list[i])
	column_list[i] = gsub("std","StdDev",column_list[i])
	column_list[i] = gsub("()","",column_list[i])
	column_list[i] = gsub("X","xAxis",column_list[i])
	column_list[i] = gsub("Y","yAxis",column_list[i])
	column_list[i] = gsub("Z","zAxis",column_list[i])
	}


## ProvIDe cleaned up column names to merged Data
colnames(merged_Data) = column_list

##--------------------- Completion of Step 4------------------------------##


library(reshape2)

## melt the data based on subject_ID and activity_ID (remove activity_type from data set)
melted_Data = melt(merged_Data[ ,-c(69)] , id = c("subject_ID", "activity_ID"))

## Create a final dataset by dcasting mean on variables
tidy_Data = dcast(melted_Data, subject_ID + activity_ID ~ variable, mean)

## Bring back activity description on tIDy data set
tidy_Data = merge(tidy_Data, activity_type, by = 'activity_ID', all = TRUE)

## Write tIDy data set to a file
write.table(tidy_Data, 'tidy_data_set.txt', row.names = FALSE, quote = FALSE)

##--------------------- Completion of Step 5------------------------------##
