
##===============================================================
## 'scalingFun1d' computes the 'scaling' transformation at
## the one-dimensional design points x.
##
## The knots and (positive) derivatives definitng the transfo-
## -mation are given in numeric vectors 'knots' and 'eta'.
##
##===============================================================

#' @example plot(function(x)scalingFun1d(x,c(0,1),c(.5,.5)))
#' @example plot(function(x)scalingFun1d(x,c(0,1),c(.5,.75)))
#' @example plot(function(x)scalingFun1d(x,0,.5))
#' @example plot(function(x)scalingFun1d(x,c(0,1),c(.5,.75)),xlim=c(-1,2))
#' @example plot(function(x)scalingFun1d(x,c(0,1.5),c(.5,1.75)),xlim=c(-1,2))
#' @example plot(function(x)scalingFun1d(x,c(0,.5,1),c(10.5,.5,1.75)),xlim=c(-1,2))
scalingFun1d <- function(x, knots, eta){
    
    if (is.null(x) || length(x)==0) return(NULL)

    n <- length(x)
    nKnots <- length(knots)
  
    #if ( any(x < knots[1]-1E-6) | any(x > knots[nKnots]+1E-6) )
    #    warning("'x' values should be inside the knots (otherwise using closest knot)\nknots =",paste(knots,collapse=","),"\nx = ",paste(x,collapse=","))

    ix_upper <- which(x > knots[nKnots])
    ix_lower <- which(x < knots[1])
    if (length(ix_lower) > 0 & length(ix_upper) > 0)
        ix_inside <- (1:n)[-c(ix_upper, ix_lower)]
    else if (length(ix_lower) > 0 & length(ix_upper) == 0)
        ix_inside <- (1:n)[-ix_lower]
    else if (length(ix_upper) > 0 & length(ix_lower) == 0)
        ix_inside <- (1:n)[-ix_upper]
    else ix_inside <- 1:n

    newscale_inside <- scalingFun1d.inside(x[ix_inside], knots, eta)

    newscale <- rep(NA, n)
    newscale[ix_inside] <- newscale_inside

    ## Support for outside knots
    if(length(ix_lower) > 0) newscale[ix_lower] <- eta[1]*(x[ix_lower] - knots[1])

    if(length(ix_upper) > 0) {
        y0 <- scalingFun1d.inside(knots[nKnots], knots, eta)
        newscale[ix_upper] <- eta[nKnots] * (x[ix_upper] - knots[nKnots]) + y0
    }

    return(newscale)
}


#' Do NOT support when x is outside bounds of knots...
#' @perf x=runif(100); k=seq(0,1,,10);e=runif(10); scalingFun1d.inside.faster(x,k,e)
#' @perf Rprof("scaling.prof", line.profiling=TRUE); x=runif(100); k=seq(0,1,,10);e=runif(10); for(i in 1:10000) scalingFun1d.inside(x,k,e); Rprof(NULL); summaryRprof("scaling.prof", lines = "show")
scalingFun1d.inside <- function(x, knots, eta){

    if (is.null(x) || length(x)==0) return(NULL)

    n <- length(x)
    nKnots <- length(knots)

    if (nKnots == 1) return(eta * (x-knots))
    if (any(x < knots[1]) | any(x > knots[nKnots]))
        stop("'x' values should be inside the knots (otherwise using closest knot)\nknots =",
             paste(knots,collapse=","), "\nx = ", paste(x,collapse=","))
  
  if (length(x) > 1) {
    xs <- sort(x, index.return = TRUE)
    xsorted <- xs$x
    ind <- xs$ix
  } else {
    xsorted <- x
    ind <- 1
  }
  
  scale <- rep(0, n)
  
  res <- .C(Scale,
            n = as.integer(n),
            nKnots = as.integer(nKnots),
            x = as.double(xsorted), 
            knots = as.double(knots),
            eta = as.double(eta),
            scale = as.double(scale))
  
  ## CAUTION here: the values are for SORTED x values
  ## they must be put back in the original order.
  newscale <- rep(NA, n)
  newscale[ind] <- res$scale
  
  return(newscale)    
  
}

##==================================================================
## 'scalingFun' applies d one-dimensional 'scaling' transformations
## to n d-dimensional design points
##
## o 'X' must be a n*d matrix,
##
## o 'knots' and 'eta' are list of lentgh d. In both cases,
##    the element i contains the knots/derivatives for the
##    dimension i  
##
## At this time, no control on the list/matrix dimension or length
## 
##==================================================================

scalingFun <- function(X, knots, eta, plot = FALSE) {
 
  d <- NCOL(X)

  transX <- matrix(NA, nrow = NROW(X), ncol = NCOL(X))
  dimnames(transX) <- dimnames(X)
  X <- as.matrix(X)
  
  for (i in 1:d){
        name.i <- i
        if (!is.null(colnames(X))) name.i <- colnames(X)[i]
        transX[ , i] <- scalingFun1d(x = X[ , i], knots = knots[[name.i]], eta = eta[[name.i]])
  }

  if (plot) {
    for(i in 1:d) {
      plot(X[ ,i], transX[ ,i], type = "o",
           pch = 21, col = "orangered", cex = 0.8,
           xlab = "x", ylab = "x 'scaled'")
      abline(v = knots[[i]], col = "SpringGreen3")
    }

  }
  
  return(transX)
  
}


##===============================================================
## 'scalingFun1d.dx' is derivative wrt x of scalingFun1d
##===============================================================

#' @example plot(function(x)scalingFun1d.dx(x,c(0,1),c(.5,.5)))
#' @example plot(function(x)scalingFun1d.dx(x,c(0,1),c(.5,.75)))
#' @example plot(function(x)scalingFun1d.dx(x,0,.5))
#' @example plot(function(x)scalingFun1d.dx(x,c(0,1),c(.5,.75)),xlim=c(-1,2))
#' @example plot(function(x)scalingFun1d.dx(x,c(0,1.5),c(.5,1.75)),xlim=c(-1,2))
#' @example plot(function(x)scalingFun1d.dx(x,c(0,.5,1),c(10.5,.5,1.75)),xlim=c(-1,2))
scalingFun1d.dx <- function(x, knots, eta){

    if (is.null(x) || length(x)==0) return(NULL)

    n <- length(x)
    nKnots <- length(knots)

    #if ( any(x < knots[1]-1E-6) | any(x > knots[nKnots]+1E-6) )
    #    warning("'x' values should be inside the knots (otherwise using closest knot)\nknots =",paste(knots,collapse=","),"\nx = ",paste(x,collapse=","))

    ix_upper <- which(x > knots[nKnots])
    ix_lower <- which(x < knots[1])
    if (length(ix_lower) > 0 & length(ix_upper) > 0)
        ix_inside <- (1:n)[-c(ix_upper, ix_lower)]
    else if (length(ix_lower) > 0 & length(ix_upper) == 0)
        ix_inside <- (1:n)[-ix_lower]
    else if (length(ix_upper) > 0 & length(ix_lower) == 0)
        ix_inside <- (1:n)[-ix_upper]
    else ix_inside <- 1:n

    newscale_inside <- scalingFun1d.dx.inside(x[ix_inside], knots, eta)

    newscale <- rep(NA, n)
    newscale[ix_inside] <- newscale_inside

    ## Support for outside knots
    if(length(ix_lower) > 0) newscale[ix_lower] <- eta[1]

    if(length(ix_upper) > 0) newscale[ix_upper] <- eta[nKnots]

    return(newscale)
}


#' Do NOT support when x is outside bounds of knots...
#' @perf x=runif(100); k=seq(0,1,,10);e=runif(10); scalingFun1d.dx.inside(x,k,e)
#' @perf Rprof("scaling.prof", line.profiling=TRUE); x=runif(100); k=seq(0,1,,10);e=runif(10); for(i in 1:10000) scalingFun1d.dx.inside(x,k,e); Rprof(NULL); summaryRprof("scaling.prof", lines = "show")
scalingFun1d.dx.inside <- function(x, knots, eta){

    if (is.null(x) || length(x)==0) return(NULL)

    n <- length(x)
    nKnots <- length(knots)

    if (nKnots == 1) return(eta * (x-knots))

    if ( any(x < knots[1]) | any(x > knots[nKnots]) )
        stop("'x' values should be inside the knots (otherwise using closest knot)\nknots =",
             paste(knots,collapse=","), "\nx = ", paste(x,collapse=","))

    if (length(x) > 1) {
        xs <- sort(x, index.return = TRUE)
        xsorted <- xs$x
        ind <- xs$ix
    } else{
        xsorted <- x
        ind <- 1
    }

    scale_dx <- rep(0, n)

    res <- .C(Scale_dx,
              n = as.integer(n),
              nKnots = as.integer(nKnots),
              x = as.double(xsorted),
              knots = as.double(knots),
              eta = as.double(eta),
              scale_dx = as.double(scale_dx))

    ## CAUTION here: the values are for SORTED x values
    ## they must be put back in the original order.
    newscale <- rep(NA, n)
    newscale[ind] <- res$scale_dx

    return(newscale)

}

##==================================================================
## 'scalingFun.dx' is derivative wrt x of scalingFun
##==================================================================

scalingFun.dx <- function(X, knots, eta, plot = FALSE) {

    d <- NCOL(X)

    transX <- matrix(NA, nrow = NROW(X), ncol = NCOL(X))
    dimnames(transX) <- dimnames(X)
    X <- as.matrix(X)

    for (i in 1:d){
        name.i <- i
        if (!is.null(colnames(X))) name.i <- colnames(X)[i]
        transX[ , i] <- scalingFun1d.dx(x = X[ , i], knots = knots[[name.i]], eta = eta[[name.i]])
    }

    if (plot) {
        for(i in 1:d) {
            plot(X[ ,i], transX[ ,i], type = "o",
                 pch = 21, col = "orangered", cex = 0.8,
                 xlab = "x", ylab = "x 'scaled'")
            abline(v = knots[[i]], col = "SpringGreen3")
        }

    }

    return(transX)

}




