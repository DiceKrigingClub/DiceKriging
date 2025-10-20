\name{covIso-class}
\Rdversion{1.1}
\docType{class}
\alias{covIso-class}
\alias{coef,covIso-method}
\alias{covMat1Mat2,covIso-method}
\alias{covMatrix,covIso-method}
\alias{covMatrixDerivative,covIso-method}
\alias{covParametersBounds,covIso-method}
\alias{covparam2vect,covIso-method}
\alias{vect2covparam,covIso-method}
\alias{covVector.dx,covIso-method}
\alias{inputnames,covIso-method}
%\alias{inputnames<-,covIso,character-method}
\alias{kernelname,covIso-method}
\alias{ninput,covIso-method}
\alias{nuggetflag,covIso-method}
\alias{nuggetvalue,covIso-method}
\alias{nuggetvalue<-,covIso,numeric-method}
\alias{show,covIso-method}
\alias{summary,covIso-method}

\title{ Class of tensor-product spatial covariances with isotropic range}
\description{ S4 class of isotropic spatial covariance kerlnes based upon the covTensorProduct class}


\section{Objects from the Class}{
In 1-dimension, the covariance kernels are parameterized as in (Rasmussen, Williams, 2006). Denote by \code{theta} the range parameter, \code{p} the exponent parameter (for power-exponential covariance), \code{s} the standard deviation, and \code{h=||x-y||}. Then we have \code{C(x,y) = s^2 * k(x,y)}, with:

\tabular{ll}{
Gauss \tab \code{ k(x,y) = exp(-1/2*(h/theta)^2) } \cr
Exponential \tab \code{ k(x,y) = exp(-h/theta) } \cr
Matern(3/2) \tab \code{ k(x,y) = (1+sqrt(3)*h/theta)*exp(-sqrt(3)*h/theta) } \cr
Matern(5/2) \tab \code{ k(x,y) = (1+sqrt(5)*h/theta+(1/3)*5*(h/theta)^2)} \cr 
\tab \code{          *exp(-sqrt(5)*h/theta)} \cr
Power-exponential \tab \code{ k(x,y) = exp(-(h/theta)^p) } \cr
}
}

%\section{Slots}{
%  \describe{
%    \item{\code{d}:}{Object of class \code{"integer"} ~~ }
%    \item{\code{name}:}{Object of class \code{"character"} ~~ }
%    \item{\code{paramset.n}:}{Object of class \code{"integer"} ~~ }
%    \item{\code{var.names}:}{Object of class \code{"character"} ~~ }
%    \item{\code{sd2}:}{Object of class \code{"numeric"} ~~ }
%    \item{\code{known.covparam}:}{Object of class \code{"character"} %~~ }
%    \item{\code{nugget.flag}:}{Object of class \code{"logical"} ~~ }
%    \item{\code{nugget.estim}:}{Object of class \code{"logical"} ~~ %}
%    \item{\code{nugget}:}{Object of class \code{"numeric"} ~~ }
%    \item{\code{param.n}:}{Object of class \code{"integer"} ~~ }
%    \item{\code{range.names}:}{Object of class \code{"character"} ~~ %}
%    \item{\code{range.val}:}{Object of class \code{"numeric"} ~~ }
%  }
%}


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
%    \item{\code{range.n}:}{Object of class \code{"integer"}. The number of range parameters. }
    \item{\code{range.names}:}{Object of class \code{"character"}. Names of range parameters, for printing purpose. Default is "theta". }
    \item{\code{range.val}:}{Object of class \code{"numeric"}. Values of range parameters. }
%    \item{\code{shape.n}:}{Object of class \code{"integer"}. The number of shape parameters (exponent parameters in "powexp"). }
%    \item{\code{shape.names}:}{Object of class \code{"character"}. Names of shape parameters, for printing purpose. Default is "p". }
%    \item{\code{shape.val}:}{Object of class \code{"numeric"}. Values of shape parameters. }
	
	}
}


\section{Extends}{
Class \code{"\linkS4class{covKernel}"}, directly.
}


\section{Methods}{
  \describe{
    \item{coef}{\code{signature(object = "covIso")}: ... }
    \item{covMat1Mat2}{\code{signature(object = "covIso")}: ... }
    \item{covMatrix}{\code{signature(object = "covIso")}: ... }
    \item{covMatrixDerivative}{\code{signature(object = "covIso")}: ... }
    \item{covParametersBounds}{\code{signature(object = "covIso")}: ... }
    \item{covparam2vect}{\code{signature(object = "covIso")}: ... }  
    \item{vect2covparam}{\code{signature(object = "covIso")}: ... }  
    \item{covVector.dx}{\code{signature(object = "covIso")}: ... }
    \item{inputnames}{\code{signature(x = "covIso")}: ... }
    \item{kernelname}{\code{signature(x = "covIso")}: ... }
    \item{ninput}{\code{signature(x = "covIso")}: ... }
    \item{nuggetflag}{\code{signature(x = "covIso")}: ... }
    \item{nuggetvalue}{\code{signature(x = "covIso")}: ... }
    \item{show}{\code{signature(object = "covIso")}: ... }
    \item{summary}{\code{signature(object = "covIso")}: ... }
	 }
}

\author{ O. Roustant, D. Ginsbourger}

\references{
	
N.A.C. Cressie (1993), \emph{Statistics for spatial data}, Wiley series in probability and mathematical statistics.

C.E. Rasmussen and C.K.I. Williams (2006), \emph{Gaussian Processes for Machine Learning}, the MIT Press, \url{https://gaussianprocess.org/gpml/}

M.L. Stein (1999), \emph{Interpolation of spatial data, some theory for kriging}, Springer.

}


\seealso{
	\code{\link{km}}
	\code{\linkS4class{covTensorProduct}}
}
\examples{
showClass("covIso")
}
\keyword{classes}
