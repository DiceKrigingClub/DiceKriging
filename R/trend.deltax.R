trend.deltax <- function(x, model, h=sqrt(.Machine$double.eps)){
  
  n <- model@n
  d <- model@d
  
  x <- matrix(x, nrow=1)
  if (length(x)!=d) {
    stop("x must be a vector")
  }
  names.x <- colnames(model@X)
  colnames(x) <- names.x
  rownames(x) <- NULL

  formula <- model@trend.formula
  
  if (formula==~1){ # OK case
    grad.intercept <- matrix(0, nrow=1, ncol=d,
                             dimnames=list("(Intercept)", 1:d))
    return(grad.intercept)      
  } 
  
  formula.lin <- drop.response(~., data=data.frame(x))
  formula.lin2inter <- drop.response(~.^2, data=data.frame(x))
  quad.labels <- paste0("I(", attr(terms(formula.lin), "term.labels"), "^2)", collapse="+")
  formula.linQuad <- update(formula.lin, as.formula(paste0("~.+", quad.labels)))
  
  formula.lin.label <- attr(terms(formula.lin), "term.labels")
  formula.lin2inter.label <- attr(terms(formula.lin2inter), "term.labels")
  formula.linQuad.label <- attr(terms(formula.linQuad), "term.labels")
  formula.label <- attr(terms(formula), "term.labels")
  
  caseLin <- setequal(formula.label, formula.lin.label)
  caseLin2inter <- setequal(formula.label, formula.lin2inter.label)
  caseLinQuad <- setequal(formula.label, formula.linQuad.label)
  caseAnalytical <- caseLin | caseLin2inter | caseLinQuad

  if (caseAnalytical) {
    grad.intercept <- matrix(0, nrow=1, ncol=d,
                             dimnames=list("(Intercept)", 1:d))
    grad.lin <- diag(d)
    rownames(grad.lin) <- names.x
    if (caseLin) {
      return(rbind(grad.intercept, grad.lin))
    }  
    if (caseLinQuad){
      grad.quad <- diag(2 * as.vector(x))
      grad.linQuad <- rbind(grad.lin, grad.quad)
      rownames(grad.linQuad) <- formula.linQuad.label
      return(rbind(grad.intercept, grad.linQuad))
    }
    if (caseLin2inter){
      grad.lin2inter <- grad.lin
      for (j in 1:(d-1)){
        A <- matrix(0, nrow = d-j, ncol = d)
        A[, j] <- x[(j+1):d]
        A[, (j+1):d] <- diag(x[j], nrow = d-j, ncol = d-j)
        grad.lin2inter <- rbind(grad.lin2inter, A)
      }
      rownames(grad.lin2inter) <- formula.lin2inter.label
      return(rbind(grad.intercept, grad.lin2inter))
    } 
  } # end analytic cases

  A <- matrix(x, nrow=d, ncol=d, byrow=TRUE)
  colnames(A) <- colnames(x)
  Apos <- A+h*diag(d)
  Aneg <- A-h*diag(d)
  newpoints <- data.frame(rbind(Apos, Aneg))
  f.newdata <- model.matrix(model@trend.formula, data = newpoints)
  f.deltax <- (f.newdata[1:d,]-f.newdata[(d+1):(2*d),])/(2*h)
  f.deltax <- t(f.deltax) 
  
  return(f.deltax)

}