
---
# CAnD3 Reproducible Research Project

## Project Overview

This study explores disparities in self-rated mental health among young adults (aged 18-39) in Canada using data from the 2017 General Social Survey (Cycle 31): Family. This repository contains the R scripts required to reproduce the analysis, including data cleaning, descriptive statistics, and chi-square tests and logistic regression analysis.


## Data Description

The data used in this study comes from the 2017 General Social Survey (Cycle 31): Family, a Statistics Canada's Public Use Microdata Files (PUMFs). The data is obtained through ODESI, a service provided by the Ontario Council of University Libraries.

Access to ODESI is restricted to users with a DLI License, and it can be used for statistical and research purposes. The terms of the license can be found [here](https://odesi-ca.lib-ezproxy.concordia.ca/en/terms).

McGill University's CAnD3 initiative has a license to use the data for training purposes. Those outside McGill University should not use the data provided through CAnD3's training activities for purposes unrelated to CAnD3 training. Those from another DLI institution should download the data using ODESI through their institution.

## Codebook

The codebook for this dataset is publicly available through ODESI [here](https://odesi.ca/).

You can also access the codebook directly from Statistics Canada [here](https://www150.statcan.gc.ca/n1/pub/45-25-0001/cat4/c31_2017.zip).

## Data Citation

- Statistics Canada. 2024. General Social Survey, Cycle 31, 2017 [Canada]: Family. See:https://www150.statcan.gc.ca/n1/en/catalogue/452500012020001.

## Files Included 


| **File**                              | **Description**                                          |
|---------------------------------------|----------------------------------------------------------|
| **Files.zip**                         | Zip folder containing all project files.           |
| **Instructions for Reproducing Analysis.Rmd** | RMarkdown file with instructions for reproducing the analysis. |
| **Code for Data Wrangling.R**         | R script for data recoding and handling missing cases.    |
| **Code for Descriptive Statistics.R** | R script for generating descriptive statistics.           |
| **Code for Logistic Regression.R**    | R script for chi-square tests and logistic regression.    |
| **README.md**                         | Project overview.                                         |
| **Reproducible Research_GSS2017.Rproj** | R project file.                                           |

## Instructions for Reproducing the Analysis

For detailed instructions on how to reproduce the analysis, please refer to the `Instructions for Reproducing Analysis.Rmd` file available in this repository.The instructions file will guide you through running the R Scripts for data cleaning, descriptive statistics, and logistic regression analysis.

---

## Software Requirements


- `R` and `RStudio`

### Required R Packages

- `tidyverse`
- `sjPlot`

To install the required R packages, run:

```r
install.packages(c("tidyverse", "sjPlot"))
```

---

## System Information

- `Operating System`: Darwin 23.6.0 (macOS)
- `Kernel Version`: Darwin Kernel Version 23.6.0
- `Memory`: 16 GB
- `Processor`: ARM64

### R Version

- **R Version**: R version 4.4.1 (2024-06-14)

## License


---

