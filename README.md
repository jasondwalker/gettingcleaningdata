# coursera-getting-cleaning-data
This repo contains the files for the course project.
This project requires that we create a single coherent dataset from a number of files (step 1), return only the data concerning mean and standard deviation (step 2) and to appropriately name the activities and the variables (steps 3 and 4). Step 5 involves summarizing this dataset. For ease of marking I've highlighted the steps of the question in bold below.

##Requirements
	-The R code requires dplyr and tidyr to be installed. If not, you will need to use the install.packages command to do so.
	-The file run_analysis.R requires that the uncompressed folder "UCI HAR Dataset" be in the working directory for R, wherever that may be. If in doubt run getwd() and place the "UCI HAR Dataset" folder in the directory identified.
	-The code generates two files into your working directory, called UCIHARtidy1.txt and UCIHARtidy2.txt - the first is the tidy data, the second is the means by activity and subject. These files are large enough that notepad struggles with them (at least on *my* machine) so you might want to use something like notepad++ to open them.

##Running the script
With run_analysis.R in your working directory, open R and run source("run_analysis.R")

The R script itself is called by run_analysis()

The R script will then:
	-read the file X_train.txt - this file contains the actual data, 561 variables, 7352 observations
	-read the file features.txt. The second column is used to name the variables in X-train.txt
	-a search is run in the features labels for all variables containing 'mean' or 'std', and this is used to subset the X_train dataset. This reduces it to 86 columns. __(STEP 2)__
	-read the file y_train.txt - this file describes the activity being undertaken, 7352 rows. Name this 'activity' and add as a column to X_train.
	-read the file subject_train.txt - this identifies the training subject (1 to 30). 7352 rows. Name this 'subject', and add as another column.
	-Create a dataset with descriptive activity labels and merges this with the main dataset. __(STEP 3)__ This dataframe (trainmean)now has 88 columns (data plus activity plus subject).

The script will then perform a similar series of steps on the files in the 'test' folder, to create a dataframe called merged2.

The script will ignore the data in the Inertial Signals folder. Since these data do not contain any information on means or standard deviations, none of these figures are needed in the final tidy dataset. Not including them cuts out unnecessary steps and makes the scripts run faster.

merged1 and merged2 are combined with rbind() to create merged3, which has 88 columns and 7352 + 2947 = 10299 rows. __(STEP 1).__ The variable names are tidied up to remove caps, commas, and spurious brackets. __(STEP 4)__ NB: Ihave not gone beyond this, as I believe that the variable strings are too long to change to full descriptive terms - e.g. changing acc to acceleration.
This is saved as UCIHARtidy1.txt

This is then grouped and summarized (means) and saved as UCIHARtidy2.txt

