# WEEK 2 LECTURE
##control structures

# if(){}else{}
# for(i in 1:4){}
# for loop through matrix
x<-matrix(1:6,2,3)
for (i in seq_len(nrow(x))){
    for(j in seq_len(ncol(x))){
        print(x[i,j])
    }
}

# while(){}
# repeat -- forevs
# next -- skip rest of loop
# break -- skip out of loop

##writing functions
add2<-function(x,y){
    x+y
}
add2(5,6)

## returns numbers greater than n (default:10)
above<-function(x,n=10){
    use<-x>n
    x[use]
}
above(1:20,5)

## returns mean of columns in matrix m
columnmean<-function(m){
    nc<-ncol(m)
    means<-numeric(nc)
    for(i in 1:nc){
        means[i]<-mean(m[,i])
    }
    means
}

data<-read.csv("hw1_data.csv")
columnmean(data)

##extend a function
# use ... to include all args from original function
# or to allow any number of args, e.g., paste or cat functions
# or in generic functions
# NOTE: partial matching doesn't work with ... args

##lexical scoping in R
# variables are searched for in the environment in which the function was defined

##optimization functions in R relies on lexical scoping

##date and time
# Date class (since 1970-01-01)
x<-as.Date("1970-01-03")
x
unclass(x)

# POSIXlt -- list of values; useful!
x<-Sys.time()
x
plt<-as.POSIXlt(x)
unclass(plt)

# POSIXct -- large integer, number of seconds since 1970-01-01; not as useful
pct<-as.POSIXct(x)
pct
unclass(pct)

##make your own time -- cool!
?strptime
mytime<-c("Jan 10, 2012 16:50", "Mar 8, 2010 9:10")
t<-strptime(mytime, "%B %d, %Y %H:%M")
t

##test strptime with hw1 matrix Month and Day
colnames(data)
t0<-paste(c(data[1,"Month"],data[1,"Day"]),collapse="-")
t0
t1<-strptime(t0, "%m-%d")
t1

md2time<-function(m,d){
    t<-paste(c(m,d),collapse="-")
    strptime(t, "%m-%d")
}

for (i in 1:nrow(data)){
    print(md2time(data[i,"Month"],data[i,"Day"]))
}

data2<-within(data, {
    CalendarDate=md2time(data$Month,data$Day)
})

colnames(data2)
head(data2)
##fail

##QUIZ
#1
cube<-function(x,n){
    x^3
}
cube(3)

#2
f <- function(x) {
    g <- function(y) {
        y + z
    }
    z <- 4
    x + g(x)
}
z<-10
f(3)
