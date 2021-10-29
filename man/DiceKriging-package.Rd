\name{DiceKriging-package}
\alias{DiceKriging}
\docType{package}

\title{ Kriging Methods for Computer Experiments}

\description{
Estimation, validation and prediction of kriging models.
}

\details{
  \packageDESCRIPTION{DiceKriging}
}

\author{Olivier Roustant, David Ginsbourger, Yves Deville. Contributors: C. Chevalier, Y. Richet.

(maintainer: Olivier Roustant \email{roustant@insa-toulouse.fr})

}

\references{

F. Bachoc (2013), Cross Validation and Maximum Likelihood estimations of hyper-parameters of Gaussian processes with model misspecification. \emph{Computational Statistics and Data Analysis}, \bold{66}, 55-69. 

N.A.C. Cressie (1993), \emph{Statistics for spatial data}, Wiley series in probability and mathematical statistics.

O. Dubrule (1983), Cross validation of Kriging in a unique neighborhood. \emph{Mathematical Geology}, \bold{15}, 687-699.

D. Ginsbourger (2009), \emph{Multiples metamodeles pour l'approximation et l'optimisation
de fonctions numeriques multivariables}, Ph.D. thesis, Ecole Nationale Superieure des
Mines de Saint-Etienne, 2009.

D. Ginsbourger, D. Dupuy, A. Badea, O. Roustant, and L. Carraro (2009), A note on the choice and the estimation of kriging models for the analysis of deterministic computer experiments, \emph{Applied Stochastic Models for Business and Industry}, \bold{25} no. 2, 115-131.

A.G. Journel and C.J. Huijbregts (1978), \emph{Mining Geostatistics}, Academic Press, London.

A.G. Journel and M.E. Rossi (1989), When do we need a trend model in kriging ?, \emph{Mathematical Geology}, \bold{21} no. 7, 715-739.

D.G. Krige (1951), A statistical approach to some basic mine valuation problems on the witwatersrand, \emph{J. of the Chem., Metal. and Mining Soc. of South Africa}, \bold{52} no. 6, 119-139.

R. Li and A. Sudjianto (2005), Analysis of Computer Experiments Using Penalized Likelihood in Gaussian Kriging Models, \emph{Technometrics}, \bold{47} no. 2, 111-120.

K.V. Mardia and R.J. Marshall (1984), Maximum likelihood estimation of models for residual covariance in spatial regression, \emph{Biometrika}, \bold{71}, 135-146.

J.D. Martin and T.W. Simpson (2005), Use of kriging models to approximate deterministic computer models, \emph{AIAA Journal}, \bold{43} no. 4, 853-863.

G. Matheron (1963), Principles of geostatistics, \emph{Economic Geology}, \bold{58},
1246-1266.

G. Matheron (1969), Le krigeage universel, \emph{Les Cahiers du Centre de Morphologie Mathematique de Fontainebleau}, \bold{1}.

W.R. Mebane, Jr., J.S. Sekhon (2011). Genetic Optimization Using Derivatives: The rgenoud Package for R. \emph{Journal of Statistical Software}, \bold{42}(11), 1-26. \doi{https://doi.org/10.18637/jss.v042.i11}

J.-S. Park and J. Baek (2001), Efficient computation of maximum likelihood estimators in a spatial linear model with power exponential covariogram, \emph{Computer Geosciences}, \bold{27} no. 1, 1-7.

C.E. Rasmussen and C.K.I. Williams (2006), \emph{Gaussian Processes for Machine Learning}, the MIT Press, \url{http://www.gaussianprocess.org/gpml/}

B.D. Ripley (1987), \emph{Stochastic Simulation}, Wiley.

O. Roustant, D. Ginsbourger and Yves Deville (2012), DiceKriging, DiceOptim: Two R Packages for the Analysis of Computer Experiments by Kriging-Based Metamodeling and Optimization, \emph{Journal of Statistical Software}, \bold{51}(1), 1-55, \doi{https://doi.org/10.18637/jss.v051.i01}.

J. Sacks, W.J. Welch, T.J. Mitchell, and H.P. Wynn (1989), Design and analysis of computer experiments, \emph{Statistical Science}, \bold{4}, 409-435.

M. Schonlau (1997), \emph{Computer experiments and global optimization}, Ph.D. thesis, University of Waterloo.

M.L. Stein (1999), \emph{Interpolation of spatial data, some theory for kriging}, Springer.

Y. Xiong, W. Chen, D. Apley, and X. Ding (2007), \emph{Int. J. Numer. Meth. Engng}, A non-stationary covariance-based Kriging method for metamodelling in engineering design.

}

\note{
A previous version of this package was conducted within the frame of the DICE (Deep Inside Computer Experiments) Consortium between ARMINES, Renault, EDF, IRSN, ONERA and TOTAL S.A. (http://dice.emse.fr/).

The authors wish to thank Laurent Carraro, Delphine Dupuy and Celine Helbert for fruitful discussions about the structure of the code, and Francois Bachoc for his participation in validation and estimation by leave-one-out. They also thank Gregory Six and Gilles Pujol for their advices on practical implementation issues, as well as the DICE members for useful feedbacks.

Package \code{rgenoud} >= 5.8-2.0 is recommended.

Important functions or methods:
\tabular{ll}{
\code{km} \tab Estimation (or definition) of a kriging model with unknown (known) parameters \cr
\code{predict} \tab Prediction of the objective function at new points using a kriging model (Simple and \cr 
\tab Universal Kriging) \cr
\code{plot} \tab Plot diagnostic for a kriging model (leave-one-out) \cr
\code{simulate} \tab Simulation of kriging models \cr
}

}

\keyword{package}
