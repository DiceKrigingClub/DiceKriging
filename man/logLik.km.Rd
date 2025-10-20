\name{logLik}
%%\alias{logLik.km}
\alias{logLik}
\alias{logLik.km}
\alias{logLik,km-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ log-likelihood of a km object }
\description{
Returns the log-likelihood value of a km object.
}
\usage{
\S4method{logLik}{km}(object, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{ an object of class \code{km} containing the trend and covariance structures. }
   \item{...}{ no other argument for this method.}
}


\value{
The log likelihood value.
}


\references{

N.A.C. Cressie (1993), \emph{Statistics for spatial data}, Wiley series in probability and mathematical statistics.

D. Ginsbourger, D. Dupuy, A. Badea, O. Roustant, and L. Carraro (2009), A note on the choice and the estimation of kriging models for the analysis of deterministic computer experiments, \emph{Applied Stochastic Models for Business and Industry}, \bold{25} no. 2, 115-131.

R. Li and A. Sudjianto (2005), Analysis of Computer Experiments Using Penalized Likelihood in Gaussian Kriging Models, \emph{Technometrics}, \bold{47} no. 2, 111-120.

K.V. Mardia and R.J. Marshall (1984), Maximum likelihood estimation of models for residual covariance in spatial regression, \emph{Biometrika}, \bold{71}, 135-146.

J.D. Martin and T.W. Simpson (2005), Use of kriging models to approximate deterministic computer models, \emph{AIAA Journal}, \bold{43} no. 4, 853-863.

J.-S. Park and J. Baek (2001), Efficient computation of maximum likelihood estimators in a spatial linear model with power exponential covariogram, \emph{Computer Geosciences}, \bold{27} no. 1, 1-7.

C.E. Rasmussen and C.K.I. Williams (2006), \emph{Gaussian Processes for Machine Learning}, the MIT Press, \url{https://gaussianprocess.org/gpml/}

J. Sacks, W.J. Welch, T.J. Mitchell, and H.P. Wynn (1989), Design and analysis of computer experiments, \emph{Statistical Science}, \bold{4}, 409-435.

M.L. Stein (1999), \emph{Interpolation of spatial data, some theory for kriging}, Springer.

}


\author{ O. Roustant, D. Ginsbourger, Ecole des Mines de St-Etienne}

\seealso{ \code{\link{km}}, \code{\link{logLikFun}}}

\keyword{models}

