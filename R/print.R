#' Print Package Information
#'
#' Print method for \sQuote{packageInfo} class.
#'
#' Print its argument and return it invisibly.
#'
#' @param x A packageInfo object.
#' @param doc Include documentation in output.
#' @param src Include src files in output.
#' @param vignettes Include vignette files in output.
#' @param tests Include test files in output.
#' @param demo Include demo files in output.
#' @param \dots Additional parameters, unused at this time.
#'
#' @examples
#' tarfile <- system.file("examples", "acepack_1.3-3.3.tar.gz", package = "packageDiff")
#' pkgInfo(tarfile)
#' \donttest{
#' url <- 'https://cran.r-project.org/src/contrib/Archive/acepack/acepack_1.3-3.3.tar.gz'
#' info <- pkgInfo(url)
#' print(info)
#' }
#' @export

print.pkgInfo <- function(x, doc = FALSE, src = FALSE, vignettes = FALSE, tests = FALSE, demo = FALSE, ...) {
  defprint <- function(x, ...) paste(utils::capture.output(print(x, ...)), collapse = '\n')
  fun0 <- x$ImportedFunctions
  if(length(fun0)) {
    f0out <- paste(fun0, collapse = '\n')
  } else {
    f0out <- NA
  }
  addlargs <- list(...)
  if('width' %in% names(addlargs)) {
    width <- getOption('width')
    on.exit(options(width = width))
    options(width = addlargs$width)
  }
  fun1 <- x$ExportedFunctions
  fun2 <- setdiff(x$AllFunctions, fun1)
  fun1args <- vapply(x$FormalArgs[fun1], paste, character(1), collapse = '|', USE.NAMES = FALSE)
  fun2args <- vapply(x$FormalArgs[fun2], paste, character(1), collapse = '|', USE.NAMES = FALSE)
  f1 <- data.frame(name = fun1, arguments = fun1args)
  f2 <- data.frame(name = fun2, arguments = fun2args)
  f1out <- defprint(f1, right = FALSE, row.names = FALSE)
  f2out <- defprint(f2, right = FALSE, row.names = FALSE)
  dat <- defprint(x$Data, row.names = FALSE)
  out <- sprintf("Package: %s
Version: %s
Imports: %s
Suggests: %s

Imported Functions:
%s

Exported Functions:
%s

Non-Exported Functions:
%s

Data:
%s
", x$Package, x$Version, x$Imports, x$Suggests,
    f0out,
    f1out,
    f2out,
    dat
  )
  if(doc) {
    xd <- unlist(x$documentation, use.names = FALSE)
    xd <- paste(xd, collapse = '\n')
    out <- paste(out, xd, sep = '\n')
  }
  if(src) {
    xd <- unlist(x$source, use.names = FALSE)
    if(length(xd) > 1L || !is.na(xd)) {
      xd <- sprintf("##### %s #####\n%s", names(x$source), xd)
    }
    xd <- paste(c('Src directory:', xd, ''), collapse = '\n')
    out <- paste(out, xd, sep = '\n')
  }
  if(vignettes) {
    xd <- unlist(x$vignettes, use.names = FALSE)
    if(length(xd) > 1L || !is.na(xd)) {
      xd <- sprintf("##### %s #####\n%s", names(x$vignettes), xd)
    }
    xd <- paste(c('Vignettes directory:', xd, ''), collapse = '\n')
    out <- paste(out, xd, sep = '\n')
  }
  if(tests) {
    xd <- unlist(x$tests, use.names = FALSE)
    if(length(xd) > 1L || !is.na(xd)) {
      xd <- sprintf("##### %s #####\n%s", names(x$tests), xd)
    }
    xd <- paste(c('Tests directory:', xd, ''), collapse = '\n')
    out <- paste(out, xd, sep = '\n')
  }
  if(demo) {
    xd <- unlist(x$demo, use.names = FALSE)
    if(length(xd) > 1L || !is.na(xd)) {
      xd <- sprintf("##### %s #####\n%s", names(x$demo), xd)
    }
    xd <- paste(c('Demo directory:', xd, ''), collapse = '\n')
    out <- paste(out, xd, sep = '\n')
  }
  cat(out)
  invisible(x)
}
