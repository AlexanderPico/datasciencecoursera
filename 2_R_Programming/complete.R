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