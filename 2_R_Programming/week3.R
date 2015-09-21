## WEEK 3 NOTES

##lappy - list apply
# args: list, function, ... (for function args)
# always returns a list

##sapply - simplify apply
# args; list, function, ...
# returns a vector if results are same type, or
#  a matrix if results are vectors of same length, or
#  a list if results can't be simplified

x<-list(1:4,2:10,4:7,10:100)
lapply(x,mean)
sapply(x, mean)

##apply - applies to rows or cols; like a for loop
# args: n-dimensional array (e.g., matrix), margin, function, ...

m<-matrix(rnorm(200),20,10)
m
apply(m,2,mean) # mean of values per column; 2=keep second dim (cols)
apply(m,1,sum) # sum of values per row; 1-keep first dim (rows)

# but there are optimized functions for these already...
# rowSums, rowMeans, colSums, colMeans

# find the 25th and 75th percentile for each row
apply(m,1,quantile, probs=c(0.25,0.75))

##mapply - multivariate apply
# args: function, ... (list of list objects), MoreArgs=

mapply(rep, 1:4, 4:1)

noise<-function(n,mean,sd){
    rnorm(n,mean,sd)
}
noise(5,1,2)

noise(1:5,1:5,2) # not correct result
mapply(noise,1:5,1:5,2) # vectorized the function correctly!

##tapply - take function over subset of vector
# args: vector, factors, function, ..., simplify=T

x<-c(rnorm(10),runif(10),rnorm(10,1))
x
f<-gl(3,10)  # can also use df colnames as factors
f
tapply(x,f,mean)

##split - splits vector into subsets
# args: vector, factors, drop=F

split(x,f)

sapply(split(x,f),mean) # same as tapply, really

df<-read.csv("hw1_data.csv")
head(df)

s<-split(df,df$Month)
sapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind")], na.rm = T))
#or
tapply(df$Ozone, df$Month, mean, na.rm=T)
tapply(df$Solar.R, df$Month, mean, na.rm=T)
tapply(df$Wind, df$Month, mean, na.rm=T)

# splitting across two factors
s<-split(df, list(df$M,df$D),drop=T)
s[151]


##DEBUGGING
#invisible() ???

#traceback - prints function call stack; useful for error/bug reporting
lm(z-y)
traceback() # call after an error message

#recover - modify error behavior; an error handler
#options(error = recover) ## sets recover mode for session

#debug - step through one line at a time
debug(lm)
lm(z-y)

#browser - suspends and enters debug mode

#trace - insert debugging code into a function; handy for editing 3rd party code


##QUIZ: WEEK 3
library(datasets)
data(iris)
?iris
head(iris)
#1
s<-split(iris,iris$Species)
sapply(s,function(x) mean(x[,"Sepal.Length"], na.rm = T))
# or
s2<-split(iris$Sepal.Length,iris$Species)
sapply(s2,mean)
#or
tapply(iris$Sepal.Length,iris$Species,mean)

#2
apply(iris[, 1:4], 2, mean)

#3
library(datasets)
data(mtcars)
head(mtcars)
sapply(split(mtcars$mpg, mtcars$cyl), mean)

#4
hps<-sapply(split(mtcars$hp, mtcars$cyl), mean)
abs(hps[1]-hps[3])

