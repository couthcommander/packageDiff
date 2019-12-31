#' Message Suppressor
#'
#' Suppress messages and warnings.
#'
#' @keywords internal
#' @param cmd R command to run.
suppresser <- function(cmd) {
  suppressMessages(suppressWarnings(cmd))
}

#' Source Many R Scripts
#'
#' Evaluate R scripts in protected environment.
#'
#' This may fail if Collate is incorrect.
#'
#' @keywords internal
#' @param files Vector of file names.
#' @param envir Default environment.
sourcerer <- function(files, envir = NULL) {
  if(is.null(envir)) {
    e <- new.env()
  } else {
    e <- envir
  }
  badfiles <- character(0)
  for(i in seq_along(files)) {
    f <- files[i]
    if(file.exists(f)) {
      badlist <- character(0)
      repeat {
        # r is NULL if no error occurs or error could not be prevented
        # r equals 1 if error was prevented
        r <- tryCatch(suppresser(sys.source(f, e, keep.source = FALSE)), error = function(er) {
          if(grepl("could not find function", er)) {
            noFun <- sub('.*could not find function "(.*)".*', '\\1', er)
            e[[noFun]] <- function(...) NULL
            badlist[length(badlist)+1] <<- noFun
          } else if(grepl("object .* not found", er)) {
            noObj <- sub(".*object '(.*)' not found.*", '\\1', er)
            e[[noObj]] <- function(...) NULL
            badlist[length(badlist)+1] <<- noObj
          } else {
            badfiles[length(badfiles)+1] <<- f
            return(NULL)
          }
          1
        })
        if(is.null(r)) break
      }
      # remove from environment
      if(length(badlist)) {
        rm(list = badlist, envir = e)
      }
    }
  }
  fails <- logical(length(badfiles))
  for(i in seq_along(badfiles)) {
    pd <- parse(badfiles[i])
    for(j in seq_along(pd)) {
      tryCatch(eval(pd[j], envir = e), error = function(er) {
        fails[i] <<- TRUE
      })
    }
  }
  badfiles <- basename(badfiles[fails])
  if(length(badfiles)) {
    warning(sprintf('some files partially failed to parse: %s', paste(badfiles, collapse = ',')))
  }
  e
}
