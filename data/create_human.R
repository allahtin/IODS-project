#Alexandra Lahtinen
#1.12.2018 Exercise set 5 Data wrangling task, continuation of the Ex 4 (5 points).
##############Exercise Set 4 done earlier##########################################
#Data is from here: http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt
#1&2. Reading the “Human development” (hd) and “Gender inequality” (gi) datas into R. 
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
#3. Exploring the datasets with R functions dim(), glimps() and summary().
dim(hd)#dataset hd has 195 rows and 8 columns
dim(gii)#dataset gii has 195 rows and 10 columns
glimpse(hd)
glimpse(gii)
summary(hd)
summary(gii)
#4.Renaming the columns in the datasets
colnames(hd)
names(hd)[1]<-"HDIRank"
names(hd)[3]<-"HDI"
names(hd)[4]<-"LE"
names(hd)[5]<-"EYEdu"
names(hd)[6]<-"MeanYedu"
names(hd)[4]<-"LE"
names(hd)[7]<-"GNI"
names(hd)[8]<-"GNIminusHDI"
#now another one
colnames(gii)
names(gii)[3]<-"GII"
names(gii)[7]<-"PopFemale"
names(gii)[8]<-"PopMale"
names(gii)[9]<-"LFPRFemale"
names(gii)[10]<-"LFPRMale"
#5. Create two new variables in gii with ratios.
gii$ratioedu<-gii$PopFemale/gii$PopMale
gii$ratiolabforce<-gii$LFPRFemale/gii$LFPRMale
#6.Joining the datasets by Country and saving it in data folder.
joined<-inner_join(hd, gii, by = "Country", type = "left", match = "all")
dim(joined)#The joined data has 195 observations and 19 variables. 
write.table(joined, file="C:/Users/ELITEBOOK/Documents/GitHub/IODS-project/data/human.txt")
#checking how it reads it
joined_data<-read.table("C:/Users/ELITEBOOK/Documents/GitHub/IODS-project/data/human.txt", header=T)

################Exercise set 5 starts###########################################
library(dplyr)
human<-read.table("human1.txt", header=T, sep =",")
dim(human)#data has 195 rows and 19 columns
glimpse(human)#this data is the combination of the “Human development” (hd) and “Gender inequality” (gi) datas from the United Nations Development Programme. It has info by country (195 countries) on key social demographic parameters. Some of the columns were renamed (see previous lines) and two were added with ratios.
#Task 1 Convert GNI variable into numeric. 
library(stringr)
str(human$GNI)
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric
#Task 2: keeping certain columns
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))
#Task 3: removing all rows with missing values
complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human<- filter(human, complete.cases(human))
#Task 4&5 altogether: modifying country name list, saving in a file and checking if it is OK
tail(human, 10)#checking what is at the end of file
last <- nrow(human) - 7#no need of the last 7 regions, as we need countries only
human<- human[1:last, ]# choose everything until the last 7 observations
rownames(human) <- human$Country# add countries as rownames
human<- select(human, -Country)
write.table(human, file="C:/Users/ELITEBOOK/Documents/GitHub/IODS-project/data/human.txt", row.names = T)
my_data<-read.table("C:/Users/ELITEBOOK/Documents/GitHub/IODS-project/data/human.txt", header=T)#Check is OK. Data has 155 rows and 8 observations. Rownames (countries) are saved.













