\name{leaveOneOut.km}
\alias{leaveOneOut.km}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Leave-one-out for a km object }
\description{
  Cross validation by leave-one-out for a \code{km} object without noisy observations.
}
\usage{
leaveOneOut.km(model, type, trend.reestim=FALSE) %, fast=TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{model}{ an object of class "km" without noisy observations.}
%  \item{folds}{ a list of index subsets without index redundancy within each fold.}
  \item{type}{ a character string corresponding to the kriging family, to be chosen between simple kriging ("SK"), or universal kriging ("UK").}
  \item{trend.reestim}{ should the trend be reestimated when removing an observation? Default to FALSE.}
%  \item{fast}{ binary option to use analytical }
}

\details{
  Leave-one-out (LOO) consists of computing the prediction at a design point when the corresponding observation is removed from the learning set (and this, for all design points). A quick version of LOO based on Dubrule formula is also implemented; It is limited to 2 cases: \code{type=="SK" & (!trend.reestim)} and \code{type=="UK" & trend.reestim}. Leave-one-out is not implemented yet for noisy observations.}
  
\section{Warning}{
 Kriging parameters are not re-estimated when removing one observation. With few points, the re-estimated values can be far from those obtained with the entire learning set. One option is to reestimate the trend coefficients, by setting \code{trend.reestim=TRUE}.
}

\value{ A list composed of
  \item{mean }{ a vector of length \emph{n}. The ith coordinate is equal to the kriging mean (including the trend) at the ith observation number when removing it from the learning set, }
  \item{sd }{ a vector of length \emph{n}. The ith coordinate is equal to the kriging standard deviation at the ith observation number when removing it from the learning set,}
where \emph{n} is the total number of observations.
}

\references{ 

F. Bachoc (2013), Cross Validation and Maximum Likelihood estimations of hyper-parameters of Gaussian processes with model misspecification. \emph{Computational Statistics and Data Analysis}, \bold{66}, 55-69. \url{http://www.lpma.math.upmc.fr/pageperso/bachoc/publications.html}

N.A.C. Cressie (1993), \emph{Statistics for spatial data}, Wiley series in probability and mathematical statistics.

O. Dubrule (1983), Cross validation of Kriging in a unique neighborhood. \emph{Mathematical Geology}, \bold{15}, 687-699.

J.D. Martin and T.W. Simpson (2005), Use of kriging models to approximate deterministic computer models, \emph{AIAA Journal}, \bold{43} no. 4, 853-863.

M. Schonlau (1997), \emph{Computer experiments and global optimization}, Ph.D. thesis, University of Waterloo.	
	
}

\author{ O. Roustant, D. Ginsbourger, Ecole des Mines de St-Etienne. }

\seealso{ \code{\link{predict,km-method}},  \code{\link{plot,km-method}},
\code{\link{cv}}}

\keyword{models}

