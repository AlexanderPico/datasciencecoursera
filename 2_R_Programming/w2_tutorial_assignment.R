## WEEK 2 TUTORIAL ASSIGNMENT

##download and unzip data
#dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
#download.file(dataset_url, "diet_data.zip")
#unzip("diet_data.zip", exdir = "diet_data")

list.files("diet_data")
files <-list.files("diet_data", full.names=T)
andy <- read.csv("diet_data/Andy.csv")
head(andy)
nrow(andy)
summary(andy)

start<-andy[1,"Weight"]
end<-andy[30,"Weight"]
diff<-end-start
diff

head(read.csv(files[3]))

d25<-andy[andy$D==25,]
d25


df<-data.frame()
for(i in 1:length(files)){
    df<-rbind(df,read.csv(files[i]))
}
str(df)
nrow(df)
colnames(df)
head(df)
tail(df)

median(df$Weight, na.rm=T)
df[df$Day==25,]$Weight

medianonday<-function(df,day){
    median(df[df$Day==day,]$Weight, na.rm=T)
}

medianonday(df,25)

medianondir<-function(dir,day){
    files<-list.files(dir,full.names=T)
    df<-data.frame()
    for(i in 1:length(files)){
        df<-rbind(df,read.csv(files[i]))
    }
    medianonday(df,day)
}

medianondir("diet_data", 25)
medianondir("diet_data", 1)
medianondir("diet_data", 30)


#better way to build data frames
medianondir2<-function(dir,day){
    files<-list.files(dir,full.names=T)
    df<-do.call(rbind, lapply(files, read.csv))
    medianonday(df,day)
}

medianondir2("diet_data", 25)
medianondir2("diet_data", 1)
medianondir2("diet_data", 30)
