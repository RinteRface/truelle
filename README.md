
<!-- README.md is generated from README.Rmd. Please edit that file -->

# truelle

<!-- badges: start 
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/RinteRface/truelle/workflows/R-CMD-check/badge.svg)](https://github.com/RinteRface/truelle/actions)
<!-- badges: end -->

The goal of `{truelle}` is to provide a GUI to the `{golem}` package and
many more.

## Installation

You can install the released version of truelle from
[CRAN](https://CRAN.R-project.org) with:

``` r
remotes::install_github("RinteRface/truelle")
```

## Workflow example

This is a basic example which shows you how to start the `{truelle}`
GUI:

``` r
library(truelle)
run_app()
```

### Step 1: project type

Select **Package** and choose the `{golem}` engine.

<img src="man/figures/truelle-project-type.png" width="50%" /><img src="man/figures/truelle-project-engine.png" width="50%" />

### Step 2: options

Provide a valid package path and review project options.

<img src="man/figures/truelle-package-options.png" width="50%" style="display: block; margin: auto;" />

### Step 3: UI layout

Select the Shiny layout of your choice.

<img src="man/figures/truelle-ui-template.png" width="50%" style="display: block; margin: auto;" />

### Step 4: code output

Click on the 🎮 button or copy/paste 📸 the code to your terminal…

<img src="man/figures/truelle-output.png" width="50%" /><img src="man/figures/golem-package-structure.png" width="50%" />

### Step 5: develop

  - Open the new project.
  - Run `devtools::load_all()`.
  - Enjoy …

## Disclaimer

For now, only the `{golem}` workflow is supported.
