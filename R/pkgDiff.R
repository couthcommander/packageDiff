#' Package Diff
#'
#' This function compares version changes within packages.
#'
#' Generate diffs between package information.
#'
#' @param a First package, a \sQuote{pkgInfo} object.
#' @param b Second package, a \sQuote{pkgInfo} object.
#' @param doc Include documentation in diff output.
#' @param width Output width.
#'
#' @return \sQuote{diffr} object is open in browser
#'
#' @export

pkgDiff <- function(a, b, doc = TRUE, width = 200) {
  a1 <- paste(capture.output(print(a, doc, width = width)), collapse = '\n')
  b1 <- paste(capture.output(print(b, doc, width = width)), collapse = '\n')
  x <- list(contextSize = 3, minJumpSize = 10, wordWrap = TRUE, f1 = a1, f2 = b1)
  htmlwidgets::createWidget("diffr", x, package = "diffr")
}
