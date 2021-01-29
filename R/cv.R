cv <- function (model, folds, type="UK", trend.reestim =TRUE, 
                fast=TRUE, light=FALSE){
  if (!is.list(folds)){
    stop("The input `folds' must be a list of index subsets (without index redundancy within each fold)")
  }
  if (length(model@noise.var) > 0) {
    stop("At this stage, cross-validation is not implemented for noisy observations")
  }
  q <- length(folds) 
  case1 <- ((type == "SK") && (!trend.reestim))
  case2 <- ((type == "UK") && (trend.reestim))
  analytic <- (case1 | case2) && fast
  X <- model@X
  y <- model@y
  T <- model@T
  n <- model@n
  yhat <- list()
  cvcov.list <- list()
  beta <- model@trend.coef
  F <- model@F 
  if (!analytic) {
  C <- crossprod(T) 
  for (i in 1:q) {
    I <- folds[[i]]
    F.I <- F[I,,drop=FALSE]#t(matrix(F[I, ]))
    y.but.I <- y[-I, ]
    F.but.I <- F[-I, ]
    C.but.I <- C[-I, -I]
    c.but.I <- C[-I, I]
    T.but.I <- chol(C.but.I)
    x <- backsolve(t(T.but.I), y.but.I, upper.tri = FALSE)
    M <- backsolve(t(T.but.I), F.but.I, upper.tri = FALSE)
    M <- as.matrix(M)
    if (trend.reestim) {
      l <- lm(x ~ M - 1)
      beta <- as.matrix(l$coef, ncol = 1)
    }
    z <- x - M %*% beta
    Tinv.c <- backsolve(t(T.but.I), c.but.I, upper.tri = FALSE)
    y.predict.complement <- t(Tinv.c) %*% z
    y.predict.trend <- F.I %*% beta
    y.predict <- y.predict.trend + y.predict.complement
    yhat[[i]] <- y.predict
    cvcov.1 <- crossprod(Tinv.c)
    totalcov <- C[I, I] 
    cvcov.list[[i]] <- totalcov - cvcov.1
    if (type == "UK") {
      T.M <- chol(crossprod(M)) #chol(t(M) %*% M)
      cvcov.2 <- backsolve(t(T.M), t(F.I - t(Tinv.c) %*% M), upper.tri = FALSE)
      cvcov.list[[i]] <- cvcov.list[[i]] + crossprod(cvcov.2)
    }
  }
  res <- list("mean" = yhat, "y"=y, "cvcov.list" = cvcov.list) 
}
  else {
    Cinv <- chol2inv(T)
    if (trend.reestim & (type == "UK")) {
      M <- model@M #NB: M	is a matrix equal to inv(t(T))*F.
      Cinv.F <- Cinv %*% F
      T.M <- chol(crossprod(M))
      aux <- backsolve(t(T.M), t(Cinv.F), upper.tri = FALSE)
      Q <- Cinv - crossprod(aux)
      Q.y <- Q %*% y
    }
    else if ((!trend.reestim) & (type == "SK")) {
      Q <- Cinv
      Q.y <- Q %*% (y - F %*% beta)
    }
    for (i in 1:q) {
      I <- folds[[i]]
      TQ.I <- chol(Q[I,I])
      invblock <- chol2inv(TQ.I)
      cvcov.list[[i]] <- invblock
      epsilon <- invblock%*%Q.y[I]
      yhat[[i]] <- y[I]-epsilon
    }
  if(light==FALSE){
ntot <- sum(lengths(folds))
cvcov.mat <- matrix(NA,ntot,ntot)
inds <- c(0,cumsum(lengths(folds)))
  for (i in 1:q) {
    for (j in i:q) {
      I <- folds[[i]]
      J <- folds[[j]]
      cvcov.mat[(inds[i]+1):inds[i+1],(inds[j]+1):inds[j+1]] <- cvcov.list[[i]] %*% Q[I,J] %*% cvcov.list[[j]]
      cvcov.mat[(inds[j]+1):inds[j+1],(inds[i]+1):inds[i+1]] <- t(cvcov.mat[(inds[i]+1):inds[i+1],(inds[j]+1):inds[j+1]]) 
    }
  }
# TO ADD: (OPTIONAL) calculation of de-correlated CV residuals 
# i.e. matrix A (based on T[folds,] and B^{-1})
# NB: one can check that using chol(CVcov) delivers the same...(or directly take that path!)
# NB: one should check for invertibility (K=n, etc). Or appeal to SVD and pseudo-inverse? 
#if(K==n){
#chol(CVcov)
#}
    res <- list("mean" = yhat, "y"=y, "cvcov.list" = cvcov.list, 
                "cvcov.mat" = cvcov.mat, "Q"=Q)
# cvcov.mat is a matrix with diagonal blocks corresponding to the list cvcov.list
# More could be added to the output list, e.g., uncorrelated resid. (when available)?

  }else{
    res <- list("mean" = yhat, "y"=y, "cvcov.list" = cvcov.list) 
  }
  }
return(res) 
}