#' Print Package Information
#'
#' Print method for \sQuote{packageInfo} class.
#'
#' Print its argument and return it invisibly.
#'
#' @param x A packageInfo object.
#' @param \dots Additional parameters, unused at this time.
#'
#' @examples
#' \dontrun{
#' url <- 'https://cran.r-project.org/src/contrib/Archive/acepack/acepack_1.3-3.3.tar.gz'
#' info <- packageInfo(url)
#' print(info)
#' }
#' @export

print.packageInfo <- function(x, ...) {
  defprint <- function(x) paste(utils::capture.output(print(x)), collapse = '\n')
  fun0 <- x$ImportedFunctions
  if(length(fun0)) {
    f0out <- paste(fun0, collapse = '\n')
  } else {
    f0out <- NA
  }
  fun1 <- x$ExportedFunctions
  fun2 <- setdiff(x$AllFunctions, fun1)
  fun1args <- vapply(x$FormalArgs[fun1], paste, character(1), collapse = '|', USE.NAMES = FALSE)
  fun2args <- vapply(x$FormalArgs[fun2], paste, character(1), collapse = '|', USE.NAMES = FALSE)
  f1 <- data.frame(name = fun1, arguments = fun1args)
  f2 <- data.frame(name = fun2, arguments = fun2args)
  f1out <- defprint(f1)
  f2out <- defprint(f2)
  dat <- defprint(x$Data)
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
  cat(out)
  invisible(x)
}
