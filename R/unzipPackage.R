#' Extract R Package
#'
#' Untar an R package into a temp directory.
#'
#' @param x The compressed (tar.gz) build file of an R package, either local or
#' URL.
#'
#' @return List of files extracted.
#'
#' @export

unzipPackage <- function(x) {
  td <- tempdir()
  if(grepl('^https?:', x)) {
    url <- x
    x <- file.path(td, basename(x))
    download.file(url, destfile = x, quiet = TRUE)
  }
  xx <- sub('\\.tar\\.gz', '', basename(x))
  dir <- file.path(td, xx)
  untar(x, exdir = dir)
  list.files(dir, full.names = TRUE)
}
