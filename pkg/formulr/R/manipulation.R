
# Retrieve elements from a formulr ----------
formulr.get <- function(element) { 
  function(form) {
    form <- .check_convert(form)
    if (all(is.na(form[[element]]))) { 
      return(NA)
    } else {
      return(form[[element]])
    }
  }
}

#'@export
form.x <- formulr.get('x')
#'@export
form.y <- formulr.get('y')
#'@export
form.g <- formulr.get('g')

# Set elements of a formulr ----------
formulr.set <- function(element) { 
  function(form, value) {
    .check_is_formulr(form)
    form[[element]] <- value
    return(form)
  }
}
#'@export
`form.x<-` <- formulr.set('x')
#'@export
`form.y<-` <- formulr.set('y')
#'@export
`form.g<-` <- formulr.set('g')
