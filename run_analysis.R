run_analysis <- function(){
        #open the training data and label it with the features file
        train <- read.table("UCI HAR Dataset/train/X_train.txt")
        features <- read.table("UCI HAR Dataset/features.txt")
        colnames(train) <- features[,2]
        #subset this to readings including mean or std
        trainmean <- train[,grepl("*[Mm]ean*|*[Ss]td*",features[,2])]
        #open and name the activity file
        activity1 <- read.table("UCI HAR Dataset/train/y_train.txt")
        colnames(activity1) <- "activity1"
        #open and name the subject file
        subject1 <- read.table("UCI HAR Dataset/train/subject_train.txt")
        colnames(subject1) <- "subject"
        #join trainmean, activity1 and subject1
        trainmean <- cbind(activity1,subject1,trainmean)

        #open the test data and label it with the features file
        test <- read.table("UCI HAR Dataset/test/X_test.txt")
        colnames(test) <- features[,2]
        #subset this to readings including mean or std
        testmean <- test[,grepl("*[Mm]ean*|*[Ss]td*",features[,2])]
        #open and name the activity file
        activity2 <- read.table("UCI HAR Dataset/test/y_test.txt")
        colnames(activity2) <- "activity1"
        #open and name the subject file
        subject2 <- read.table("UCI HAR Dataset/test/subject_test.txt")
        colnames(subject2) <- "subject"
        #join testmean, activity2 and subject2
        testmean <- cbind(activity2,subject2,testmean)
        
        #join the test and training files
        merged1 <- rbind(trainmean,testmean)
        #tidy up the columnnames by removing brackets dashes commas and caps
        colnames(merged1) <- tolower(gsub("\\(|\\)|-|,","",colnames(merged1)))
        #create the activity descriptors
        actlabels <- data.frame(1:6,c("walk","walkup","walkdown","sit","stand","lay"))
        colnames(actlabels)<- c("activity1","activity")
        #use merge to join the actlabels and merged1 dataframes
        merged2 <- merge(actlabels,merged1)
        #ditch activity1 as we no longer require it
        merged2 <- merged2[,c(2:89)]
        #write the first dataset
        write.table(merged2, file="UCIHARtidy1.txt",row.names=FALSE,sep="\t")
        #use dplyr to summarize each variable by group
        library(dplyr)
        merged3 <- tbl_df(merged2) %>%
                group_by(subject, activity) %>%
                summarise_each(funs(mean), tbodyaccmeanx:anglezgravitymean)
        #write the second table
        write.table(merged3, file="UCIHARtidy2.txt",row.names=FALSE,sep="\t")
}