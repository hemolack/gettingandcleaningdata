# run_analysis.R

The basic steps taken by the script are:

1. Download the data set zip file
2. Uncompress data set to the current working directory -- the data should be in the "UCI HAR Dataset" subdirectory of the current working directory
3. Read in test data into the **test** data frame
4. Read in training data into the **train** data frame
5. Add a *Test* column that indicates if the observation is from the test data set (TRUE or FALSE)
6. Read in the activity labels from the activity_labels.txt file
7. Bind the activity labels to the two data frames (**test** and **train**)
8. Merge both data sets into one dataframe named **combined**
9. Read feature names from the features.txt file into a list named **features**
10. Add a new label to the **features** list for the *Test* and *Activity* columns
11. Set the column names for the combined data set from the **features** list
12. Subset the data to only columns containing the strings *mean* and *std* into a new data frame named **tidy_set**
13. Add in the *Test* and *Activity* columns from the **combined** data set to the **tidy_set**
14. Get the mean of each column in the **tidy_set** as grouped by *Test* and *Activity*
- Subset out the numeric data
- Subset out the factors
- Use the aggregate function to get the mean for each and store in a new dataframe named **agg**
15. Finally, write out the aggregated data set **agg**