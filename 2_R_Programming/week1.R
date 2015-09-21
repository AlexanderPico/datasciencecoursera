# WEEK 1 LECTURE
#assignment operator
x<-1
print(x)
x

#integer sequence
x<-5:10
x

#data types
# vectors are common; must be of a single type
# lists can have mixed types
# Inf and NaN are special numbers; NA is for any data type that is missing

#attributes
# name, dimnames, dimensions, class, length, others...
 
#creating vectors
x<-c(T,F)
x
x<-vector("numeric",length=10)
x

#explicit coercion
x<-0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)
# failed coercion will produce NA

#lists
x<-list(1,"a",T,1+4i)
x
# note: double brackets that distinguish lists from plain vectors

#matrices
m<-matrix(nrow=2,ncol=3)
m
dim(m)
attributes(m)
m<-matrix(1:6,nrow=2,ncol=3)
m
# note: columns first, then rows

#set dim
m<-1:10
dim(m)<-c(2,5)
m

#cbind rbind
x<-1:3
y<-10:12
cbind(x,y)
rbind(x,y)

#factors
# for categorical data; self-descriptive; can be ordered
# treated specially by modeling functions, lm() and glm()
x<-factor(c("yes","yes","no","yes","no"))
x
table(x)
unclass(x)
# note: baseline level is picked alphabetically; can explicitly
#  set using levels()

#NA
is.na(x)
is.nan(x)

#data frames
# useful for tabular data; major data type
x<-data.frame(foo=1:4,bar=c(T,T,F,F))
x
nrow(x)
ncol(x)

#names
names(x)
names(x)<-c("foo2","bar2")
x
# lists and matrices can also have names
dimnames(m)<-list(c("r1","r2"),c("a","b","c","d","e"))
# note: row names first, col names second; which is opposite of 
#  default matrix filling... dumb!
m

#reading and writing data
?read.table #read.csv, read.delim
# note: for large tables, these args help with performance:
#  set comment.char = ""
#  set colClasses = classes
#  set nrows (slight overestimate is okay; use bash wc)
#  compare file size to RAM (e.g., 16GB); nrows*ncol*8/2^30 = GB; want twice RAM
#  e.g., 1.5M rows x 120 col = 1.34GB (my mac can handle ~6x that)

#dump/source and dput/dget
#  preserves metadata
y<-data.frame(a=1,b="ghj")
dput(y)
dput(y, file="dput_y.R")
new.y<-dget("dput_y.R")
new.y
y
# note: dump/source works same, but for lists of objects
?dump

#interfaces
?file #file, url, gzfile, bzfile
# con, readLines(con), close(con)
con<-url("http://nrnb.org", "r")
site<-readLines(con, 10)
site
close(con)

#subsetting vectors
# [ elements of same class
# [[ single elements from list and data.frame
# $ named elements
x<-c("a","b","c","d")
x[1] # numerical index
x[2:3]
x[x>"b"] #logical index
u<-x>"b"
u
x[u]

#subsetting lists
x<-list(foo=1:4,bar=c(10,11,12),baz="hello")
x[1] #list
x[[1]] #vector 
x["bar"] #list
x[["bar"]] #vector
x[c(2,3)] #multiple elements extracted; single bracket
x[[c(2,3)]] #nested element extracted; double bracket

#subsetting matrix
m<-matrix(1:6,2,3)
m
m[1,2] #row, then col
m[1,] #entire row as vector
m[,2] #entire col as  vector
m[1,,drop=F] #row as matrix; keep dimensions

#partial matching
x$f #matches "foo"
x[["f", exact=F]] #need false arg to allow double bracket partial matching

#removing NA values
x<-c(1,2,NA,4,NA,5)
bad<-is.na(x)
x[!bad] #subset non-bad elements

#complete.cases
y<-c("a","b",NA,"d",NA,"f")
good<-complete.cases(x,y)
good
x[good]
y[good]

#removing NA from a matrix
z<-cbind(x,y)
z
good<-complete.cases(z)
z[good,] #good rows
z[good,][1:3,] #first 3 good rows
z[good,][,2] #second col of good rows

#vectorized ops
x<-1:4
y<-6:9
x+y
x>y
x*y #element-wise multiplication
x%*%y #true matrix multiplication

##WEEK 1 QUIZ
#4
x<-4L
class(x)
#5
x<-c(4,T)
class(x)
x
#6
x<-c(1,3,5)
y<-c(3,2,10)
cbind(x,y)
#7
?vector()
#8
x <- list(2, "a", "b", T)
x[[2]]
class(x[[2]])
#9
x<-1:4
y<-2:3
x
y
x+y
class(x+y)
#10
x <- c(17, 14, 4, 5, 13, 12, 10) 
x[x >= 11] <- 4
x
#11
dat<-read.csv("hw1_data.csv")
names(d)
#12
d[1:2,]
#13
nrow(d)
#14
d[152:153,]
#15
d[47,"Ozone"]
#16
missing<-is.na(d[,"Ozone"])
length(d[missing,"Ozone"])
#17
summary(d[,"Ozone"])
#18
hiot<-d[d$O>31&d$T>90,]
summary(hiot$S)
#19
june<-d[d$M==6,]
summary(june$T)
#20
may<-d[d$M==5,]
summary(may$O)
