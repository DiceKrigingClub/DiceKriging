\name{km}
\alias{km}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Fit and/or create kriging models }
\description{
  \code{km} is used to fit kriging models when parameters are unknown, or to create \code{km} objects otherwise. In both cases, the result is a \code{km} object. If parameters are unknown, they are estimated by Maximum Likelihood. As a beta version, Penalized Maximum Likelihood Estimation is also possible if some penalty is given, or Leave-One-Out for noise-free observations.
}

\usage{
km(formula=~1, design, response, covtype="matern5_2",
   coef.trend = NULL, coef.cov = NULL, coef.var = NULL,
   nugget = NULL, nugget.estim=FALSE, noise.var=NULL, estim.method="MLE",
   penalty = NULL, optim.method = "BFGS", lower = NULL, upper = NULL, 
   parinit = NULL, multistart = 1, control = NULL, gr = TRUE, 
   iso=FALSE, scaling=FALSE, knots=NULL, kernel=NULL)
}


%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{formula}{ an optional object of class "formula" specifying the linear trend of the kriging model (see \code{\link{lm}}). This formula should concern only the input variables, and not the output (response). If there is any, it is automatically dropped. In particular, no response transformation is available yet. The default is \code{~1}, which defines a constant trend.}
  \item{design}{ a data frame representing the design of experiments. The ith row contains the values of the d input variables corresponding to the ith evaluation}
  \item{response}{ a vector (or 1-column matrix or data frame) containing the values of the 1-dimensional output given by the objective function at the \code{design} points. }
  \item{covtype}{ an optional character string specifying the covariance structure to be used, to be chosen between \code{"gauss"}, \code{"matern5_2"}, \code{"matern3_2"}, \code{"exp"} or \code{"powexp"}. See a full description of available covariance kernels in \code{\link{covTensorProduct-class}}. Default is \code{"matern5_2"}. See also the argument \code{kernel} that allows the user to build its own covariance structure.}
  \item{coef.trend,}{ (see below)}
  \item{coef.cov,}{ (see below)}
  \item{coef.var}{ optional vectors containing the values for the trend, covariance and variance parameters. For estimation, 4 cases are implemented: 1. (All unknown) If all are missing, all are estimated. 2. (All known) If all are provided, no estimation is performed; 3. (Known trend) If \code{coef.trend} is provided but at least one of \code{coef.cov} or \code{coef.var} is missing, then BOTH \code{coef.cov} and \code{coef.var} are estimated; 4. (Unknown trend) If \code{coef.cov} and \code{coef.var} are provided but \code{coef.trend} is missing, then \code{coef.trend} is estimated (GLS formula).}
   \item{nugget}{ an optional variance value standing for the homogeneous nugget effect.}
  \item{nugget.estim}{ an optional boolean indicating whether the nugget effect should be estimated. Note that this option does not concern the case of heterogeneous noisy observations (see \code{noise.var} below). If \code{nugget} is given, it is used as an initial value. Default is \code{FALSE}.}
  \item{noise.var}{ for noisy observations : an optional vector containing the noise variance at each observation. This is useful for stochastic simulators. Default is \code{NULL}.}
  \item{estim.method}{  a character string specifying the method by which unknown parameters are estimated. Default is \code{"MLE"} (Maximum Likelihood). At this stage, a beta version of leave-One-Out estimation (\code{estim.method="LOO"}) is also implemented for noise-free observations.}
  \item{penalty}{ (beta version) an optional list suitable for Penalized Maximum Likelihood Estimation. The list must contain the item \code{fun} indicating the penalty function, and the item \code{value} equal to the value of the penalty parameter. At this stage the only available \code{fun} is \code{"SCAD"}, and \code{covtype} must be \code{"gauss"}. Default is \code{NULL}, corresponding to (un-penalized) Maximum Likelihood Estimation.}
  \item{optim.method}{ an optional character string indicating which optimization method is chosen for the likelihood maximization. \code{"BFGS"} is the \code{optim} quasi-Newton procedure of package \code{stats}, with the method "L-BFGS-B". \code{"gen"} is the \code{genoud} genetic algorithm (using derivatives) from package \code{rgenoud} (>= 5.3.3). }
  \item{lower, }{ (see below) }
  \item{upper}{ optional vectors containing the bounds of the correlation parameters for optimization. The default values are given by \code{\link{covParametersBounds}}. }
  \item{parinit}{ an optional vector containing the initial values for the variables to be optimized over. If no vector is given, an initial point is generated as follows. For method \code{"gen"}, the initial point is generated uniformly inside the hyper-rectangle domain defined by \code{lower} and \code{upper}. For method \code{"BFGS"}, some points (see \code{control} below) are generated uniformly in the domain. Then the best point with respect to the likelihood (or penalized likelihood, see \code{penalty}) criterion is chosen. }
  \item{multistart}{ an optional integer indicating the number of initial points from which running the BFGS optimizer. These points will be selected as the best \code{multistart} one(s) among those evaluated (see above \code{parinit}). The multiple optimizations will be performed in parallel provided that a parallel backend is registered (see package \code{foreach}).} 
   \item{control}{ an optional list of control parameters for optimization. See details below.}
   \item{gr}{ an optional boolean indicating whether the analytical gradient should be used. Default is \code{TRUE}.}
   \item{iso}{ an optional boolean that can be used to force a tensor-product covariance structure (see \code{\link{covTensorProduct-class}}) to have a range parameter common to all dimensions. Default is \code{FALSE}. Not used (at this stage) for the power-exponential type.}
   \item{scaling}{ an optional boolean indicating whether a scaling on the covariance structure should be used.}
   \item{knots}{ an optional list of knots for scaling. The j-th element is a vector containing the knots for dimension j. If \code{scaling=TRUE} and knots are not specified, than knots are fixed to 0 and 1 in each dimension (which corresponds to affine scaling for the domain [0,1]^d).}
   \item{kernel}{ an optional function containing a new covariance structure. At this stage, the parameters must be provided as well, and are not estimated. See an example below.}
}

\value{
  An object of class \code{km} (see \code{\link{km-class}}).
}

\details{
The optimisers are tunable by the user by the argument \code{control}. 
Most of the control parameters proposed by \code{BFGS} and \code{genoud} can be passed to \code{control} except the ones that must be forced [for the purpose of optimization setting], as indicated in the table below. See \code{\link[stats]{optim}} and  \code{\link[rgenoud]{genoud}} to get more details about them.

\tabular{ll}{
BFGS \tab \code{trace}, \code{parscale}, \code{ndeps}, \code{maxit}, \code{abstol}, \code{reltol}, \code{REPORT}, \code{lnm}, \code{factr}, \code{pgtol} \cr
genoud \tab all parameters EXCEPT: \code{fn, nvars, max, starting.values, Domains, gr, gradient.check, boundary.enforcement, hessian} and \code{optim.method}. \cr 
}

Notice that the right places to specify the optional starting values and boundaries are in \code{parinit} and \code{lower, upper}, as explained above. Some additional possibilities and initial values are indicated in the table below:

\tabular{ll}{
\code{trace} \tab Turn it to \code{FALSE} to avoid printing during optimization progress.\cr
%\code{upper.alpha}: Upper value for 'alpha' in nugget estimation \cr
\code{pop.size} \tab For method \code{"BFGS"}, it is the number of candidate initial points generated before optimization starts (see \code{parinit} above). Default is 20. For method \code{"gen"}, \code{"pop.size"} is the population size, set by default at min(20, 4+3*log(nb of variables) \cr
\code{max.generations} \tab Default is 5 \cr
\code{wait.generations} \tab Default is 2 \cr
\code{BFGSburnin} \tab Default is 0 \cr
}

}

\references{ 

N.A.C. Cressie (1993), \emph{Statistics for spatial data}, Wiley series in probability and mathematical statistics.

D. Ginsbourger (2009), \emph{Multiples metamodeles pour l'approximation et l'optimisation
de fonctions numeriques multivariables}, Ph.D. thesis, Ecole Nationale Superieure des
Mines de Saint-Etienne, 2009.

D. Ginsbourger, D. Dupuy, A. Badea, O. Roustant, and L. Carraro (2009), A note on the choice and the estimation of kriging models for the analysis of deterministic computer experiments, \emph{Applied Stochastic Models for Business and Industry}, \bold{25} no. 2, 115-131.

A.G. Journel and M.E. Rossi (1989), When do we need a trend model in kriging ?, \emph{Mathematical Geology}, \bold{21} no. 7, 715-739.

D.G. Krige (1951), A statistical approach to some basic mine valuation problems on the witwatersrand, \emph{J. of the Chem., Metal. and Mining Soc. of South Africa}, \bold{52} no. 6, 119-139.

R. Li and A. Sudjianto (2005), Analysis of Computer Experiments Using Penalized Likelihood in Gaussian Kriging Models, \emph{Technometrics}, \bold{47} no. 2, 111-120.

K.V. Mardia and R.J. Marshall (1984), Maximum likelihood estimation of models for residual covariance in spatial regression, \emph{Biometrika}, \bold{71}, 135-146.

J.D. Martin and T.W. Simpson (2005), Use of kriging models to approximate deterministic computer models, \emph{AIAA Journal}, \bold{43} no. 4, 853-863.

G. Matheron (1969), Le krigeage universel, \emph{Les Cahiers du Centre de Morphologie Mathematique de Fontainebleau}, \bold{1}.

W.R. Jr. Mebane and J.S. Sekhon, in press (2009), Genetic optimization using derivatives: The rgenoud package for R, \emph{Journal of Statistical Software}.

J.-S. Park and J. Baek (2001), Efficient computation of maximum likelihood estimators in a spatial linear model with power exponential covariogram, \emph{Computer Geosciences}, \bold{27} no. 1, 1-7.

C.E. Rasmussen and C.K.I. Williams (2006), \emph{Gaussian Processes for Machine Learning}, the MIT Press, \url{http://www.gaussianprocess.org/gpml/}

}

\author{ O. Roustant, D. Ginsbourger, Ecole des Mines de St-Etienne. }

\seealso{ \code{\link{kmData}} for another interface with the data,
  \code{\link{show,km-method}},
  \code{\link{predict,km-method}},
  \code{\link{plot,km-method}}.
  Some programming details and initialization choices can be found in \code{\link{kmEstimate}}, \code{\link{kmNoNugget.init}},
\code{\link{km1Nugget.init}} and \code{\link{kmNuggets.init}} }

\keyword{models}
\keyword{htest}
\examples{

# ----------------------------------
# A 2D example - Branin-Hoo function
# ----------------------------------

# a 16-points factorial design, and the corresponding response
d <- 2; n <- 16
design.fact <- expand.grid(x1=seq(0,1,length=4), x2=seq(0,1,length=4))
y <- apply(design.fact, 1, branin) 

# kriging model 1 : matern5_2 covariance structure, no trend, no nugget effect
m1 <- km(design=design.fact, response=y)

# kriging model 2 : matern5_2 covariance structure, 
#                   linear trend + interactions, no nugget effect
m2 <- km(~.^2, design=design.fact, response=y)

# graphics 
n.grid <- 50
x.grid <- y.grid <- seq(0,1,length=n.grid)
design.grid <- expand.grid(x1=x.grid, x2=y.grid)
response.grid <- apply(design.grid, 1, branin)
predicted.values.model1 <- predict(m1, design.grid, "UK")$mean
predicted.values.model2 <- predict(m2, design.grid, "UK")$mean
par(mfrow=c(3,1))
contour(x.grid, y.grid, matrix(response.grid, n.grid, n.grid), 50, main="Branin")
points(design.fact[,1], design.fact[,2], pch=17, cex=1.5, col="blue")
contour(x.grid, y.grid, matrix(predicted.values.model1, n.grid, n.grid), 50, 
        main="Ordinary Kriging")
points(design.fact[,1], design.fact[,2], pch=17, cex=1.5, col="blue")
contour(x.grid, y.grid, matrix(predicted.values.model2, n.grid, n.grid), 50, 
        main="Universal Kriging")
points(design.fact[,1], design.fact[,2], pch=17, cex=1.5, col="blue")
par(mfrow=c(1,1))


# (same example) how to use the multistart argument
# -------------------------------------------------
require(foreach)

# below an example for a computer with 2 cores, but also work with 1 core

nCores <- 2
require(doParallel)
cl <-  makeCluster(nCores) 
registerDoParallel(cl)

# kriging model 1, with 4 starting points
m1_4 <- km(design=design.fact, response=y, multistart=4)

stopCluster(cl)

# -------------------------------
# A 1D example with penalized MLE
# -------------------------------

# from Fang K.-T., Li R. and Sudjianto A. (2006), "Design and Modeling for 
# Computer Experiments", Chapman & Hall, pages 145-152

n <- 6; d <- 1
x <- seq(from=0, to=10, length=n)
y <- sin(x)
t <- seq(0,10, length=100)

# one should add a small nugget effect, to avoid numerical problems
epsilon <- 1e-3
model <- km(formula<- ~1, design=data.frame(x=x), response=data.frame(y=y), 
            covtype="gauss", penalty=list(fun="SCAD", value=3), nugget=epsilon)

p <- predict(model, data.frame(x=t), "UK")

plot(t, p$mean, type="l", xlab="x", ylab="y", 
                     main="Prediction via Penalized Kriging")
points(x, y, col="red", pch=19)
lines(t, sin(t), lty=2, col="blue")
legend(0, -0.5, legend=c("Sine Curve", "Sample", "Fitted Curve"), 
       pch=c(-1,19,-1), lty=c(2,-1,1), col=c("blue","red","black"))


# ------------------------------------------------------------------------
# A 1D example with known trend and known or unknown covariance parameters
# ------------------------------------------------------------------------

x <- c(0, 0.4, 0.6, 0.8, 1);
y <- c(-0.3, 0, -0.8, 0.5, 0.9)

theta <- 0.01; sigma <- 3; trend <- c(-1,2)

model <- km(~x, design=data.frame(x=x), response=data.frame(y=y), 
            covtype="matern5_2", coef.trend=trend, coef.cov=theta, 
            coef.var=sigma^2)

# below: if you want to specify trend only, and estimate both theta and sigma:
# model <- km(~x, design=data.frame(x=x), response=data.frame(y=y), 
#             covtype="matern5_2", coef.trend=trend, lower=0.2)
# Remark: a lower bound or penalty function is useful here,
#         due to the very small number of design points...

# kriging with gaussian covariance C(x,y)=sigma^2 * exp(-[(x-y)/theta]^2), 
#         and linear trend t(x) = -1 + 2x

t <- seq(from=0, to=1, by=0.005)
p <- predict(model, newdata=data.frame(x=t), type="SK")
# beware that type = "SK" for known parameters (default is "UK")

plot(t, p$mean, type="l", ylim=c(-7,7), xlab="x", ylab="y")
lines(t, p$lower95, col="black", lty=2)
lines(t, p$upper95, col="black", lty=2)
points(x, y, col="red", pch=19)
abline(h=0)


# --------------------------------------------------------------
# Kriging with noisy observations (heterogeneous noise variance)
# --------------------------------------------------------------

fundet <- function(x){
return((sin(10*x)/(1+x)+2*cos(5*x)*x^3+0.841)/1.6)
}

level <- 0.5; epsilon <- 0.1
theta <- 1/sqrt(30); p <- 2; n <- 10
x <- seq(0,1, length=n)

# Heteregeneous noise variances: number of Monte Carlo evaluation among 
#                                a total budget of 1000 stochastic simulations
MC_numbers <- c(10,50,50,290,25,75,300,10,40,150)
noise.var <- 3/MC_numbers

# Making noisy observations from 'fundet' function (defined above)
y <- fundet(x) + noise.var*rnorm(length(x))

# kriging model definition (no estimation here)
model <- km(y~1, design=data.frame(x=x), response=data.frame(y=y), 
            covtype="gauss", coef.trend=0, coef.cov=theta, coef.var=1, 
            noise.var=noise.var)

# prediction
t <- seq(0, 1, by=0.01)
p <- predict.km(model, newdata=data.frame(x=t), type="SK")
lower <- p$lower95; upper <- p$upper95

# graphics
par(mfrow=c(1,1))
plot(t, p$mean, type="l", ylim=c(1.1*min(c(lower,y)) , 1.1*max(c(upper,y))), 
                xlab="x", ylab="y",col="blue", lwd=1.5)
polygon(c(t,rev(t)), c(lower, rev(upper)), col=gray(0.9), border = gray(0.9))
lines(t, p$mean, type="l", ylim=c(min(lower) ,max(upper)), xlab="x", ylab="y",
                 col="blue", lwd=1)
lines(t, lower, col="blue", lty=4, lwd=1.7)
lines(t, upper, col="blue", lty=4, lwd=1.7)
lines(t, fundet(t), col="black", lwd=2)
points(x, y, pch=8,col="blue")
text(x, y, labels=MC_numbers, pos=3)


# -----------------------------
# Checking parameter estimation 
# -----------------------------

d <- 3       	# problem dimension
n <- 40			# size of the experimental design
design <- matrix(runif(n*d), n, d)

covtype <- "matern5_2"		
theta <- c(0.3, 0.5, 1)		# the parameters to be found by estimation
sigma <- 2
nugget <- NULL  # choose a numeric value if you want to estimate nugget 
nugget.estim <- FALSE # choose TRUE if you want to estimate it

n.simu <- 30		# number of simulations
sigma2.estimate <- nugget.estimate <- mu.estimate <- matrix(0, n.simu, 1)
coef.estimate <- matrix(0, n.simu, length(theta))

model <- km(~1, design=data.frame(design), response=rep(0,n), covtype=covtype, 
            coef.trend=0, coef.cov=theta, coef.var=sigma^2, nugget=nugget)
y <- simulate(model, nsim=n.simu)

for (i in 1:n.simu) {
	# parameter estimation: tune the optimizer by changing optim.method, control
	model.estimate <- km(~1, design=data.frame(design), response=data.frame(y=y[i,]), 
	covtype=covtype, optim.method="BFGS", control=list(pop.size=50, trace=FALSE), 
        nugget.estim=nugget.estim) 
	
	# store results
	coef.estimate[i,] <- covparam2vect(model.estimate@covariance)
	sigma2.estimate[i] <- model.estimate@covariance@sd2
	mu.estimate[i] <- model.estimate@trend.coef
	if (nugget.estim) nugget.estimate[i] <- model.estimate@covariance@nugget
}

# comparison true values / estimation
cat("\nResults with ", n, "design points, 
    obtained with ", n.simu, "simulations\n\n",
    "Median of covar. coef. estimates: ", apply(coef.estimate, 2, median), "\n",
    "Median of trend  coef. estimates: ", median(mu.estimate), "\n", 
    "Mean of the var. coef. estimates: ", mean(sigma2.estimate))
if (nugget.estim) cat("\nMean of the nugget effect estimates: ", 
                      mean(nugget.estimate))

# one figure for this specific example - to be adapted
split.screen(c(2,1))        # split display into two screens
split.screen(c(1,2), screen = 2) # now split the bottom half into 3

screen(1)
boxplot(coef.estimate[,1], coef.estimate[,2], coef.estimate[,3], 
        names=c("theta1", "theta2", "theta3"))
abline(h=theta, col="red")
fig.title <- paste("Empirical law of the parameter estimates 
                    (n=", n , ", n.simu=", n.simu, ")", sep="")
title(fig.title)

screen(3)
boxplot(mu.estimate, xlab="mu")
abline(h=0, col="red")

screen(4)
boxplot(sigma2.estimate, xlab="sigma2")
abline(h=sigma^2, col="red")

close.screen(all = TRUE)  

# ----------------------------------------------------------
# Kriging with non-linear scaling on Xiong et al.'s function
# ----------------------------------------------------------

f11_xiong <- function(x){ 
return( sin(30 * (x - 0.9)^4) * cos(2 * (x - 0.9)) + (x - 0.9) / 2)
}

t <- seq(0, 1, , 300)
f <- f11_xiong(t)

plot(t, f, type = "l", ylim = c(-1,0.6), lwd = 2)

doe <- data.frame(x = seq(0, 1, , 20))
resp <- f11_xiong(doe)

knots <- list(x = c(0, 0.5, 1)) 
eta <- list(c(15, 2, 0.5))
m <- km(design = doe, response = resp, scaling = TRUE, gr = TRUE, 
knots = knots, covtype = "matern5_2",  coef.var = 1, coef.trend = 0)

p <- predict(m, data.frame(x = t), "UK")

plot(t, f, type = "l", ylim = c(-1, 0.6), lwd = 2)

lines(t, p$mean, col = "blue", lty = 2, lwd = 2)
lines(t, p$mean + 2 * p$sd, col = "blue")
lines(t, p$mean - 2 * p$sd, col = "blue")

abline(v = knots[[1]], lty = 2, col = "green")


# -----------------------------------------------------
# Kriging with a symmetric kernel: example with covUser
# -----------------------------------------------------

x <- c(0, 0.15, 0.3, 0.4, 0.5)
y <- c(0.3, -0.2, 0, 0.5, 0.2)

k <- function(x,y) {
  theta <- 0.15
  0.5*exp(-((x-y)/theta)^2) + 0.5*exp(-((1-x-y)/theta)^2)    
}

muser <- km(design=data.frame(x=x), response=data.frame(y=y), 
            coef.trend=0, kernel=k)

u <- seq(from=0, to=1, by=0.01)
puser <- predict(muser, newdata=data.frame(x=u), type="SK")

set.seed(0)
nsim <- 5
zuser <- simulate(muser, nsim=nsim, newdata=data.frame(x=u), cond=TRUE, nugget.sim=1e-8)
par(mfrow=c(1,1))
matplot(u, t(zuser), type="l", lty=rep("solid", nsim), col=1:5, lwd=1)
polygon(c(u, rev(u)), c(puser$upper, rev(puser$lower)), col="lightgrey", border=NA)
lines(u, puser$mean, lwd=5, col="blue", lty="dotted")
matlines(u, t(zuser), type="l", lty=rep("solid", nsim), col=1:5, lwd=1)
points(x, y, pch=19, cex=1.5)

}


