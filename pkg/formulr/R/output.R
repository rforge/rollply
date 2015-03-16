# Convert back formulr to useful data structures ----------
# 
#'@export
as.data.frame.formulr <- function(form, 
                                  strip=TRUE, 
                                  collapse=FALSE) {
  .check_is_eval_formulr(form) # check class
  
  # Strip non-existent 
  if (strip) {
    form <- form[c(has.y(form), has.x(form), has.g(form))]
  }
  
  out <- lapply(form, data.frame)
  
  if (collapse) {
    out <- do.call(data.frame, out)
    names(out) <- unlist(lapply(form, names))
  }
  
  return(out)
}

