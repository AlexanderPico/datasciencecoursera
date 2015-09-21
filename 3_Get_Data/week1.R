## WEEK 1

# processed data is data that is ready for anlaysis

# ALL STEPS SHOULD BE RECORDED

#Tidy data
# should have:
# 1. raw data
# 2. tidy data set
# 3. code book describing each variable and its values
# 4. explicit recipe/protocol of steps to go from 1 to 2,3

#Code Book, i.e., metadata
# might include units, choices made and study design

#Instruction list
# A script to reproduce all processing

#Downloading data
?download.file() 
# method="curl" for Macs
#store date() in a variable which each data download

#Local data
?read.table()
?read.csv2()

#openxlsx
install.packages("openxlsx")
library("openxlsx")
?read.xlsx()
?write.xlsx()
# also check our XLConnect

install.packages("XML")
library("XML")
fileUrl<- "http://www.w3schools.com/xml/simple.xml"
doc<-xmlTreeParse(fileUrl,useInternal=T)
rootNode<-xmlRoot(doc)
rootNode
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
rootNode[[1]][[1]]

#xml functions
?xmlSApply()

#also see XPath language
names<-xpathSApply(rootNode, "//name",xmlValue)
prices<-xpathSApply(rootNode, "//price",xmlValue)

names
prices

length(names)

library("jsonlite")
jsonData<-fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login

#convert data.frames to pretty JSON!
myjson<-toJSON(iris, pretty=T)
cat(myjson)

#or convert back
iris2<-fromJSON(myjson)
summary(iris2)

#data.table, a more efficient data.frame 
# written in C
# faster grouping
# new syntax

install.packages("data.table")
library("data.table")
df<-data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(df,3)
#created the same way as a data.frame
dt<-data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(dt,3)

tables() #note: 's' at the end

dt[2,]
dt[dt$y=="a"]

#nifty function calling on columns
dt[,list(mean(x),sum(z))]

#adding a new column using equations and ":="
dt[,w:=z^2]
dt
#note: can also group "by=<logical variable>"

#set a key to make sorting fast and allow table JOINS
setkey(dt,y)
dt['c']

?fread()

##QUIZ
#1
f<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
download.file(f, "acs_data", method="curl")
?read.csv2
data<-read.csv2("acs_data",sep=",")
names(data)
nrow(data)
ncol(data)
sum(data$VAL==24, na.rm=T)

#3
f<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(f, "ngap_data", method="curl")
?read.xlsx
dat<-read.xlsx("ngap_data",rows=c(18:23), cols=c(7:15))
names(dat)
sum(dat$Zip*dat$Ext,na.rm=T)

#4
f<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(f,"balt_data",method="curl")
doc<-xmlTreeParse("balt_data",useInternal=T)
rootNode<-xmlRoot(doc)
rootNode
xmlName(rootNode)
names(rootNode)
rootNode[[1]][[1]]
names<-xpathSApply(rootNode, "//zipcode",xmlValue)
sum(names=="21231",na.rm=T)

#5
f<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(f,"acs2_data",method="curl")
?fread
dt<-fread("acs2_data")
dt[,mean(pwgtp15),by=SEX]
