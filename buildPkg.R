##======================================================================
## Script to check and build the `dsbdtemplate` package
##======================================================================

##----------------------------------------------------------------------
## Set working directory
if (!basename(getwd()) == "dsbdtemplate") {
    stop("The working directory isn't /dsbdtemplate")
}

##----------------------------------------------------------------------
## Packages
library(devtools)
library(knitr)
library(rmarkdown)

##----------------------------------------------------------------------
## Run checks

## Load the package (to make functions available)
load_all()

## Create/update NAMESPACE, *.Rd files.
document()

## Check documentation.
check_man()

## Check functions, datasets, run examples, etc. Using cleanup = FALSE
## and check_dir = "../" will create a directory named legtheme.Rcheck
## with all the logs, manuals, figures from examples, etc.
check(manual = TRUE, vignettes = FALSE, check_dir = "../")

## Examples
# Run examples from all functions of the package
# run_examples()
# Run examples from a specific function
# dev_example("yscale.components.right")

## Show all exported objects.
ls("package:dsbdtemplate")
packageVersion("dsbdtemplate")

## Build the package (it will be one directory up)
build(manual = TRUE, vignettes = FALSE)
# build the binary version for windows (not used)
# build_win() # not used here. see below

##----------------------------------------------------------------------
## Generate README.md
knit(input = "README.Rmd")

##----------------------------------------------------------------------
## Test installation.

## Test install with install.packages()
pkg <- paste0("../dsbdtemplate_", packageVersion("dsbdtemplate"),
              ".tar.gz")
install.packages(pkg, repos = NULL)

##----------------------------------------------------------------------
## Sending package tarballs and manual to remote server to be
## downloadable

## Create Windows version
pkg.win <- paste0("../dsbdtemplate_",
                  packageVersion("dsbdtemplate"), ".zip")
cmd.win <- paste("cd ../dsbdtemplate.Rcheck && zip -r",
                 pkg.win, "dsbdtemplate")
system(cmd.win)

## Link to manual
man <- "../dsbdtemplate.Rcheck/dsbdtemplate-manual.pdf"

## Send to downloads/ folder
dest <- "downloads/"
file.copy(c(pkg, pkg.win, man), dest, overwrite = TRUE)
##----------------------------------------------------------------------
