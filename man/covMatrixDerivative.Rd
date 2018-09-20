\name{covMatrixDerivative}
\alias{covMatrixDerivative}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Covariance matrix derivatives }
\description{
  Computes a partial derivative of the covariance matrix \code{C} in function \code{\link{covMatrix}}.
}

\usage{
covMatrixDerivative(object, X, C0, k, ...)
}

%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{an object specifying the covariance structure. }
  \item{X}{a matrix whose columns represent locations. }
  \item{C0}{a matrix corresponding to the covariance matrix for the locations specified in the X argument, when there is no nugget effet nor observation noise. }
  \item{k}{an integer representing the partial derivative index. }
  \item{\dots}{additional parameters, typically an environment used for storage}
}

\value{
  A matrix representing the partial derivative of \code{C}
}

\author{ Olivier Roustant, David Ginsbourger, Ecole des Mines de St-Etienne. }

\seealso{  \code{\link{covMatrix}} }

\keyword{models}
\keyword{htest}
\keyword{internal}
