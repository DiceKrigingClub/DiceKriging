\name{predict}
\alias{predict}
\alias{predict.km}
\alias{predict,km-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Predict values and confidence intervals at newdata for a km object }
\description{
Predicted values and (marginal of joint) conditional variances based on a \code{km} model.  95 \% confidence intervals are given, based on strong assumptions: Gaussian process assumption, specific prior distribution on the trend parameters, known covariance parameters. This might be abusive in particular in the case where estimated covariance parameters are plugged in.
}
\usage{
\S4method{predict}{km}(object, newdata, type, se.compute = TRUE, 
         cov.compute = FALSE, light.return = FALSE,
         bias.correct = FALSE, checkNames = TRUE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{ an object of class \code{km}. }
  \item{newdata}{ a vector, matrix or data frame containing the points where to perform predictions. }
  \item{type}{ a character string corresponding to the kriging family, to be chosen between simple kriging ("SK"), or universal kriging ("UK").}
  \item{se.compute}{ an optional boolean. If \code{FALSE}, only the kriging mean is computed. If \code{TRUE}, the kriging variance (actually, the corresponding standard deviation) and confidence intervals are computed too.}
  \item{cov.compute}{ an optional boolean. If \code{TRUE}, the conditional covariance matrix is computed.}
  \item{light.return}{ an optional boolean. If \code{TRUE}, \code{c} and \code{Tinv.c} are not returned. This should be reserved to expert users who want to save memory and know that they will not miss these values.}
  \item{bias.correct}{ an optional boolean to correct bias in the UK variance and covariances. Default is \code{FALSE}. See Section Warning below.}
  \item{checkNames}{ an optional boolean. If \code{TRUE} (default), a consistency test is performed between the names of \code{newdata} and the names of the experimental design (contained in \code{object@X}), see Section Warning below.}
  \item{...}{ no other argument for this method.}
}

\value{
  \item{mean }{ kriging mean (including the trend) computed at \code{newdata}. }
  \item{sd }{ kriging standard deviation computed at \code{newdata}. Not computed if 
              \code{se.compute=FALSE}. }
  \item{trend }{ the trend computed at \code{newdata}.}
  \item{cov }{ kriging conditional covariance matrix. Not computed if \code{cov.compute=FALSE} (default).}
  \item{lower95, }{ }
  \item{upper95 }{ bounds of the 95 \% confidence interval computed at \code{newdata} (to be interpreted with special care when parameters are estimated, see description above). Not computed if \code{se.compute=FALSE}.}
  \item{c }{ an auxiliary matrix, containing all the covariances between newdata and the initial design points. Not returned if \code{light.return=TRUE}.}
  \item{Tinv.c }{ an auxiliary vector, equal to \code{inv(t(T))*c}. Not returned if \code{light.return=TRUE}.}
}

\section{Warning}{
1. Contrarily to DiceKriging<=1.3.2, the estimated (UK) variance and covariances are NOT multiplied by \code{n/(n-p)} by default (\code{n} and \code{p} denoting the number of rows and columns of the design matrix F). Recall that this correction would contribute to limit bias: it would totally remove it if the correlation parameters were known (which is not the case here). However, this correction is often useless in the context of computer experiments, especially in adaptive strategies. It can be activated by turning \code{bias.correct} to \code{TRUE}, when \code{type="UK"}.

2. The columns of \code{newdata} should correspond to the input variables, and only the input variables (nor the response is not admitted, neither external variables). If \code{newdata} contains variable names, and if \code{checkNames} is \code{TRUE} (default), then \code{\link{checkNames}} performs a complete consistency test with the names of the experimental design. Otherwise, it is assumed that its columns correspond to the same variables than the experimental design and in the same order.
}

\references{

N.A.C. Cressie (1993), \emph{Statistics for spatial data}, Wiley series in probability and mathematical statistics.

A.G. Journel and C.J. Huijbregts (1978), \emph{Mining Geostatistics}, Academic Press, London.

D.G. Krige (1951), A statistical approach to some basic mine valuation problems on the witwatersrand, \emph{J. of the Chem., Metal. and Mining Soc. of South Africa}, \bold{52} no. 6, 119-139.

J.D. Martin and T.W. Simpson (2005), Use of kriging models to approximate deterministic computer models, \emph{AIAA Journal}, \bold{43} no. 4, 853-863.

G. Matheron (1963), Principles of geostatistics, \emph{Economic Geology}, \bold{58},
1246-1266.

G. Matheron (1969), Le krigeage universel, \emph{Les Cahiers du Centre de Morphologie Mathematique de Fontainebleau}, \bold{1}.

J.-S. Park and J. Baek (2001), Efficient computation of maximum likelihood estimators in a spatial linear model with power exponential covariogram, \emph{Computer Geosciences}, \bold{27} no. 1, 1-7.

C.E. Rasmussen and C.K.I. Williams (2006), \emph{Gaussian Processes for Machine Learning}, the MIT Press, \url{http://www.gaussianprocess.org/gpml}

J. Sacks, W.J. Welch, T.J. Mitchell, and H.P. Wynn (1989), Design and analysis of computer experiments, \emph{Statistical Science}, \bold{4}, 409-435.

}

\author{ O. Roustant, D. Ginsbourger, Ecole des Mines de St-Etienne. }

\seealso{  \code{\link{km}},  \code{\link{plot,km-method}} }

\keyword{models}
\keyword{methods}

\examples{
# ------------
# a 1D example
# ------------

x <- c(0, 0.4, 0.6, 0.8, 1)
y <- c(-0.3, 0, 0, 0.5, 0.9)

formula <- y~x   # try also   y~1  and  y~x+I(x^2)

model <- km(formula=formula, design=data.frame(x=x), response=data.frame(y=y), 
            covtype="matern5_2")

tmin <- -0.5; tmax <- 2.5
t <- seq(from=tmin, to=tmax, by=0.005)
color <- list(SK="black", UK="blue")

# Results with Universal Kriging formulae (mean and and 95% intervals)
p.UK <- predict(model, newdata=data.frame(x=t), type="UK")
plot(t, p.UK$mean, type="l", ylim=c(min(p.UK$lower95),max(p.UK$upper95)), 
                xlab="x", ylab="y")
lines(t, p.UK$trend, col="violet", lty=2)
lines(t, p.UK$lower95, col=color$UK, lty=2)
lines(t, p.UK$upper95, col=color$UK, lty=2)
points(x, y, col="red", pch=19)
abline(h=0)

# Results with Simple Kriging (SK) formula. The difference between the width of
# SK and UK intervals are due to the estimation error of the trend parameters 
# (but not to the range parameters, not taken into account in the UK formulae).
p.SK <- predict(model, newdata=data.frame(x=t), type="SK")
lines(t, p.SK$mean, type="l", ylim=c(-7,7), xlab="x", ylab="y")
lines(t, p.SK$lower95, col=color$SK, lty=2)
lines(t, p.SK$upper95, col=color$SK, lty=2)
points(x, y, col="red", pch=19)
abline(h=0)

legend.text <- c("Universal Kriging (UK)", "Simple Kriging (SK)")
legend(x=tmin, y=max(p.UK$upper), legend=legend.text, 
       text.col=c(color$UK, color$SK), col=c(color$UK, color$SK), 
       lty=3, bg="white")


# ---------------------------------------------------------------------------------
# a 1D example (following)- COMPARISON with the PREDICTION INTERVALS for REGRESSION
# ---------------------------------------------------------------------------------
# There are two interesting cases: 
# *  When the range parameter is near 0 ; Then the intervals should be nearly 
#    the same for universal kriging (when bias.correct=TRUE, see above) as for regression. 
#    This is because the uncertainty around the range parameter is not taken into account 
#    in the Universal Kriging formula.
# *  Where the predicted sites are "far" (relatively to the spatial correlation) 
#    from the design points ; in this case, the kriging intervals are not equal 
#    but nearly proportional to the regression ones, since the variance estimate 
#    for regression is not the same than for kriging (that depends on the 
#    range estimate)

x <- c(0, 0.4, 0.6, 0.8, 1)
y <- c(-0.3, 0, 0, 0.5, 0.9)

formula <- y~x   # try also   y~1  and  y~x+I(x^2)
upper <- 0.05    # this is to get something near to the regression case. 
                 # Try also upper=1 (or larger) to get usual results.

model <- km(formula=formula, design=data.frame(x=x), response=data.frame(y=y), 
               covtype="matern5_2", upper=upper)

tmin <- -0.5; tmax <- 2.5
t <- seq(from=tmin, to=tmax, by=0.005)
color <- list(SK="black", UK="blue", REG="red")

# Results with Universal Kriging formulae (mean and and 95% intervals)
p.UK <- predict(model, newdata=data.frame(x=t), type="UK", bias.correct=TRUE)
plot(t, p.UK$mean, type="l", ylim=c(min(p.UK$lower95),max(p.UK$upper95)), 
                   xlab="x", ylab="y")
lines(t, p.UK$trend, col="violet", lty=2)
lines(t, p.UK$lower95, col=color$UK, lty=2)
lines(t, p.UK$upper95, col=color$UK, lty=2)
points(x, y, col="red", pch=19)
abline(h=0)

# Results with Simple Kriging (SK) formula. The difference between the width of
# SK and UK intervals are due to the estimation error of the trend parameters 
# (but not to the range parameters, not taken into account in the UK formulae).
p.SK <- predict(model, newdata=data.frame(x=t), type="SK")
lines(t, p.SK$mean, type="l", ylim=c(-7,7), xlab="x", ylab="y")
lines(t, p.SK$lower95, col=color$SK, lty=2)
lines(t, p.SK$upper95, col=color$SK, lty=2)
points(x, y, col="red", pch=19)
abline(h=0)

# results with regression given by lm (package stats)
m.REG <- lm(formula)
p.REG <- predict(m.REG, newdata=data.frame(x=t), interval="prediction")
lines(t, p.REG[,1], col=color$REG)
lines(t, p.REG[,2], col=color$REG, lty=2)
lines(t, p.REG[,3], col=color$REG, lty=2)

legend.text <- c("UK with bias.correct=TRUE", "SK", "Regression")
legend(x=tmin, y=max(p.UK$upper), legend=legend.text, 
       text.col=c(color$UK, color$SK, color$REG), 
       col=c(color$UK, color$SK, color$REG), lty=3, bg="white")


# ----------------------------------
# A 2D example - Branin-Hoo function
# ----------------------------------

# a 16-points factorial design, and the corresponding response
d <- 2; n <- 16
fact.design <- expand.grid(x1=seq(0,1,length=4), x2=seq(0,1,length=4))
branin.resp <- apply(fact.design, 1, branin)

# kriging model 1 : gaussian covariance structure, no trend, 
#                   no nugget effect
m1 <- km(~1, design=fact.design, response=branin.resp, covtype="gauss")

# predicting at testdata points
testdata <- expand.grid(x1=s <- seq(0,1, length=15), x2=s)
predicted.values.model1 <- predict(m1, testdata, "UK")
}