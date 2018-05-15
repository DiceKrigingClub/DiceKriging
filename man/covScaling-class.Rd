\name{covScaling-class}
\Rdversion{1.1}
\docType{class}
\alias{covScaling-class}
\alias{coef,covScaling-method}
\alias{covMat1Mat2,covScaling-method}
\alias{covMatrix,covScaling-method}
\alias{covMatrixDerivative,covScaling-method}
\alias{covParametersBounds,covScaling-method}
\alias{covparam2vect,covScaling-method}
\alias{vect2covparam,covScaling-method}
\alias{covVector.dx,covScaling-method}
\alias{show,covScaling-method}
\alias{inputnames,covScaling-method}
\alias{kernelname,covScaling-method}
\alias{ninput,covScaling-method}
\alias{nuggetflag,covScaling-method}
\alias{nuggetvalue,covScaling-method}
\alias{nuggetvalue<-,covScaling,numeric-method}
\alias{summary,covScaling-method}

\title{Class "covScaling" }
\description{ Composition of isotropic kernels with coordinatewise 
non-linear scaling obtained by integrating piecewise affine functions }

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

Here, in every dimension, the corresponding one-dimensional stationary kernel \code{k(x,y)} is replaced by \code{k(f(x),f(y))}, where \code{f} is a continuous monotonic function indexed by a finite number of  parameters (see the references for more detail). 

}

\section{Slots}{
  \describe{
     \item{\code{d}:}{Object of class \code{"integer"}. The spatial dimension. }
    \item{\code{knots}:}{Object of class \code{"list"}. The j-th element is a vector containing the knots for dimension j. }
    \item{\code{eta}:}{Object of class \code{"list"}. In correspondance with knots, the j-th element is a vector containing the scaling coefficients (i.e. the derivatives of the scaling function at the knots) for dimension j.} 
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
    \item{coef}{\code{signature(object = "covScaling")}: ... }
    \item{covMat1Mat2}{\code{signature(object = "covScaling")}: ... }
    \item{covMatrix}{\code{signature(object = "covScaling")}: ... }
    \item{covMatrixDerivative}{\code{signature(object = "covScaling")}: ... }
    \item{covParametersBounds}{\code{signature(object = "covScaling")}: ... }
    \item{covparam2vect}{\code{signature(object = "covScaling")}: ... }
    \item{vect2covparam}{\code{signature(object = "covScaling")}: ... }
    \item{covVector.dx}{\code{signature(object = "covScaling")}: ... }
    \item{show}{\code{signature(object = "covScaling")}: ... }
    \item{inputnames}{\code{signature(x = "covAffineScaling")}: ... }
    \item{kernelname}{\code{signature(x = "covAffineScaling")}: ... }
    \item{ninput}{\code{signature(x = "covAffineScaling")}: ... }
    \item{nuggetflag}{\code{signature(x = "covAffineScaling")}: ... }
    \item{nuggetvalue}{\code{signature(x = "covAffineScaling")}: ... }
    \item{nuggetvalue<-}{\code{signature(x = "covAffineScaling")}: ... }
    \item{summary}{\code{signature(object = "covAffineScaling")}: ... }
}
}
	
\references{
Y. Xiong, W. Chen, D. Apley, and X. Ding (2007), \emph{Int. J. Numer. Meth. Engng}, A non-stationary covariance-based Kriging method for metamodelling in engineering design. 
}


\author{ Olivier Roustant, David Ginsbourger, Yves Deville }
%\note{ ~~further notes~~ }

\seealso{
	\code{\linkS4class{km}}
	\code{\linkS4class{covTensorProduct}}
	\code{\linkS4class{covAffineScaling}}
      \code{\linkS4class{covIso}}
	\code{\linkS4class{covKernel}}
}

\examples{
showClass("covScaling")
}
\keyword{classes}
