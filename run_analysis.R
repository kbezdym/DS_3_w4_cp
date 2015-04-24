#Add libraries
library(dplyr)

#Load and upgrading data
ts1 <- read.table("./UCI HAR Dataset/test/X_test.txt")
tr1 <- read.table("./UCI HAR Dataset/train/X_train.txt")
tr2 <- read.table("./UCI HAR Dataset/train/y_train.txt")
ts2 <- read.table("./UCI HAR Dataset/test/y_test.txt")
str <- read.table("./UCI HAR Dataset/train/subject_train.txt")
sts <- read.table("./UCI HAR Dataset/test/subject_test.txt")
cn <- read.table("./UCI HAR Dataset/features.txt")
an <- read.table("./UCI HAR Dataset/activity_labels.txt")


#Add names to columns of activity list
colnames(an) <- c("ActivityCode", "ActivityName")

#Merge subject and activity lists
tr3 <- cbind(str, tr2)
ts3 <- cbind(sts, ts2)

#Add colums names
colnames(tr3) <- c("Subject", "Activity")
colnames(tr1) <- cn$V2

colnames(ts3) <- c("Subject", "Activity")
colnames(ts1) <- cn$V2

#Merge subject/activity with measurment list
tr <- cbind(tr3,tr1)
ts <- cbind(ts3,ts1)

#Merge (step1)
t <- rbind(tr,ts)

#step2 (select measures with mean and std)
t <- subset(t,select = c(TRUE,TRUE,grepl("std\\()|mean\\()", cn$V2)))

#step3 (Create new column for activity that consist a normal names of activities)
t <- merge(an,t, by.y = "Activity", by.x = "ActivityCode")
t <- select(t, -(ActivityCode))

#step4 (Cleaning column names)
c <- colnames(t)
c <- sub("^t","Time", c)
c <- sub("^f","Freq", c)
c <- gsub("-","", c)
c <- gsub("\\()","", c)
c <- gsub("BodyBody","Body", c)
c <- tolower(c)

colnames(t) <- c


#step5 (Create final set and write it to file)
gr <- group_by(t, activityname, subject)
endtable <- summarise_each(gr,funs(mean))

write.table(endtable,file = "run_analysis.txt", row.name=FALSE)


