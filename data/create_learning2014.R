#Alexandra Lahtinen
# November 11, 2018
#Here is my Exercise set 2 R script for the data wrangling
my_data <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header=T, sep ="\t")#reading the file in R from the link
head(my_data)#shows first few rows and all columns of the data
dim(my_data)# 183 rows  60 columns
summary(my_data)#gives basic statistics for each column
str(my_data)# tells the types of variables used
colnames(my_data)#seeking needed columns
#making a new dataset with needed columns
my_data$d_sm<-my_data$D03+my_data$D11 + my_data$D19 + my_data$D27
my_data$d_ri<-my_data$D07 + my_data$D14 + my_data$D22 + my_data$D30
my_data$d_ue<-my_data$D06 + my_data$D15 + my_data$D23 + my_data$D31
my_data$deep<-my_data$d_sm+my_data$d_ri+my_data$d_ue
my_data$su_lp<-my_data$SU02 + my_data$SU10 + my_data$SU18 + my_data$SU26
my_data$su_um<- my_data$SU05 + my_data$SU13 + my_data$SU21 + my_data$SU29
my_data$su_sb<-my_data$SU08 + my_data$SU16 + my_data$SU24 + my_data$SU32
my_data$Surf<-my_data$su_lp+my_data$su_um+my_data$su_sb
my_data$st_os<-my_data$ST01 + my_data$ST09 + my_data$ST17 + my_data$ST25
my_data$st_tm<-my_data$ST04 + my_data$ST12 + my_data$ST20 + my_data$ST28
my_data$Stra<-my_data$st_os+my_data$st_tm
colnames(my_data)
new_data<-my_data[, c(60, 57,58,64,71,68,59)]#new data set is done!
#scaling variables deep, surf, stra by R function scale
new_data_scaled<-as.data.frame(scale(new_data[ ,4:6]))#scaling 3 columns only
comb_data<-cbind( new_data,new_data_scaled)#combining with the previous dataset
final_data<-comb_data[, -c(4:6)]#taking out extra
final_data[-row(final_data)[final_data == 0],]#replacing all zeroes as NAs
super_final_data<-na.omit(final_data)#removing rows that have NAs
###final part with writing a file
setwd("~/GitHub/IODS-project")#setting directory as requested
write.table(super_final_data, file="~/GitHub/IODS-project/data/learning2014.txt", row.names = F, col.names= T, sep="\t")#writing a file into the data
again_my_data <- read.table("data/learning2014.txt", header=T, sep ="\t")#checking if reading is correct
head(again_my_data)#reads correctly, same file with same dimensions
str(again_my_data)#structure is preserved



