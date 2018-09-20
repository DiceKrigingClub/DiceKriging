\name{covStruct.create}
\alias{covStruct.create}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Spatial covariance - Class constructor }

\description{  Creates a covariance structure.}

\usage{
covStruct.create(covtype, d, known.covparam, var.names, coef.cov = NULL, coef.var = NULL, 
     nugget = NULL, nugget.estim = FALSE, nugget.flag = FALSE,
     iso = FALSE, scaling = FALSE, knots=NULL, kernel=NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{covtype}{ a character string specifying the covariance structure.}
  \item{d}{ an integer containing the spatial dimension.}
  \item{known.covparam}{ a character ("None" or "All") indicating whether covariance parameters are known or must be estimated.}
  \item{var.names}{ a vector of character strings containing the variable names.}  
  \item{coef.cov}{ an optional vector containing the values for covariance parameters.}
  \item{coef.var}{ an optional number containing the variance value.}
  \item{nugget}{ an optional variance value standing for the homogenous nugget effect. Default is NULL.}
  \item{nugget.estim}{ is the nugget effect estimated or known?}
  \item{nugget.flag}{ is there a nugget effect?}
  \item{iso}{ an optional boolean that can be used to force a tensor-product covariance structure to have a range parameter common to all dimensions.}
  \item{scaling}{ an optional boolean indicating whether a scaling on the covariance structure should be used.}
  \item{knots}{ an optional list of knots (used if \code{scaling = TRUE})}
  \item{kernel}{ an optional function containing a new covariance structure}
}

\value{ A formal S4 class of type \code{\link{covTensorProduct-class}}, \code{\link{covIso-class}} (if \code{iso} is \code{TRUE}) (if \code{scaling} is \code{TRUE}),
or \code{\link{covUser-class}} (if \code{kernel} is \code{TRUE}).}

\author{ O. Roustant, D. Ginsbourger}

\seealso{ 
\code{\link{km}}
}

\keyword{models}
\keyword{internal}
