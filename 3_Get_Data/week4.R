## WEEK 4 ##

## QUIZ ##
#1
f="ss06hid.csv"
df=read.csv(f)
head(df)
?strsplit
colnames(df)[123]
strsplit(colnames(df)[123],"wgtp")

#2
f="GDP.csv"
df=read.csv(f,skip=4,nrows=190)
head(df,n=10)
df$gdpnum = as.numeric(gsub(",","",df$X.4))
mean(df$gdpnum)

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

#4
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
head(sampleTimes)
grep("2012",sampleTimes)
grep("2012",sampleTimes)