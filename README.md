# packageDiff
Easily compare changes between package versions.

## Hmisc is a massive package

```
library(packageDiff)
pkgDiff(pkgInfo('https://cran.r-project.org/src/contrib/Archive/Hmisc/Hmisc_4.1-1.tar.gz'),
        pkgInfo('https://cran.r-project.org/src/contrib/Hmisc_4.2-0.tar.gz'))
```
