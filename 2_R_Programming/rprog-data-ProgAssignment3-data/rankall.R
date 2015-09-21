rankall <- function(outcome, num = "best") {
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ##Check that outcome is valid
    validOutcomes<-c("heart attack","heart failure","pneumonia")
    outcomeCheck<-match(outcome, validOutcomes, nomatch=0)
    outcomeIndex = 0
    if(outcomeCheck==0){
        stop("invalid outcome")
    }
    if(outcomeCheck==1){outcomeIndex = 11} #heart attack column
    else if(outcomeCheck==2){outcomeIndex = 17} #heart failure column
    else if(outcomeCheck==3){outcomeIndex = 23} #pneumonia column
    
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    stateVector<-vector()
    hospVector<-vector()
    data<-data[order(data[[7]]),] #order by state before for-loop
    
    for(state in unique(data[[7]])){
        stateData<-data[data[,7]==state,] #subset by given state 
        stateData[,outcomeIndex]<-suppressWarnings(as.numeric(stateData[,outcomeIndex])) #strings to numbers
        stateData<-stateData[complete.cases(stateData[,outcomeIndex]),] #remove rows with NA for given outcome
        
        #handle special cases of num
        n<-num
        if(num=="best"){n<-1}
        else if(num=="worst"){n<-nrow(stateData)} #only works AFTER removing NA rows
        hosp<-NA
        if(n<=nrow(stateData)){
            hosp<-stateData[order(stateData[,outcomeIndex],stateData[,2])[n],2] #hospital name for min outcome
        } 
        stateVector<-c(stateVector,state)
        hospVector<-c(hospVector,hosp)
    }

    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    df<-as.data.frame(cbind(hospVector,stateVector))
    colnames(df)<-c("hospital", "state")
    return(df)
}