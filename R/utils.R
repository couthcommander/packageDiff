#' Message Suppressor
#'
#' Suppress messages and warnings.
#'
#' @param cmd R command to run.
suppresser <- function(cmd) {
  suppressMessages(suppressWarnings(cmd))
}

#' Extract Package Information
#'
#' Evaluate R scripts in protected environment.
#'
#' @param files Vector of file names.
sourcerer <- function(files) {
  e <- new.env()
  for(i in seq_along(files)) {
    f <- files[i]
    if(file.exists(f)) {
      suppresser(sys.source(f, e, keep.source = FALSE))
    }
  }
  e
}
