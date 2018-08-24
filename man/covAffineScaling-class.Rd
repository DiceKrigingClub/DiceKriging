\name{covAffineScaling-class}
\Rdversion{1.1}
\docType{class}
\alias{covAffineScaling-class}
\alias{coef,covAffineScaling-method}
\alias{covMat1Mat2,covAffineScaling-method}
\alias{covMatrix,covAffineScaling-method}
\alias{covMatrixDerivative,covAffineScaling-method}
\alias{covParametersBounds,covAffineScaling-method}
\alias{covparam2vect,covAffineScaling-method}
\alias{vect2covparam,covAffineScaling-method}
\alias{covVector.dx,covAffineScaling-method}
\alias{inputnames,covAffineScaling-method}
%\alias{inputnames<-,covAffineScaling,character-method}
\alias{kernelname,covAffineScaling-method}
\alias{ninput,covAffineScaling-method}
\alias{nuggetflag,covAffineScaling-method}
\alias{nuggetvalue,covAffineScaling-method}
\alias{nuggetvalue<-,covAffineScaling,numeric-method}
\alias{show,covAffineScaling-method}
\alias{summary,covAffineScaling-method}

\title{Class "covAffineScaling" }
\description{ Composition of isotropic kernels with coordinatewise 
non-linear scaling obtained by integrating affine functions }

\section{Objects from the Class}{
In 1-dimension, the covariance kernels are parameterized as in (Rasmussen, Williams, 2006). Denote by \code{theta} the range parameter, \code{p} the exponent parameter (for power-exponential covariance), \code{s} the standard deviation, and \code{h=|x-y|}. Then we have \code{C(x,y) = s^2 * k(x,y)}, with:

\tabular{ll}{
Gauss \tab \code{ k(x,y) = exp(-1/2*(h/theta)^2) } \cr
Exponential \tab \code{ k(x,y) = exp(-h/theta) } \cr
Matern(3/2) \tab \code{ k(x,y) = (1+sqrt(3)*h/theta)*exp(-sqrt(3)*h/theta) } \cr
Matern(5/2) \tab \code{ k(x,y) = (1+sqrt(5)*h/theta+(1/3)*5*(h/theta)^2)} \cr 
\tab \code{          *exp(-sqrt(5)*h/theta)} \cr
Power-exponential \tab \code{ k(x,y) = exp(-(h/theta)^p) } \cr
}

Here, in every dimension, the corresponding one-dimensional stationary kernel \code{k(x,y)} is replaced by \code{k(f(x),f(y))}, where \code{f} is a continuous monotonic function indexed by 2 parameters (see the references for more detail). 

}

\section{Slots}{
  \describe{
	 \item{\code{d}:}{Object of class \code{"integer"}. The spatial dimension. }
    \item{\code{knots}:}{Object of class \code{"numeric"}. A vector specifying the position of the two knots, common to all dimensions.}
    \item{\code{eta}:}{Object of class \code{"matrix"}. A d*2 matrix of scaling coefficients, parametrizing the coordinatewise transformations in the d dimensions. }
	 \item{\code{name}:}{Object of class \code{"character"}. The covariance function name. To be chosen between \code{"gauss", "matern5_2", "matern3_2", "exp"}, and \code{"powexp"} }
	 \item{\code{paramset.n}:}{Object of class \code{"integer"}. 1 for covariance depending only on the ranges parameters, 2 for "powexp" which also depends on exponent parameters. }
	 \item{\code{var.names}:}{Object of class \code{"character"}. The variable names. }
	 \item{\code{sd2}:}{Object of class \code{"numeric"}. The variance of the stationary part of the process. }
	 \item{\code{known.covparam}:}{Object of class \code{"character"}. Internal use. One of: "None", "All". }
    \item{\code{nugget.flag}:}{Object of class \code{"logical"}. Is there a nugget effect? }
    \item{\code{nugget.estim}:}{Object of class \code{"logical"}. Is the nugget effect estimated or known? }
    \item{\code{nugget}:}{Object of class \code{"numeric"}. If there is a nugget effect, its value (homogeneous to a variance). }
    \item{\code{param.n}:}{Object of class \code{"integer"}. The total number of parameters. }
  }
}

\section{Extends}{
Class \code{"\linkS4class{covKernel}"}, directly.
}
\section{Methods}{
  \describe{
    \item{coef}{\code{signature(object = "covAffineScaling")}: ... }
    \item{covMat1Mat2}{\code{signature(object = "covAffineScaling")}: ... }
    \item{covMatrix}{\code{signature(object = "covAffineScaling")}: ... }
    \item{covMatrixDerivative}{\code{signature(object = "covAffineScaling")}: ... }
    \item{covParametersBounds}{\code{signature(object = "covAffineScaling")}: ... }
    \item{covparam2vect}{\code{signature(object = "covAffineScaling")}: ... }
    \item{vect2covparam}{\code{signature(object = "covAffineScaling")}: ... }
    \item{covVector.dx}{\code{signature(object = "covAffineScaling")}: ... }
    \item{inputnames}{\code{signature(x = "covAffineScaling")}: ... }
    \item{kernelname}{\code{signature(x = "covAffineScaling")}: ... }
    \item{ninput}{\code{signature(x = "covAffineScaling")}: ... }
    \item{nuggetflag}{\code{signature(x = "covAffineScaling")}: ... }
    \item{nuggetvalue}{\code{signature(x = "covAffineScaling")}: ... }
    \item{show}{\code{signature(object = "covAffineScaling")}: ... }
    \item{summary}{\code{signature(object = "covAffineScaling")}: ... }
	 }
}

\author{ O. Roustant, D. Ginsbourger}

\references{
	
N.A.C. Cressie (1993), \emph{Statistics for spatial data}, Wiley series in probability and mathematical statistics.

C.E. Rasmussen and C.K.I. Williams (2006), \emph{Gaussian Processes for Machine Learning}, the MIT Press, \url{http://www.GaussianProcess.org/gpml}

M.L. Stein (1999), \emph{Interpolation of spatial data, some theory for kriging}, Springer.

}


\seealso{
	\code{\linkS4class{km}}
	\code{\linkS4class{covTensorProduct}}
}


\examples{
showClass("covAffineScaling")
}
\keyword{classes}
