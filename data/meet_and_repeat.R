#Alexandra Lahtinen
#Exercise Set 6.Datasets BPRS and RATS.
###Task 1. Reading and exploring the two datasets
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep = "", header =T)
rats<-read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = "", header =T)
dim(BPRS)
str(BPRS)
summary(BPRS)
dim(rats)
str(rats)
summary(rats)
names(BPRS)
colnames(rats)
###Task 2. Converting categorical variables to the factor ones.
str(BPRS)# treatment and subject are categorical in BPRS
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
str(BPRS)
str(rats)#ID and Group are categorical in rats
rats$ID <- factor(rats$ID)
rats$Group <- factor(rats$Group)
str(rats)
###Task 3. Converting datasets to a long form.Adding variables to the datasets.
library(dplyr)
library(tidyr)
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
glimpse(BPRSL)
ratsL <-  rats %>% gather(key =WD, value = rats, -ID, -Group)
ratsL <-  ratsL %>% mutate(Time = as.integer(substr(WD,3,4)))
glimpse(ratsL)
###Task 4. checking both datasets - long and short form.
dim(BPRS)# this is a wide format that has 9 weeks (week 0 to week 8) follow up for 20 subjects that are taking treatment 1 against 20 subjects taking treatment 2. 
str(BPRS)# data is numerical apart from two categorical variables (treatment and subject).
names(BPRS)#wide format has all weeks listed as columns and also two columns for subjects and treatment 1 or 2
dim(BPRSL)# The long format of BPRS has 360 rows and 5 columns.
str(BPRSL)#Here we have bprs andd week as numeric and subject and treatment as factors.
names(BPRSL)#The long format reorganises the data in a way by weeks "down" which is an easy format to analyze by ANOVA, for example. SO we no longer deal with different columns, as in a wide format, but we can analyze data in a loop from top to down. Subjects are organized from 1 to 20 down for week 0, treatment 1, then for same week treatment 2, then again same for week 1, treatment 1 and treatment 2 and so on.
#Now we check rats
dim(rats)# wide format had 16 rows and 13 columns.rows correspond to 3 different groups of rats. GRoup 1 is the largest and has 8 rats, group 2 has 4, group 3 has 4. In columns we have measurements eprformed in different time points, all together 11 measurements.
str(rats)# Data are numeric, apart from group and ID expressed as factors.
names(rats)#Here is WDX where X is a different time point. Now we go to a long format to see how it looks like.
dim(ratsL)#176 rows and 5 columns now. Let's see what are the column names now and what types of variables we have there now.
names(ratsL)# Long format has now IDs of rats, theer Group belongings, WDX as it was in the wide format going now long way down and actual X in column Time a number, so we could analyze this data in a longitudinal way.Data is again reorganized in such way that we have each rat going with a measurement at Time point 1, then all at Time Point 2 etc. 
str(ratsL)#as it should be: factors for ID and Group, integer for the measurements and TIme points and chr for the WDX which now does not matter anymore for further analyses. I think I understood the point between wide and long formats!





