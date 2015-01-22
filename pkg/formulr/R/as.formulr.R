
#'@export
as.formulr <- function(form,
                       ...) { # passed to text_parser
  
  # Do nothing if already a formulr
  if ('formulr' %in% class(form)) 
    return(form)
  # Return NULL if NULL
  if (is.null(form)) 
    return(NULL)
  
  UseMethod("as.formulr")
}


# Parses a formula and converts is to a a formulr object
#'@export
as.formulr.formula <- function(form) { 
  #
  # Note that we use 
  text <- gsub(' ', '', deparse(form))
  
  # Retrieve groups component
  group.split <- splitter('\\|','xy','g')(text)
  g <- list(g=group.split[['g']])
  
  # Separate x and y
  xy.split <- splitter('~','y','x')(group.split[['xy']])
  
  # Build formulr
  formulr <- c(xy.split, g)
  
  # Build quoted variables
  formulr <- lapply(formulr, function(e) as.formula(paste0("~",e)))
  formulr <- lapply(formulr, plyr::as.quoted)
  
  class(formulr) <- c('formulr')
  return(formulr)
}

splitter <- function(sep,left,right) {
  # init
  function(text) {
    out <- list(text, NA_character_)
    
    if (grepl(sep,text)) {
      t.split <- strsplit(text, sep)[[1]]
      t.split <- ifelse(t.split=='', NA_character_, t.split) # in case nothing next to separator
      out <- as.list(t.split)
    }
    names(out) <- c(left, right)
    return(out)
  }
}
