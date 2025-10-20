\name{covVector.dx}
\alias{covVector.dx}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Spatial covariance - Derivatives}
\description{
  Computes the gradient of the covariance vector \code{c(x)} computed by \code{\link{covMat1Mat2}} with respect to \code{x}, for a given covariance structure.
}
\usage{
covVector.dx(object, x, X, c)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{an object specifying the covariance structure. }
  \item{x}{a vector representing the specific location. }
  \item{X}{a matrix whose columns represent locations. }
  \item{c}{a matrix containing the covariances between the location \code{x} and the set of locations specified in \code{X} (see \code{\link{covMat1Mat2}}). }
}

\value{
  A matrix of real numbers equal to the gradient of \code{c} as a function of \code{x}.
}

\author{ Olivier Roustant, David Ginsbourger, Ecole des Mines de St-Etienne. }

\seealso{  \code{\link{covMat1Mat2}} }

\keyword{models}
\keyword{optimize}
\keyword{internal}

