#Alexandra Lahtinen
#24.11.2018 Exercise set 4 Data wrangling task (5 points).
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





















