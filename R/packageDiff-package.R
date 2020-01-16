#' Package Diff
#'
#' It provides utility functions for investigating changes within R packages.
#' The \code{pkgInfo} function extracts package information such as exported
#' and non-exported functions as well as their arguments. The \code{pkgDiff}
#' function compares this information for two versions of a package and creates
#' a diff file viewable in a browser.
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
#' tar1 <- system.file("examples", "yaml_2.1.18.tar.gz", package = "packageDiff")
#' tar2 <- system.file("examples", "yaml_2.1.19.tar.gz", package = "packageDiff")
#' a <- pkgInfo(tar1)
#' b <- pkgInfo(tar2)
#' pkgDiff(a, b)
#' \donttest{
#' a <- pkgInfo('https://cran.r-project.org/src/contrib/Archive/yaml/yaml_2.1.18.tar.gz')
#' b <- pkgInfo('https://cran.r-project.org/src/contrib/Archive/yaml/yaml_2.1.19.tar.gz')
#' pkgDiff(a, b)
#' }
"_PACKAGE"
