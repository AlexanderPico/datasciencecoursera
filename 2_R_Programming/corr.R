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
