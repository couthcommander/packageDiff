#' Package Diff
#'
#' Extract package information and compare between versions.
#'
#' This package is experimental. Please submit bugs to
#' \url{https://github.com/couthcommander/packageDiff}.
#'
#' @docType package
#'
#' @author Cole Beck \email{cole.beck@@vumc.org}
#'
#' Maintainer: Cole Beck \email{cole.beck@@vumc.org}
#'
#' @import diffr
#' @importFrom htmlwidgets createWidget
#' @importFrom tools list_files_with_type loadPkgRdMacros parse_Rd Rd2txt
#' @importFrom utils capture.output data download.file packageDescription untar
#'
#' @examples
#' \dontrun{
#' a <- pkgInfo('https://cran.r-project.org/src/contrib/Archive/yaml/yaml_2.1.18.tar.gz')
#' b <- pkgInfo('https://cran.r-project.org/src/contrib/Archive/yaml/yaml_2.1.19.tar.gz')
#' pkgDiff(a, b)
#' }
"_PACKAGE"
