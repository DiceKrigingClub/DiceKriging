\name{leaveOneOutFun}
\alias{leaveOneOutFun}
\title{
Leave-one-out least square criterion of a km object
}
\description{
Returns the mean of the squared leave-one-out errors, computed with Dubrule's formula.
}
\usage{
leaveOneOutFun(param, model, envir = NULL)
}
\arguments{
  \item{param}{ a vector containing the optimization variables.}
  \item{model}{ an object of class \code{km}.}
  \item{envir}{ an optional environment specifying where to assign intermediate values for future gradient calculations. Default is NULL.}
}

\note{
At this stage, only the standard case has been implemented: no nugget effect, no observation noise.
}

\value{
The mean of the squared leave-one-out errors.
}

\references{

F. Bachoc (2013), Cross Validation and Maximum Likelihood estimations of hyper-parameters of Gaussian processes with model misspecification. \emph{Computational Statistics and Data Analysis}, \bold{66}, 55-69. 

O. Dubrule (1983), Cross validation of Kriging in a unique neighborhood. \emph{Mathematical Geology}, \bold{15}, 687-699.

}

\author{
O. Roustant, Ecole des Mines de St-Etienne
}

\seealso{
\code{\link{leaveOneOut.km}}, \code{\link{leaveOneOutGrad}}
}

\keyword{models}
\keyword{htest}
