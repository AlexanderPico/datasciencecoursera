# WEEK3 ASSIGNMENT

makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}

cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}
cachemean(makeVector(c(1,2,3,4,5)))

x<-1:5  #create a vector
m<-makeVector(x)   #create list of functions for this vector
cachemean(m)
cachemean(m)
m$set(1:9)
cachemean(m)

## Takes an invertable matrix
## Returns a list of functions that:
##      set the value of the matrix and resets cache to NULL
##      get the value of the matrix
##      set the value of the inverted matrix
##      get the value of the inverted matrix
makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setsolve <- function(solve) m <<- solve
    getsolve <- function() m
    return(list(set = set, get = get,
         setsolve = setsolve,
         getsolve = getsolve))
}

## Takes a matrix processed by makeCacheMatrix()
## Returns the cached value of the inverted matrix,
##  if available; otherwise, it solves the inversion,
##  caches the value, and returns the value.
cacheSolve <- function(x, ...) {
    m <- x$getsolve()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setsolve(m)
    return(m)
}
x<-matrix(rnorm(1000000), nrow = 1000) #create huge invertable matrix
m<-makeCacheMatrix(x) #create function list for this matrix
system.time(cacheSolve(m))  #time first run of cacheSolve
system.time(cacheSolve(m))  #time second run of cacheSolve (should use cache!)
m$set(x) #reset matrix (with any matrix, even the same one...)
system.time(cacheSolve(m))  #time third run of cacheSolve (should NOT use cache!)
