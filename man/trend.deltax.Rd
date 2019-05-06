\name{trend.deltax}
\alias{trend.deltax}
\title{
Trend derivatives
}
\description{
Computes the gradient of the vector of trend basis functions f(x)=(f1(x);...;fp(x))
}
\usage{
trend.deltax(x, model, h = sqrt(.Machine$double.eps))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ a vector representing the specific location.}
  \item{model}{ an object of class km.} 
  \item{h}{ the precision for numerical derivatives.}
}

\value{
A \code{pxd} matrix where the \code{p} rows contain the gradient of the trend basis functions.
}


\author{
O. Roustant, Ecole des Mines de St-Etienne.
}

\note{
The gradient is computed analytically in 4 common practical situations: \code{formula=~1} (constant trend), \code{formula=~.} (first-order polynomial), \code{formula=~.^2} (first-order polynomial + second-order interactions), first-order polynomial + (pure) quadratic terms. In the other cases, the gradient is approximated by a finite difference of the form \code{(g(x+h)-g(x-h))/2h}, where \code{h} is tunable. 
}

\seealso{  \code{\link{covVector.dx}} }

\keyword{models}
\keyword{optimize}
\keyword{internal}

\examples{
X <- expand.grid(x1=seq(0,1,length=4), x2=seq(0,1,length=4), x3=seq(0,1,length=4))
fun <- function(x){
  (x[1]+2*x[2]+3*x[3])^2
}
y <- apply(X, 1, fun) 

x <- c(0.2, 0.4, 0.6)
coef.cov=c(0.5, 0.9, 1.3); coef.var=3

m <- km(~.^2, design=X, response=y, coef.cov=coef.cov, coef.var=coef.var)
grad.trend <- trend.deltax(x, m)
print(grad.trend)

m <- km(~. + I(x1^2) + I(x2^2) + I(x3^2), 
        design=X, response=y, coef.cov=coef.cov, coef.var=coef.var)
grad.trend <- trend.deltax(x, m)
print(grad.trend)
}
