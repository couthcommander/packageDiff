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
#' This may fail if Collate is incorrect.
#'
#' @param files Vector of file names.
sourcerer <- function(files) {
  e <- new.env()
  for(i in seq_along(files)) {
    f <- files[i]
    if(file.exists(f)) {
      repeat {
        # r is NULL if no error occurs
        # r equals 1 if error was prevented
        r <- tryCatch(suppresser(sys.source(f, e, keep.source = FALSE)), error = function(er) {
          if(grepl("could not find function", er)) {
            noFun <- sub('.*could not find function "(.*)".*', '\\1', er)
            # find function in all files
            opts <- files[seq(i, length(files))]
            file_data <- lapply(opts, scan, what = '', sep = '\n', quiet = TRUE)
            ix <- grep(sprintf('%s[-<= ]+function', noFun), file_data)
            found <- FALSE
            if(length(ix) == 0) stop(er)
            for(j in ix) {
              ee <- sourcerer(opts[j])
              if(is.environment(ee)) {
                if(noFun %in% ls(envir = ee)) {
                  suppresser(sys.source(opts[j], e, keep.source = FALSE))
                  found <- TRUE
                  break
                }
              }
            }
            if(!found) stop(er)
          } else {
            stop(er)
          }
          1
        })
        if(is.null(r)) break
      }
    }
  }
  e
}
