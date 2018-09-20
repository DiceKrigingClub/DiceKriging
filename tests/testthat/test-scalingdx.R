require("DiceKriging")
require("testthat")

context("Checking scalingFun.dx analytical calculation equals numerical result")

knots <- c(0, .5, 1)
eta <- c(10.5, .5, 1.75)
f <- function(x) scalingFun1d(x, knots, eta)
dfdx_a <- function(x) scalingFun1d.dx(x, knots, eta)
dfdx_num <- function(x) numDeriv::grad(function(xx) scalingFun1d(matrix(xx, nrow = 1), knots, eta, x))

for (x in runif(10)) {
  dfdx_ax <- dfdx_a(x)
  dfdx_numx <- dfdx_num(x)
  test_that(desc = paste0("numerical derivative equals analytical at x=", x, " : ",dfdx_ax,"!=", dfdx_numx),
            expect_true(abs(dfdx_ax - dfdx_numx) < 1E-3))
}

