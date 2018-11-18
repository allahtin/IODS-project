#Alexandra Lahtinen
#17.11.2018
#IODS Exercise Set 3, data from https://archive.ics.uci.edu/ml/machine-learning-databases/00320/
#Task 1-3 Reading the data and exploring the variables and dimensions
mat_data<-read.csv("data/student-mat.csv", header=T, sep=";")
dim(mat_data)#has 395 rows, 33 columns
head(mat_data)#looks like a data on two high schools' students with gender,ages and other info on family
str(mat_data)#tells what variables are in columns: integer, factors etc
por_data<-read.csv("data/student-por.csv", header=T, sep=";")
dim(por_data)#has 649 rows, 33 columns
head(por_data)#more students, other variables measured
str(por_data)#tells what variables are in columns: integer, factors etc
#Task 4. Joining the two datasets using  "school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet" as (student) identifiers
library(dplyr)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(mat_data, por_data, by = join_by)
dim(math_por)#now has 382 rows and 53 columns
head(math_por)
alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(mat_data)[!colnames(mat_data) %in% join_by]
#Task 5. If Else structure
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}
###Task 6 &7 New columns in the dataset alc: alc_use and high_use. 
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)
##Task 8 Glimpsing the data and saving alc as csv
glimpse(alc)#all seems to be fine for the next task.
dim(alc)# as it should be: 382 rows and 35 columns
write.table(alc, "Joined student alcohol consumption data.txt")#writing it as txt file
#checking that read.table opens it correctly
joined_data<-read.table("Joined student alcohol consumption data.txt", header=T)



