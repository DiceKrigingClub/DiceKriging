#Goal: check that the cv.R function is self-consistent and consistent with leaveOneOut
#Main example: a simple 1-d Simple/Ordinary/Universal Kriging case from DK's help
library("DiceKriging")
library("testthat")
tol <- 1e-5
##################################################
# Extracted from ?predict.km
x <- c(0, 0.4, 0.6, 0.8, 1)
y <- c(-0.3, 0, 0, 0.5, 0.9)
formula <-  y~x # y~1   # try also   y~x  and  y~x+I(x^2)

model <- km(formula=formula, design=data.frame(x=x), response=data.frame(y=y), 
            covtype="matern5_2")

tmin <- -0.5; tmax <- 2.5
t <- seq(from=tmin, to=tmax, by=0.005)

# Results with Universal Kriging formulae (mean and and 95% intervals)
p.UK <- predict(model, newdata=data.frame(x=t), type="UK")

##################################################
#
# From there, a sequence of small checkings are performed with the following aims:
# 1. Check that the fast and non-fast versions of cv arrive at the same result
# a) SK case (without parameter restimation), 
# b) UK case (with parameter restimation),
# both in the case where myfolds <- list(c(1,2),c(3,4,5)) [variations welcome!]
# 
# 2. Check that cv reproduces the results of LeaveOneOut.km in the case where 
# myfolds <- list(c(1),c(2),c(3),c(4),c(5))
# a) SK case (without parameter restimation), 
# b) UK case (with parameter restimation).
#
# Let us start with 1.
myfolds <- list(c(1,2),c(3,4,5))
# 1.a)
lkO1a <- cv(model=model, folds=myfolds, type="SK", trend.reestim = FALSE, fast=FALSE)
lkO1a_f <- cv(model=model, folds=myfolds, type="SK", trend.reestim = FALSE, fast=TRUE)
#lkO1a$mean[[1]]-lkO1a_f$mean[[1]]
#lkO1a$mean[[2]]-lkO1a_f$mean[[2]]
#lkO1a$cvcov.list[[1]]-lkO1a_f$cvcov.list[[1]]
#lkO1a$cvcov.list[[2]]-lkO1a_f$cvcov.list[[2]]
SKmean_ratio_1 <- (lkO1a$mean[[1]]-lkO1a_f$mean[[1]])/lkO1a$mean[[1]]
SKmean_ratio_2 <- (lkO1a$mean[[2]]-lkO1a_f$mean[[2]])/lkO1a$mean[[2]]
SKcov_ratio_1 <- (lkO1a$cvcov.list[[1]]-lkO1a_f$cvcov.list[[1]])/lkO1a$cvcov.list[[1]]
SKcov_ratio_2 <- (lkO1a$cvcov.list[[2]]-lkO1a_f$cvcov.list[[2]])/lkO1a$cvcov.list[[2]]
test_that("SK means coincide in first fold", max(abs(SKmean_ratio_1))<tol)
test_that("SK means coincide in second fold", max(abs(SKmean_ratio_2))<tol)
test_that("SK covariances coincide in first fold", max(abs(SKcov_ratio_1))<tol)
test_that("SK covariances coincide in second fold", max(abs(SKcov_ratio_2))<tol)

# 1.b)
lkO1b <- cv(model=model, folds=myfolds, type="UK", trend.reestim = TRUE, fast=FALSE)
lkO1b_f <- cv(model=model, folds=myfolds, type="UK", trend.reestim = TRUE, fast=TRUE)
#lkO1b$mean[[1]]-lkO1b_f$mean[[1]]
#lkO1b$mean[[2]]-lkO1b_f$mean[[2]]
#lkO1b$cvcov.list[[1]]-lkO1b_f$cvcov.list[[1]]
#lkO1b$cvcov.list[[2]]-lkO1b_f$cvcov.list[[2]]
UKmean_ratio_1 <- (lkO1b$mean[[1]]-lkO1b_f$mean[[1]])/lkO1b$mean[[1]]
UKmean_ratio_2 <- (lkO1b$mean[[2]]-lkO1b_f$mean[[2]])/lkO1b$mean[[2]]
UKcov_ratio_1 <- (lkO1b$cvcov.list[[1]]-lkO1b_f$cvcov.list[[1]])/lkO1b$cvcov.list[[1]]
UKcov_ratio_2 <- (lkO1b$cvcov.list[[2]]-lkO1b_f$cvcov.list[[2]])/lkO1b$cvcov.list[[2]]
test_that("UK means coincides in first fold", max(abs(UKmean_ratio_1))<tol)
test_that("UK means coincides in second fold", max(abs(UKmean_ratio_2))<tol)
test_that("UK covariances coincide in first fold", max(abs(UKcov_ratio_1))<tol)
test_that("UK covariances coincide in second fold", max(abs(UKcov_ratio_2))<tol)


# Now turn to 2. 
myfolds <- list(c(1),c(2),c(3),c(4),c(5))
# 2.a)
lkO2a <- cv(model=model, folds=myfolds, type="SK", trend.reestim = FALSE, fast=TRUE)
lOO2a <- leaveOneOut.km(model=model, type="SK", trend.reestim = FALSE)
SKmean_ratio_LOO <- (matrix(as.numeric(lkO2a$mean))-matrix(lOO2a$mean))/matrix(lOO2a$mean)
SKvar_ratio_LOO <- (matrix(as.numeric(lkO2a$cvcov.list))-lOO2a$sd^2)/lOO2a$sd^2
test_that("SK LOO means coincide", max(abs(SKmean_ratio_LOO))<tol)
test_that("SK LOO variances coincide", max(abs(SKvar_ratio_LOO))<tol)

# 2.b)
lkO2b <- cv(model=model, folds=myfolds, type="UK", trend.reestim = TRUE, fast=TRUE)
lOO2b <- leaveOneOut.km(model=model, type="UK", trend.reestim = TRUE)
UKmean_ratio_LOO <- (matrix(as.numeric(lkO2b$mean))-matrix(lOO2b$mean))/matrix(lOO2b$mean)
UKvar_ratio_LOO <- (matrix(as.numeric(lkO2b$cvcov.list))-lOO2b$sd^2)/lOO2b$sd^2
test_that("SK LOO means coincide", max(abs(UKmean_ratio_LOO))<tol)
test_that("SK LOO variances coincide", max(abs(UKvar_ratio_LOO))<tol)


# Want to add your tests? 
# You are all welcome + e-mail me in case of successes + failures ;-) David. 

