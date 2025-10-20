\name{update}
\alias{update}
\alias{update.km}
\alias{update,km-method}
\title{Update of a kriging model}

\description{
Update a \code{\link[DiceKriging]{km}} object when one or many new
observations are added. Many,  but not all, fields of the
\code{\link[DiceKriging]{km}} object  need to be recalculated when new observations are added. 
It is also possible to modify the k last (existing) observations.
}

\usage{
\S4method{update}{km}(object, newX, newy, newX.alreadyExist = FALSE,
          cov.reestim = TRUE, trend.reestim = TRUE, nugget.reestim = FALSE, 
          newnoise.var = NULL, kmcontrol = NULL, newF = NULL,...)
}

\arguments{
  \item{object}{Kriging model of \code{\link[DiceKriging]{km}} class.}

  \item{newX}{Matrix with \code{object@d} columns and r rows
  corresponding to the r locations of  the observations to be
  updated. These locations can be new  locations or existing ones.}

  \item{newy}{Matrix with one column and r rows corresponding to the r
  responses at the r  locations \code{newX}.}
  
  \item{newX.alreadyExist}{Boolean: indicate whether the locations \code{newX} are all news or not.}
  
  \item{cov.reestim}{Should the covariance parameters
  of the \code{\link[DiceKriging]{km}} object be re-estimated?}

  \item{trend.reestim}{Should the trend parameters be re-estimated?}
  
  \item{nugget.reestim}{Should the nugget effect be re-estimated?}

  \item{newnoise.var}{Vector containing the noise variance at each new observations.}
	  
  \item{kmcontrol}{Optional list representing the control variables for
  the re-estimation  of the kriging model once new points are
  sampled. The items are the  same as in \code{\link[DiceKriging]{km}}}
  
  \item{newF}{Optional matrix containing the value of the trend at the
    new locations.  Setting this argument avoids a call to an expensive function.}

  \item{...}{Further arguments}
}

\value{
  Updated km object
}

\references{
  Bect J., Ginsbourger D., Li L., Picheny V., Vazquez E. (2010),
  \emph{Sequential design of  computer experiments for the estimation of
  a probability of failure},  Statistics and Computing, pp.1-21, 2011, \url{https://arxiv.org/abs/1009.5177}
  
  Chevalier C., Bect J., Ginsbourger D., Vazquez E., Picheny V., Richet
  Y. (2011),  \emph{Fast parallel kriging-based stepwise uncertainty
  reduction with  application to the identification of an excursion
  set},  \url{https://hal.science/hal-00641108/}
}
\author{ 
  Clement Chevalier (IMSV, Switzerland, and IRSN, France)
}

\seealso{\code{\link[DiceKriging]{km}}}

\examples{
set.seed(8)
N <- 9 # number of observations
testfun <- branin

# a 9 points initial design 
design <- expand.grid(x1=seq(0,1,length=3), x2=seq(0,1,length=3))
response <- testfun(design)

# km object with matern3_2 covariance
# params estimated by ML from the observations
model <- km(formula = ~., design = design, 
	response = response, covtype = "matern3_2")
model@covariance

newX <- matrix(c(0.4,0.5), ncol = 2) #the point that we are going to add in the km object
newy <- testfun(newX)
newmodel <- update(object = model, newX = newX, newy = newy, cov.reestim = TRUE)
newmodel@covariance
}

