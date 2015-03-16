#
# Functions that do tests on passed formulas
# 

# Note that we use dots in the two next functions as in all the other is.xx 
# functions
# s
#'@export
is.formulr <- function(obj) {
  return('formulr' %in% class(obj))
}
#'@export
is.eval.formulr <- function(obj) {
  return('eval.formulr' %in% class(obj))
}


# Test if a formulr/formula objects has groups
#'@export
formulr.has <- function(element) { 
  function(form) { 
    form <- .check_convert(form)
    if (all(is.na(form[[element]])) && length(form[[element]] == 1)) { 
      return(FALSE)
    } else { 
      return(TRUE)
    }
  }
}
#'@export
has.x <- formulr.has('x')
#'@export
has.y <- formulr.has('y')
#'@export
has.g <- formulr.has('g')


# Check if formulr and if not, converts it
.check_convert <- function(form) {
  if (!is.formulr(form)) form <- as.formulr(form)
  return(form)
}

# Check and stop if not a formulr
.check_is_formulr <- function(form) {
  if (!is.formulr(form)) {
    stop('Object is not of class formulr')
  }
}

# Check and stop if not an eval'ed formulr
.check_is_eval_formulr <- function(form) {
  if (!is.eval.formulr(form)) {
    stop('Object is not of class eval.formulr')
  }
}
