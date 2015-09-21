best<-function(state,outcome){
    ##Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ##Check that state and outcome are valid
    if(!state %in% data[,7]){
        stop("invalid state")
    }
    validOutcomes<-c("heart attack","heart failure","pneumonia")
    outcomeCheck<-match(outcome, validOutcomes, nomatch=0)
    outcomeIndex = 0
    if(outcomeCheck==0){
        stop("invalid outcome")
    }
    if(outcomeCheck==1){outcomeIndex = 11} #heart attack column
    else if(outcomeCheck==2){outcomeIndex = 17} #heart failure column
    else if(outcomeCheck==3){outcomeIndex = 23} #pneumonia column
    
    ##Return hospital name in state with lowest 30-day death]
    stateData = data[data[,7]==state,] #subset by given state 
    stateData[,outcomeIndex]<-suppressWarnings(as.numeric(stateData[,outcomeIndex])) #strings to numbers
    stateData[order(stateData[,outcomeIndex],stateData[,2])[1],2] #hospital name for min outcome
        
}