## WEEK 2 ##

#MySQL
install.packages("RMySQL")
library(RMySQL)

ucsc<-dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")
result<-dbGetQuery(ucsc,"show databases;")
dbDisconnect(ucsc)
result

hg19<-dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
tables<-dbListTables(hg19)
length(tables)
tables[1:5]

dbListFields(hg19,"affyU133Plus2")
dbGetQuery(hg19,"select count(*) from affyU133Plus2")

affyData<-dbReadTable(hg19,"affyU133Plus2")
head(affyData)

query<-dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis<-fetch(query)
quantile(affyMis$misMatches)

affySmall<-fetch(query,n=10)
dbClearResult(query)
dim(affySmall)

#HDF5
#hierarchical data format

#Webscraping
con<-url("http://scholar.google.com/citations?user=FUsTMX8AAAAJ&hl=en")
html<-readLines(con)
close(con)
html

library(httr) ##has authentication args
url<-"http://scholar.google.com/citations?user=FUsTMX8AAAAJ&hl=en"
html2<-GET(url)
text<-content(html2,as="text")
parsed<-htmlParse(text,asText=T)
xpathSApply(parsed,"//title",xmlValue)

#APIs
?oauth_app
?sign_oauth1.0
?GET
# demo: https://github.com/hadley/httr/blob/master/demo/oauth2-github.r

#Others
# try ?read.foo for any format of interest
# many other databases supported
# image formats can be read

##QUIZ
#1
install.packages("httpuv")
library(httpuv)
oauth_endpoints("github")
app<-oauth_app("github",key="8a830382a91eda928847",secret="d5c86a5f5b2755a61a6e6a35d91d7a59fc06afb0")
token<-oauth2.0_token(oauth_endpoints("github"),app)
gtoken <- config(token = token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
data<-content(req)

lapply(data,"[","url")
data[[7]]$created_at

#4
con<-url("http://biostat.jhsph.edu/~jleek/contact.html")
html<-readLines(con)
close(con)
nchar(html[[10]])
nchar(html[[20]])
nchar(html[[30]])
nchar(html[[100]])

#5
?read.fwf
f<-"https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(f, "noaa_data", method="curl")
data<-read.fwf("noaa_data",c(10,-5,4,4,-5,4,4,-5,4,4,-5,4,4),header=F,skip=4)
head(data)
sum(data[[4]])

