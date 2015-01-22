

#'@export
eval.formulr <- function(formulr, envir, enclos=NULL) { 
  for (n in c('y','x','g')) {
    tmp <- lapply(formulr[[n]], eval, envir, enclos)
    names(tmp) <- names(formulr[[n]])
    formulr[[n]] <- tmp
  }
  class(formulr) <- c('formulr', 'eval.formulr')
  formulr
}
