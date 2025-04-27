This is the Final Assignment Submission for the Coursera Data Cleaning Course.
The Given Problem is to Clean the Given Data by performing Certain Steps.

Raw Data is available at https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones

Required Steps for Cleaning The data:
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Performance of the Steps
  1. I have merged the Subject, X Data and Activities(Y Data) into a Single table for both Training Set and Test Set before Combining them into a single data table, this ensures that the data remains related and the information regarding the subject and the performed activity is not lost.
  2. I have only selected columns with mean() and std() apart from the subject and activity columns. This ensures that only the Mean values and Standard Deviation values remain as requested.
  3. Activity file was used to cross reference the integer provided in the data for the activity column and replace it with their pre specified text. I have not further modified the values for activity as I believe that the specified activity values are already descriptive.
  4. The Column names were changed by removing "." and replacing them with "_" for better legibility. Duplicate Characters such as "bodybody" were removed and replaced with "body". Expanded Column Names with "Time_" or "Frequency_" instead of just "f" or "t" to be more clear about the variable.
  5. the mean function was used in the summarize_all method in conjuction with group_by function to group the data with the subject and activity and applying  the mean(average) to all the columns.
