### WEEK 3

##Subsetting review
# use which() with logical subsetting to deal with NAs
?which
# use order() with column subset to sort ROWS 
?order

#Sort
?sort

#Arrange
library(plyr)
?arrange

#Add rows and columns
# using subset as variable and assigning a vector

#cbind, rbind

##Summarizing data
restData<-read.csv("restaurants.csv")
head(restData)
tail(restData)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm=T)
table(restData$zipCode,useNA="ifany")
table(restData$councilDistrict,restData$zipCode)

sum(is.na(restData$council))
any(is.na(restData$council))
all(restData$zip>0)

colSums(is.na(restData))

table(restData$zip %in% c("21212","21213"))
restData[restData$zip %in% c("21212","21213"),]

#UCBAdmissions example
data(UCBAdmissions)
df<-as.data.frame(UCBAdmissions)
summary(df)

#cross tabs!
xt<-xtabs(Freq ~ Gender + Admit, data=df)
xt

object.size(df)
print(object.size(df),units="Kb")

##Creating new variables
?seq

#ifelse - make a binary variable
restData$zipWrong<-ifelse(restData$zip<0,T,F)
table(restData$zipW,restData$zipC<0)

##Cut - make a factor variable
?cut
install.packages("Hmisc")
library(Hmisc)
?cut2

?factor
restData$zipFactor=factor(restData$zipC)
restData$zipF

##Reshaping data
library(reshape2) 
head(mtcars)

#melting data frames
mtcars$carname=rownames(mtcars)
carMelt=melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))
head(carMelt)

#recasting
cylData=dcast(carMelt,cyl~variable)  #default: length
cylData
cylData=dcast(carMelt,cyl~variable,mean)  
cylData

#averaging
head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray,sum)

#plyr: ddply
?ddply

##dplyr - working with data.frames
?select
?filter
?arrange
?rename
?mutate
?summarise

##Merging data
?merge
# default is to merge based on common column names
# i.e,, intersect(names(df1),names(df2))

#merge a list of data frames in one step
?join_all

### QUIZ
#1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "acs_comm.csv", method="curl")
acs=read.csv("acs_comm.csv")
agLogic=acs$ACR==3&acs$AGS==6
which(agLogic)

#2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg","jeff.jpg",method="curl")
install.packages("jpeg")
library(jpeg)
?readJPEG
jeff=readJPEG("jeff.jpg",native=T)
?quantile
quantile(jeff,probs=c(0.30,0.80))

#3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv","fgdp.csv",method="curl")
?read.csv
fgdp=read.csv("fgdp.csv",skip=4,nrows=190)
head(fgdp,n=10)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv","fstats.csv",method="curl")
fstats=read.csv("fstats.csv")
head(fstats)
head(fgdp$X)
head(fstats$CountryCode)
fmerge=merge(fgdp,fstats,by.x="X",by.y="CountryCode")
head(fmerge)
head(fmerge$X)

head(fmerge$X.4)
fmerge[1,"X.4"]
gsub(",","",fmerge[1,"X.4"])
as.numeric(gsub(",","",fmerge[1,"X.4"]))

fmerge$gdpnum=as.numeric(gsub(",","",fmerge$X.4))
head(n=13,fmerge[order(fmerge$gdpnum,decreasing=F),1:6])
intersect(fgdp$X,fstats$CountryCode)

#4
names(fmerge)
?tapply
tapply(fmerge$X.1,fmerge$Income.Group,mean)

#5
?cut
?quantile
quantile(fmerge$X.1,c(0,.2,.4,.6,.8,1))
fcut=cut(fmerge$X.1,breaks=quantile(fmerge$X.1,c(0,.2,.4,.6,.8,1)))
fcut
table(fcut,fmerge$gdpnum)
table(fcut,fmerge$Income.Group)
