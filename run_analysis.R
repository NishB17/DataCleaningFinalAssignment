#Reading Column Names from Features.txt
featureTable <- read.table("features.txt")

#Retrieving Column Names for Data
ColumnNamesX <- featureTable$V2
ColumnNamesSubject <- c("Subject")
ColumnNamesY <- c("Activity")

remove(featureTable)

#Obtaining the Data in test Folder
testDataSubject <- read.table("test/subject_test.txt",header=FALSE,col.names = ColumnNamesSubject)
testDataX <- read.table("test/X_test.txt",header=FALSE,col.names = ColumnNamesX)
testDataY <- read.table("test/Y_test.txt",header=FALSE,col.names = ColumnNamesY)

#Combining the Three Test Data into a single Table
testData <- cbind(testDataSubject,testDataX,testDataY)
remove(testDataSubject,testDataX,testDataY)

#Obtaining the Data in the Train Folder
trainDataSubject <- read.table("train/subject_train.txt",header=FALSE,col.names = ColumnNamesSubject,)
trainDataX <- read.table("train/X_train.txt",header=FALSE,col.names=ColumnNamesX)
trainDataY <- read.table("train/Y_train.txt",header=FALSE,col.names = ColumnNamesY)
remove(ColumnNamesSubject,ColumnNamesX,ColumnNamesY)

#Combining the Three Train Data into a single Table
trainData <- cbind(trainDataSubject,trainDataX,trainDataY)
remove(trainDataSubject,trainDataX,trainDataY)

#Step 1 Combining Test and Train Data into a single Table
TotalData <- rbind(trainData,testData)
remove(trainData,testData)

#Step 2 Extracting The Required Data, (i.e The Subject, Activity, and columns denoting mean and standard deviation)
dataNames <- names(TotalData)
selectionColumnsX <- dataNames[grep("mean[^a-zA-Z]|std",dataNames)]
ColumnsToSelect <- append(selectionColumnsX,c('Subject','Activity'))
DataSelected <- TotalData %>% select(ColumnsToSelect)
remove(TotalData,dataNames,selectionColumnsX)

#Step 3 Activity Names
ActivityData <- read.table("activity_labels.txt")
by <- join_by( Activity == V1)
ActivityUpdatedData <- inner_join(DataSelected,ActivityData,by)
ActivityUpdatedData$Activity <- NULL
colnames(ActivityUpdatedData)[68] <- 'Activity'
remove(ActivityData,DataSelected,by)

#Step 4 Labeling the Columns
newColumnNames <- ColumnsToSelect %>% 
                    gsub("\\.\\.\\.","_",.) %>%
                      gsub("\\.\\.","",.) %>%
                        gsub("\\.","_",.) %>%
                          gsub("^t","Time_",.) %>%
                            gsub("^f","Frequency_",.) %>%
                              gsub("BodyBody","Body",.) %>%
                                gsub("Body","Body_",.) %>%
                                  gsub("Gravity","Gravity_",.)
colnames(ActivityUpdatedData) <- newColumnNames
remove(ColumnsToSelect)

#Step 5 Applying average for each column separated by activity and subject
GroupTable <- ActivityUpdatedData %>% 
                group_by(Subject,Activity) %>%
                  summarise_all(mean)