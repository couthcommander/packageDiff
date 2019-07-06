unzipPackage <- function(x) {
  xx <- sub('\\.tar\\.gz', '', basename(x))
  dir <- file.path(tempdir(), xx)
  untar(x, exdir = dir)
  list.files(dir, full.names = TRUE)
}

(a <- unzipPackage('~/projects/PhysicalActivity_0.1-6.tar.gz'))
(b <- unzipPackage('~/projects/PhysicalActivity_0.1-7.tar.gz'))

ns <- asNamespace("ggplot2")
ls(getNamespaceInfo(ns, "exports"))
getNamespaceInfo(ns, "spec")
getNamespaceExports("ggplot2")

pkgload::load_all(a, export_all = FALSE, helpers = FALSE)
getNamespaceExports("PhysicalActivity")
ns <- asNamespace('PhysicalActivity')
ls(getNamespaceInfo(ns, "exports"))
getNamespaceInfo(ns, "spec")

pkgload::load_all(b, export_all = FALSE, helpers = FALSE)
getNamespaceExports("PhysicalActivity")
ns <- asNamespace('PhysicalActivity')
ls(getNamespaceInfo(ns, "exports"))
getNamespaceInfo(ns, "spec")
args(summaryData)
formalArgs(summaryData)
