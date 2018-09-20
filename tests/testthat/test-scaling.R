require("DiceKriging")
require("testthat")
source("test-km.R")

set.seed(1)

# a 16-points factorial design, and the corresponding response
d <- 2; n <- 16
design.fact <- expand.grid(x1=seq(0,1,length=4), x2=seq(0,1,length=4))
y <- apply(design.fact, 1, branin)

context("Checking km scaling: 2D example - Branin-Hoo function")

# kriging model 1 : matern5_2 covariance structure, no trend, no nugget effect
m1 <- km(design=design.fact, response=y,control=list(trace=FALSE),scaling=TRUE)

test_that.km(m1,trend.coef = 279.2024,covariance.sd2 = 99777.04,covariance.eta = matrix(c(2.1286391 ,  0.5,0.5116505 , 0.5),ncol=2))


context("Checking km scaling: same number of nodes per dimension")

design.fact <- expand.grid(aa=seq(0,1,length=4), ba=seq(0,1,length=4),ac=seq(0,1,length=4))
y <- apply(design.fact, 1, function(x)branin(x[1:2])*x[3])

set.seed(12)
# kriging model 1 : matern5_2 covariance structure, no trend, no nugget effect
m20 <- km(design=design.fact, response=y,control=list(trace=FALSE),scaling=TRUE, knots = list(c(0,1),c(0,1),c(0,1)))

test_that.km(m20,trend.coef = 141.1660,covariance.sd2 = 116233.75, precision=1e-3)


context("Checking km scaling: different number of nodes per dimension (not passing with DiceKriging 1.5-4)")

design.fact <- expand.grid(aa=seq(0,1,length=4), ba=seq(0,1,length=4),ac=seq(0,1,length=4))
y <- apply(design.fact, 1, function(x)branin(x[1:2])*x[3])

set.seed(12)
# kriging model 1 : matern5_2 covariance structure, no trend, no nugget effect
m2 <- km(design=design.fact, response=y,control=list(trace=FALSE),scaling=TRUE, knots = list(c(0,1),c(0,1),c(0,.5,1)))

test_that.km(m2,trend.coef = 127.2252,covariance.sd2 = 85424.41, precision=1e-3)



context("Checking km scaling with 1 node (not passing with DiceKriging 1.5-4)")

design.fact <- matrix(runif(1000),ncol=2)
y <- apply(design.fact, 1, branin)

set.seed(123)
m_noScaling <- km(design=design.fact, response=y,scaling=F,control=list(trace=FALSE))

set.seed(123)
m_scaling1 <- km(design=design.fact, response=y,scaling=T,knots=list(X1=0,X2=0),control=list(trace=FALSE))

# Check that 1/eta ~ theta
test_that(desc="scaling:1/eta ~ theta",expect_true(max(abs(m_noScaling@covariance@range.val - 1/unlist(m_scaling1@covariance@eta))) < 0.1))

           

context("Checking without parameter estimation, by comparing prediction with standard Kriging and scaling with 1 knot (eta = 1/theta)")

design.fact <- matrix(runif(1000),ncol=2)
y <- apply(design.fact, 1, branin)

m_noScaling <- km(design=design.fact, response=y,scaling=F,coef.var = 1, coef.cov = c(.1,.1),control=list(trace=FALSE))

# Force 1/eta = theta (exactly)
m_scaling1 <- km(design=design.fact, response=y,scaling=T,coef.var = 1, coef.cov = list(X1=10,X2=10),knots=list(X1=0,X2=0),control=list(trace=FALSE))

pred_noScaling = predict(m_noScaling,newdata=matrix(.5,ncol=2),type="UK")
pred_scaling1 = predict(m_scaling1,newdata=matrix(.5,ncol=2),type="UK")

test_that(desc="scaling:predict identical when 1/eta = theta",expect_true(abs(pred_noScaling$mean - pred_scaling1$mean)<1E-5))
test_that(desc="scaling:predict identical when 1/eta = theta",expect_true(abs(pred_noScaling$sd == pred_scaling1$sd)<1E-5))

