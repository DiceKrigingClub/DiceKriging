\name{cv}
\alias{cv}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Multiple fold cross validation for a km object }
\description{
  Multiple fold cross validation for a \code{km} object without noisy observations.
}
\usage{
cv(model, folds, type="UK", trend.reestim=TRUE, fast=TRUE, light=FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{model}{ an object of class "km" without noisy observations.}
  \item{folds}{ a list of index subsets without index redundancy within each fold.}
  \item{type}{ a character string corresponding to the kriging family, to be chosen between simple kriging ("SK"), or universal kriging ("UK").}
  \item{trend.reestim}{ should the trend be reestimated when removing an observation? Default to FALSE.}
  \item{fast}{ binary option to use analytical multiple fold cross validation formulae when applicable.}
  \item{light}{ binary option to force not calculating cross validation residual covariances between different folds (relevant, e.g., when performing speed comparisons across baseline versus fast settings).}
}

%\details{
%  Leave-one-out (LOO) consists of computing the prediction at a design point when the corresponding observation is removed from the learning set (and this, for all design points). A quick version of LOO based on Dubrule formula is also implemented; It is limited to 2 cases: \code{type=="SK" & (!trend.reestim)} and \code{type=="UK" & trend.reestim}. Leave-one-out is not implemented yet for noisy observations.}
  
\section{Warning}{
 Kriging parameters are not re-estimated when removing observations. With few points in the learning set, the re-estimated values can be far from those obtained with the entire learning set. One option is to reestimate the trend coefficients, by setting \code{trend.reestim=TRUE}.
}

\value{ A list composed of
  \item{mean }{ a list of cross validation mean predictions with same number of elements and respective dimensions than in folds. The ith element is equal to the kriging mean (including the trend) at the ith fold number when it is left out of the design, }
  \item{y }{ a vector of actual responses,}
  \item{cvcov.list }{ a list of cross validation conditional covariance matrices with same number of elements than in folds and dimensions set accordingly. The ith element is equal to the kriging covariance matrix corresponding to the ith fold number when it is left out of the design,}
  \item{cvcov.mat }{ a ntot*ntot matrix containing all covariances between cross-validation errors (stacked with respect to orders between and within folds),}
where ntot is the total number of points in the folds list (with possible point redundancies as some points may belong to several folds). 
%Let us remark that block diagonal elements of CVcov are redundant with...
}

\references{ 

F. Bachoc (2013), Cross Validation and Maximum Likelihood estimations of hyper-parameters of Gaussian processes with model misspecification. \emph{Computational Statistics and Data Analysis}, \bold{66}, 55-69. 

N.A.C. Cressie (1993), \emph{Statistics for spatial data}, Wiley series in probability and mathematical statistics.

O. Dubrule (1983), Cross validation of Kriging in a unique neighborhood. \emph{Mathematical Geology}, \bold{15}, 687-699.

J. Gallier. The schur complement and symmetric positive semidefinite (and defiite) matrices. Retrieved at \url{http://www.cis.upenn.edu/~jean/schur-comp.pdf}.

D. Ginsbourger and C. Schaerer (2021). Fast calculation of Gaussian Process multiple-fold cross-validation residuals and their covariances. 
arXiv:2101.03108 [stat.ME].

J.D. Martin and T.W. Simpson (2005), Use of kriging models to approximate deterministic computer models, \emph{AIAA Journal}, \bold{43} no. 4, 853-863.

M. Schonlau (1997), \emph{Computer experiments and global optimization}, Ph.D. thesis, University of Waterloo.	
	
}

\author{ D. Ginsbourger, University of Bern. }

\seealso{ \code{\link{predict,km-method}},  \code{\link{leaveOneOut.km}} }

\keyword{models}
\examples{
# -------------------------------------------------
# A 1D example illustrating leave-one-out residuals 
# and their correlation 
# -------------------------------------------------

# Test function (From Xiong et al. 2007; See scalingFun's doc) 
myfun <- function(x){ 
  sin(30 * (x - 0.9)^4) * cos(2 * (x - 0.9)) + (x - 0.9) / 2
}
t <- seq(from = 0, to = 1, by = 0.005)
allresp <- myfun(t)
par(mfrow = c(1, 1), mar = c(4, 4, 2, 2))
plot(t, allresp, type = "l")

# Design points and associated responses 
nn <- 10
design <- seq(0, 1, length.out = nn)
y <- myfun(design)
points(design, y, pch = 19)

# Model definition and GP prediction (Kriging)
set.seed(1)
model1 <- km(design = data.frame(design = design), 
             response = data.frame(y = y), nugget = 1e-5)
pred1 <- predict(model1, newdata = data.frame(design = t), type = "UK") 
lines(t, pred1$mean, type = "l", col = "blue", lty = 2, lwd = 2)

# Plotting the prediction error versus the GP standard deviation 
par(mfrow = c(2,1))
pred_abserrors <- abs(allresp - pred1$mean)
plot(t, pred_abserrors, type = "l", ylab = "abs pred error")
plot(t, pred1$sd, type = "l", ylab = "GP prediction sd")

# Leave-one-out cross-validation with the cv function 
loofolds <- as.list(seq(1, length(design)))
loo1 <- cv(model = model1, folds = loofolds, type = "UK", 
              trend.reestim = TRUE, fast = TRUE, light = FALSE) 

# y axis limits need to be taken care of 
plotCVmean <- function(cvObj){
  cvObjMean <- unlist(cvObj$mean)
  plot(t, allresp, type = "l", ylim = range(cvObjMean, allresp))
  points(design, y, pch = 19)
  lines(t, pred1$mean, type = "l", col = "blue", lty = 2, lwd = 2)
  points(design, cvObjMean, col = "red", pch = 22, lwd = 2)
}
plotCVsd <- function(cvObj, ylim){
  cv_abserrors <- abs(y - unlist(cvObj$mean))
  plot(t, pred_abserrors, type = "l", ylab = "abs pred error", 
       ylim = ylim)
  points(design, cv_abserrors, col = "red", pch = 22, lwd = 2)
  lines(t, pred1$sd, ylab = "GP prediction sd", col = "blue", 
      lty = 2, lwd = 2)
}

loo1Mean <- unlist(loo1$mean)
loo_abserrors <- abs(y - loo1Mean)
ylim <- c(0, max(loo_abserrors, pred_abserrors))

plotCVmean(loo1)
plotCVsd(loo1, ylim = ylim)

# Calculation of uncorrelated CV residuals and corresponding qqplot 
T <- model1@T
B <- diag(as.numeric(diag(loo1$cvcov.mat))^(-1))
res <- y - loo1Mean
stand <- T \%*\% B \%*\% res
opar <- par(mfrow = c(1, 2))
qqnorm(stand, 
       main = "Normal Q-Q Plot of uncorrelated LOO Residuals")
abline(a = 0, b = 1)

# Comparison to "usual" standardized LOO residuals
usual_stand <- diag(as.numeric(diag(loo1$cvcov.mat))^(-1/2)) \%*\% res
qqnorm(usual_stand, 
       main = "Normal Q-Q Plot of Standardized LOO Residuals") 
abline(a = 0, b = 1)
par(opar)

# Calculation and plot of correlations between most left 
# and other cross-validation residuals 
cvcov.mat <- loo1$cvcov.mat
coco <- cov2cor(cvcov.mat)
par(mfrow = c(1, 1))
plot(coco[1, ], type = "h", ylim = c(-1, 1), lwd = 2,
     main = "Correlation between first and other LOO residuals", 
     ylab = "Correlation")
points(coco[1, ])
abline(h = 0, lty = "dotted")
     
par(mfrow = c(1, 1), mar = c(5.1, 4.1, 4.1, 2.1))

# ------------------------------------------------
# Same example with multiple-fold cross validation 
# under various settings
# ------------------------------------------------

# First with successive two-element folds 
myfolds <- list(c(1, 2), c(3, 4), c(5, 6), c(7, 8), c(9, 10))
cv_2fold <- cv(model = model1, folds = myfolds, type = "SK", 
               trend.reestim = FALSE, fast = TRUE, light = FALSE)  
cv_2fold

opar <- par(mfrow = c(2,1))
plotCVmean(cv_2fold)
plotCVsd(cv_2fold, ylim = ylim)


# With overlapping two-element folds 
myfolds <- list(c(1, 3), c(2, 4), c(3, 5), c(4, 6), 
                c(5, 7), c(6, 8), c(7, 9), c(8, 10))
cv_2fold_overlap <- cv(model = model1, folds = myfolds, type = "UK", 
                       trend.reestim = TRUE, fast = TRUE, light = FALSE)
cv_2fold_overlap


# With a three-fold partition 
myfolds <- list(c(1, 2, 3), c(4, 5, 6, 7), c(8, 9, 10))
cv_3fold <- cv(model = model1, folds = myfolds, type = "UK", 
           trend.reestim = TRUE, fast = TRUE, light = FALSE)
cv_3fold

plotCVmean(cv_3fold)
plotCVsd(cv_3fold, ylim = ylim)
par(opar)

}
