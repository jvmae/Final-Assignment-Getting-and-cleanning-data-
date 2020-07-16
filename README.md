# Final-Assignment-Getting-and-cleanning-data-
README.md in the repo describing how the script works

First line, assign "CourseraFinalAssignment.zip" to "filename"
Line 4-6, check if the file exists. Download the file into our pc
Line 10-11. if the file "CourseraFinalAssignment.zip" does not exist unzip the file into the folder.

Line 14-15, read the file into R and assign it a name. With "select" rename the columns. From line 16-34 we will follow the same pattern as in line 14-15, first to load the files into R data frames and to rename the variables.

Line 37-39, combining the data frames information, by row.

Line 40, combining information from line 37-39 into one data frame, by column.

Line 43, using "contain" to match the pattern of the mean and sd and using select to extract them and assign them to a new variable.

Line 46, introducing the labels from the activities file into our TidyData frame.

Line 47, rename the "code" label into "activity"

Line 50-55, use of regular expressions to rename the varibles name of the TidyData frame.

Line 58, group the TidyData frame by subject and activity.

Line 59, "summarise_all" to apply the function mean into our data frame and assign it to a new variable

Line 60, "write.table" prints "TidyData2" frame into a file.
