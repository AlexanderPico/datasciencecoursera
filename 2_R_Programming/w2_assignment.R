## WEEK 2 ASSIGNMENT

files<-list.files("specdata", full.names=T)
files
head(read.csv(files[5]))

pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    ## NOTE: Do not round the result!
    files<-list.files(directory,full.names=T)
    df<-do.call(rbind, lapply(files,read.csv))
    mean(df[df$ID %in% id,][,pollutant], na.rm=T)
}
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)


complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    files<-list.files(directory,full.names=T)
    df<-do.call(rbind, lapply(files,read.csv))
    nobs<-c()
    for(i in id){
        nobs<-c(nobs,sum(complete.cases(df[df$ID==i,]),na.rm=T))
    }
    data.frame(cbind(id,nobs))
}

complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)

corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    ## NOTE: Do not round the result!
    files<-list.files(directory,full.names=T)
    df<-do.call(rbind, lapply(files,read.csv))
    res<-c()
    for(i in 1:length(files)){
        nobs<-sum(complete.cases(df[df$ID==i,]),na.rm=T)
        if(nobs>=threshold){
            res<-c(res,cor(df[df$ID==i,]$sulfate,df[df$ID==i,]$nitrate, use="na.or.complete"))
        }
    }
    res
}

cr <- corr("specdata", 150)
head(cr)

##GRADING
source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript1.R")
