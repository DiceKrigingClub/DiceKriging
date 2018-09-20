\name{covUser-class}
\Rdversion{1.1}
\docType{class}
\alias{covUser-class}
\alias{coef,covUser-method}
\alias{covMat1Mat2,covUser-method}
\alias{covMatrix,covUser-method}
\alias{show,covUser-method}

\alias{nuggetflag,covUser-method}
\alias{nuggetvalue,covUser-method}
\alias{nuggetvalue<-,covUser,numeric-method}

\title{Class "covUser" }
\description{ An arbitrary covariance kernel provided by the user }

\section{Objects from the Class}{
Any valid covariance kernel, provided as a 2-dimensional function (x,y) -> k(x,y). At this stage, no test is done to check that k is positive definite.
}

\section{Slots}{
  \describe{
     \item{\code{kernel}:}{Object of class \code{"function"}. The new covariance kernel. }
        \item{\code{nugget.flag}:}{Object of class \code{"logical"}. Is there a nugget effect? }
    \item{\code{nugget}:}{Object of class \code{"numeric"}. If there is a nugget effect, its value (homogeneous to a variance). }
  }
}

\section{Extends}{
Class \code{"\linkS4class{covKernel}"}, directly.
}

\section{Methods}{
  \describe{
    \item{coef}{\code{signature(object = "covUser")}: ... }
    \item{covMat1Mat2}{\code{signature(object = "covScaling")}: ... }
    \item{covMatrix}{\code{signature(object = "covScaling")}: ... }
    \item{show}{\code{signature(object = "covScaling")}: ... }
  }
}
	
%\references{
%}


\author{ Olivier Roustant, David Ginsbourger, Yves Deville }
%\note{ ~~further notes~~ }

\seealso{
	\code{\linkS4class{km}}
	\code{\linkS4class{covTensorProduct}}
      \code{\linkS4class{covIso}}
	\code{\linkS4class{covKernel}}
}

\examples{
showClass("covUser")
}
\keyword{classes}
