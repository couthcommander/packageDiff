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

pkgDiff <- function(a, b, doc = TRUE, width = 80) {
  addBreaks <- function(s, maxWidth = 80) {
    s <- sub('[ ]+$', '', s)
    ix <- which(nchar(s) > maxWidth)
    if(length(ix)) {
      loc <- gregexpr('[| ]', s[ix])
      mrk <- lapply(loc, function(i) {
        vapply(seq_len(floor(max(i) / maxWidth)), function(j) { rev(i[i < j * maxWidth])[1] }, numeric(1))
      })
      # add newline break
      newline <- '\n    '
      for(i in seq_along(mrk)) {
        mrki <- mrk[[i]]
        if(length(mrki)) {
          str <- s[ix[i]]
          mrki <- c(0, mrki, nchar(str))
          newstr <- vapply(seq(length(mrki)-1), function(j) substr(str, mrki[j] + 1, mrki[j+1]), character(1))
          s[ix[i]] <- paste(newstr, collapse = newline)
        }
      }
    }
    s
  }
  a0 <- capture.output(print(a, doc, width = 1000))
  b0 <- capture.output(print(b, doc, width = 1000))
  a1 <- paste(addBreaks(a0, width), collapse = '\n')
  b1 <- paste(addBreaks(b0, width), collapse = '\n')
  x <- list(contextSize = 3, minJumpSize = 10, wordWrap = TRUE, f1 = a1, f2 = b1)
  htmlwidgets::createWidget("diffr", x, package = "diffr")
}
