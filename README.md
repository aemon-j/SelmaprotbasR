SelmaprotbasR
====


R package for basic [GOTM](http://gotm.net/) model running, coupled to [Selmaprotbas](https://github.com/jorritmesman/selmaprotbas).
`Selmaprotbas` holds version 5.4 of the [lake branch](http://github.com/gotm-model/code/tree/lake) of the General Ocean Turbulence Model (GOTM) and version 1.0.0 of Selmaprotbas.
This package does not contain the source code for the models, only the executable. Also, use `gotm_sp_version()` to figure out what version of GOTM you are running. This package was inspired by [GOTMr](https://github.com/GLEON/GOTMr).

## Installation

You can install SelmaprotbasR from Github with:

```{r gh-installation, eval = FALSE}
# install.packages("devtools")
devtools::install_github("aemon-j/SelmaprotbasR")
```

# For Linux users
GOTM requires the libgfortran3 and libnetcdff6 libraries so you will need to install this to get GOTM running. You can install this with:
```
sudo apt-get install libgfortran3
sudo apt-get install libnetcdff6
```

## Usage

### Run

```{r example, eval=FALSE}
library(SelmaprotbasR)
sim_folder <- system.file('extdata', package = 'SelmaprotbasR')
run_gotm(sim_folder)
```

### Visualize

You can download [PyNcView](http://sourceforge.net/projects/pyncview/) for viewing the netCDF output or you can download a set of accompanying tools for working with GOTM data in R [gotmtools](https://github.com/aemon-j/gotmtools).

