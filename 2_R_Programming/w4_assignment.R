setwd("./rprog-data-ProgAssignment3-data")
#1
oocm <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(oocm)
str(oocm)
ncol(oocm)
nrow(oocm)
colnames(oocm)

#30-day mortality rates for heart attack
oocm[,11] ##strings?!
oocm[,11]<-as.numeric(oocm[,11])
hist(oocm[,11])

#best hospital in state
source("best.R")
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")

source("rankhospital.R")
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)

source("rankall.R")
head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)

##SUBMISSION
source("submitscript3.R")
submit()


