# packageDiff
Easily compare changes between package versions.

## YAML is a small package, but several major packages depend upon it

```
library(packageDiff)
a <- pkgInfo('https://cran.r-project.org/src/contrib/Archive/yaml/yaml_2.1.18.tar.gz')
b <- pkgInfo('https://cran.r-project.org/src/contrib/Archive/yaml/yaml_2.1.19.tar.gz')
pkgDiff(a, b)
```

## Hmisc is a massive package

```
library(packageDiff)
pkgDiff(pkgInfo('https://cran.r-project.org/src/contrib/Archive/Hmisc/Hmisc_4.1-1.tar.gz'),
        pkgInfo('https://cran.r-project.org/src/contrib/Archive/Hmisc/Hmisc_4.2-0.tar.gz'))
```
