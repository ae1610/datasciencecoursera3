fcn <- function() {

library(dplyr)

feats <- read.table("C:/Users/######/Documents/R/UCI HAR Dataset/features.txt")
testfeats <- read.table("C:/Users/######/Documents/R/UCI HAR Dataset/test/X_test.txt")
trainfeats <- read.table("C:/Users/######/Documents/R/UCI HAR Dataset/train/X_train.txt")
testact <- read.table("C:/Users/######/Documents/R/UCI HAR Dataset/test/y_test.txt")
trainact <- read.table("C:/Users/######/Documents/R/UCI HAR Dataset/train/y_train.txt")
testsub <- read.table("C:/Users/######/Documents/R/UCI HAR Dataset/test/subject_test.txt")
trainsub <- read.table("C:/Users/######/Documents/R/UCI HAR Dataset/train/subject_train.txt")

filepath1 = "C:/Users/######/Documents/R/UCI HAR Dataset/test/Inertial Signals"
filepath2 = "C:/Users/######/Documents/R/UCI HAR Dataset/train/Inertial Signals"

setwd(filepath1)
testfiles <- list.files("C:/Users/######/Documents/R/UCI HAR Dataset/test/Inertial Signals")
testlength <- length(testfiles)
dftest <- data.frame(1:2947)

	for (i in 1:testlength) {
		df1 <- as.data.frame(read.table(testfiles[[i]], header = F))
		dfm <- rowMeans(df1)
		dftest <- cbind(dftest,dfm)
	}



setwd(filepath2)
trainfiles <- list.files("C:/Users/######/Documents/R/UCI HAR Dataset/train/Inertial Signals")
trainlength <- length(trainfiles)
dftrain <- data.frame(1:7352)

	for (i in 1:trainlength) {
		df1 <- as.data.frame(read.table(trainfiles[[i]], header = F))
		dfm <- rowMeans(df1)
		dftrain <- cbind(dftrain,dfm)
	}

subjects <- rbind(testsub,trainsub)
activities <- rbind(testact,trainact)
ttfeats <- rbind(testfeats,trainfeats)
testsigs <- dftest[,2:10]
trainsigs <- dftrain[,2:10]
ttsigs <- rbind(testsigs,trainsigs)

activities$V1[activities$V1 == 1] <- "Walking"
activities$V1[activities$V1 == 2] <- "Walking Upstairs"
activities$V1[activities$V1 == 3] <- "Walking Downstairs"
activities$V1[activities$V1 == 4] <- "Sitting"
activities$V1[activities$V1 == 5] <- "Standing"
activities$V1[activities$V1 == 6] <- "Laying"

colnames(ttfeats) <- feats$V2
colnames(subjects) <- "Subject"
colnames(activities) <- "Activity"
colnames(ttsigs) <- c("body_acc_x","boby_acc_y","body_acc_z","body_gyro_x","body_gyro_y","body_gyro_z","total_acc_x","total_acc_y","total_acc_z")

table <- cbind(subjects,activities,ttfeats,ttsigs)

write.table(table,file="tidied_data.txt",row.names= FALSE)

}