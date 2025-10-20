\name{covTensorProduct-class}
\docType{class}
\alias{covTensorProduct-class}
\alias{show,covTensorProduct-method}
\alias{coef,covTensorProduct-method}
%\alias{coef<-,covTensorProduct,numeric-method}
\alias{covMat1Mat2,covTensorProduct-method}
\alias{covMatrix,covTensorProduct-method}
\alias{covMatrixDerivative,covTensorProduct-method}
\alias{covParametersBounds,covTensorProduct-method}
\alias{covparam2vect,covTensorProduct-method}
\alias{vect2covparam,covTensorProduct-method}
\alias{covVector.dx,covTensorProduct-method}
\alias{inputnames,covTensorProduct-method}
%\alias{inputnames<-,covTensorProduct,character-method}
\alias{kernelname,covTensorProduct-method}
\alias{ninput,covTensorProduct-method}
\alias{nuggetflag,covTensorProduct-method}
\alias{nuggetvalue,covTensorProduct-method}
\alias{nuggetvalue<-,covTensorProduct,numeric-method}
\alias{summary,covTensorProduct-method}



%- Also NEED an '\alias' for EACH other topic documented here.

\title{ Class of tensor-product spatial covariances }
\description{
  S4 class of tensor-product (or separable) covariances.}

\value{
\item{covTensorProduct}{separable covariances depending on 1 set of
  parameters, such as Gaussian, exponential, Matern with fixed nu... or
  on 2 sets of parameters, such as power-exponential.}
}

\section{Objects from the Class}{
A d-dimensional tensor product (or separable) covariance kernel \code{C(x,y)} is the tensor product of 1-dimensional covariance kernels : \code{C(x,y) = C(x1,y1)C(x2,y2)...C(xd,yd)}.

In 1-dimension, the covariance kernels are parameterized as in (Rasmussen, Williams, 2006). Denote by \code{theta} the range parameter, \code{p} the exponent parameter (for power-exponential covariance), \code{s} the standard deviation, and \code{h=|x-y|}. Then we have \code{C(x,y) = s^2 * k(x,y)}, with:

\tabular{ll}{
Gauss \tab \code{ k(x,y) = exp(-1/2*(h/theta)^2) } \cr
Exponential \tab \code{ k(x,y) = exp(-h/theta) } \cr
Matern(3/2) \tab \code{ k(x,y) = (1+sqrt(3)*h/theta)*exp(-sqrt(3)*h/theta) } \cr
Matern(5/2) \tab \code{ k(x,y) = (1+sqrt(5)*h/theta+(1/3)*5*(h/theta)^2)} \cr 
\tab \code{          *exp(-sqrt(5)*h/theta)} \cr
Power-exponential \tab \code{ k(x,y) = exp(-(h/theta)^p) } \cr
}

}


\section{Slots}{
	 \describe{
	 \item{\code{d}:}{Object of class \code{"integer"}. The spatial dimension. }
	 \item{\code{name}:}{Object of class \code{"character"}. The covariance function name. To be chosen between \code{"gauss", "matern5_2", "matern3_2", "exp"}, and \code{"powexp"} }
	 \item{\code{paramset.n}:}{Object of class \code{"integer"}. 1 for covariance depending only on the ranges parameters, 2 for "powexp" which also depends on exponent parameters. }
	 \item{\code{var.names}:}{Object of class \code{"character"}. The variable names. }
	 \item{\code{sd2}:}{Object of class \code{"numeric"}. The variance of the stationary part of the process. }
	 \item{\code{known.covparam}:}{Object of class \code{"character"}. Internal use. One of: "None", "All". }
    \item{\code{nugget.flag}:}{Object of class \code{"logical"}. Is there a nugget effect? }
    \item{\code{nugget.estim}:}{Object of class \code{"logical"}. Is the nugget effect estimated or known? }
    \item{\code{nugget}:}{Object of class \code{"numeric"}. If there is a nugget effect, its value (homogeneous to a variance). }
    \item{\code{param.n}:}{Object of class \code{"integer"}. The total number of parameters. }
    \item{\code{range.n}:}{Object of class \code{"integer"}. The number of range parameters. }
    \item{\code{range.names}:}{Object of class \code{"character"}. Names of range parameters, for printing purpose. Default is "theta". }
    \item{\code{range.val}:}{Object of class \code{"numeric"}. Values of range parameters. }
    \item{\code{shape.n}:}{Object of class \code{"integer"}. The number of shape parameters (exponent parameters in "powexp"). }
    \item{\code{shape.names}:}{Object of class \code{"character"}. Names of shape parameters, for printing purpose. Default is "p". }
    \item{\code{shape.val}:}{Object of class \code{"numeric"}. Values of shape parameters. }
	
	}
}



\section{Methods}{
  \describe{
    \item{show}{\code{signature(x = "covTensorProduct")} Print covariance function. See \code{\link{show,km-method}}. }
    \item{coef}{\code{signature(x = "covTensorProduct")} Get the coefficients of the covariance function. }
%    \item{coef<-}{\code{signature(x = "covTensorProduct")} Set the coefficients of the covariance function. } 
  }
}


\author{ O. Roustant, D. Ginsbourger}

\references{
	
N.A.C. Cressie (1993), \emph{Statistics for spatial data}, Wiley series in probability and mathematical statistics.

C.E. Rasmussen and C.K.I. Williams (2006), \emph{Gaussian Processes for Machine Learning}, the MIT Press, \url{https://gaussianprocess.org/gpml/}

M.L. Stein (1999), \emph{Interpolation of spatial data, some theory for kriging}, Springer.

}

\seealso{ \code{\link{covStruct.create}} to construct a covariance structure.}

\keyword{models}


