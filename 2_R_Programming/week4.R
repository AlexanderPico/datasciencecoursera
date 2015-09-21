## WEEK 4 NOTES

##str - structure of an R object; alt to summary
x<-rnorm(100,2,4)
summary(x)
str(x)

library(datasets)
str(airquality)

##simulation
#generating random numbers
rnorm(10,5,1)

#e.g., dnorm,pnorm,rpois

#d - density
#r - random number gen
#p - cumulative distribution
#q - quantile function

#set.seed(#)

##normal linear model
set.seed(20)
x<rnorm(100)
e<-rnorm(100,0,2)
y<-0.5+2*x+e
plot(x,y)

##binomial, linear model
set.seed(20)
x<-rbinom(100,1,0.5)
e<-rnorm(100,0,2)
y<-0.5+2*x+e
plot(x,y)

##poisson, linear model
set.seed(1)
x<-rnorm(100)
log.mu<-0.5+0.3*x
y<-rpois(100,exp(log.mu))
plot(x,y)

##random sampling
set.seed(1)
sample(1:10,4)
sample(1:10,4)
sample(letters,5)
sample(1:10) #permutation
sample(1:10,replace=T) #permutation with replace

##profiling to optimize code
system.time(ls)

#Rprof() ## DO NOT USE TOGETHER WITH system.time()
#summaryRprof() tabulates Rprof output

## examples from http://www.stat.berkeley.edu/~nolan/stat133/Fall05/lectures/profilingEx.html
funLoop = function(x) {
    # Initialize res with x
    res = x
    n = nrow(x)
    k = 1
    
    for (i in 1:n) {
        if (!any(is.na(x[i,]))) {
            res[k, ] = x[i,]
            k = k + 1
        }
    }
    res[1:(k-1), ]
}

funOmit = function(x) {
    # The or operation is very fast, it is replacing the any function
    # Also note that it doesn't require having another data frame as big as x
    
    drop = F
    n = ncol(x)
    for (i in 1:n)
        drop = drop | is.na(x[, i])
    x[!drop, ]
}


#Make up large test case
xx = matrix(rnorm(2000000),100000,20)
xx[xx>2] = NA
x = as.data.frame(xx)

system.time(funLoop(xx))
Rprof("exampleLoop.out")
y = funLoop(xx)
Rprof(NULL)
summaryRprof("exampleLoop.out")

system.time(funOmit(xx))
Rprof("exampleOmit.out")
y = funOmit(xx)
Rprof(NULL)
summaryRprof("exampleOmit.out")

## QUIZ
#1
set.seed(1)
rpois(5, 2)

#5
set.seed(10)
x <- rep(0:1, each = 5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e
plot(x,y)

#9
?system.time
?proc.time
