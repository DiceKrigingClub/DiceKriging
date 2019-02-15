Linux & OSX [![Build Status](https://travis-ci.org/DiceKrigingClub/DiceKriging.png)](https://travis-ci.org/DiceKrigingClub/DiceKriging)
Windows [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/DiceKrigingClub/DiceKriging?branch=master&svg=true)](https://ci.appveyor.com/project/DiceKrigingClub/DiceKriging)

[![codecov](https://codecov.io/gh/DiceKrigingClub/DiceKriging/branch/master/graph/badge.svg)](https://codecov.io/gh/DiceKrigingClub/DiceKriging)

# DiceKriging: Kriging methods for computer experiments

This repository is the regular DiceKriging package repository (available at http://cran.r-project.org/web/packages/DiceKriging).
It contains the latest sources, possibly some supplement of stable CRAN release.

Installation
------------

You can install the standard (CRAN) version of the code: `install.packages("DiceKriging")`

You can install the latest (this repository) version x.y.z of the code:

  * using pre-built packages:
    * Windows: `install.packages("https://github.com/DiceKrigingClub/DiceKriging/releases/download/windows/DiceKriging_x.y.z.zip")`
    * Linux: `install.packages("https://github.com/DiceKrigingClub/DiceKriging/releases/download/osx-linux/DiceKriging_x.y.z.tar.gz")`
    * OSX: `install.packages("https://github.com/DiceKrigingClub/DiceKriging/releases/download/osx-linux/DiceKriging_x.y.z.tgz")`
  * or using the `devtools` R package (assuming you have C compiler installed):
```
install.packages("devtools") # Install devtools, if you haven't already.
devtools::install_github("DiceKriging", "DiceKrigingClub")
```

![Analytics](https://ga-beacon.appspot.com/UA-109580-20/DiceKriging)
