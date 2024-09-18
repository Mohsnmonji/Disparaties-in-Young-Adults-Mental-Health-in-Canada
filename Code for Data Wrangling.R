# Loading required libraries

library(tidyverse)
library(sjPlot)

# Loading raw data
# This assumes that you downloaded the GSS-2017 data and renamed it to 'gss2017.csv' 
# and placed it  in the main directory where you placed the downloaded R scripts from this repository.

gss_2017 <- read_csv("gss2017.csv")

# Recoding variables of interest

gss_2017 <- gss_2017 %>% 
  mutate(
    # Recoding Self-Rated Mental Health with new labels
    self_rated_mental_health = case_when(
      SRH_115 %in% 1:3 ~ 0,
      SRH_115 %in% 4:5 ~ 1
    ),
    # Recoding Sex
    sex = case_when(
      SEX == 1 ~ 0,
      SEX == 2 ~ 1
    ),
    # Recoding Marital Status
    marital_status = case_when(
      MARSTAT %in% 1:2 ~ 0, 
      MARSTAT == 6 ~ 1, 
      MARSTAT %in% 3:5 ~ 2
    ),
    # Recoding Visible Minority Status
    visible_minority_status = case_when(
      VISMIN == 1 ~ 1, 
      VISMIN == 2 ~ 0
    ),
    # Recoding Household Income
    household_income = case_when(
      FAMINCG2 %in% 1:2 ~ 0, 
      FAMINCG2 %in% 3:4 ~ 1, 
      FAMINCG2 %in% 5:6 ~ 2
    ),
    # Recoding Immigrant Status
    immigrant_status = case_when(
      BPR_16 == 1 ~ 1, 
      BPR_16 %in% c(2, 6) ~ 0
    ),
    # Recoding Educational Attainment
    educational_attainment = case_when(
      EHG3_01B == 1 ~ 0, 
      EHG3_01B %in% 2:4 ~ 1, 
      EHG3_01B %in% 5:7 ~ 2
    ),
    # Recoding Age
    age = case_when(
      AGEC == 80 ~ 80,
      AGEC >= 15 & AGEC <= 79 ~ AGEC
    )
  )

# Selecting only variables of interest

gss_2017_selected <- gss_2017 %>% 
  select(self_rated_mental_health, sex, marital_status, visible_minority_status, household_income, immigrant_status, educational_attainment, age)

# Dropping rows with NA in any of the selected variables

gss_2017_selected <- gss_2017_selected %>% 
  drop_na()

# Output dataset dimensions
cat("Number of rows:", nrow(gss_2017_selected), "\n")
cat("Number of columns:", ncol(gss_2017_selected), "\n")

# View all variable names in the dataset

names(gss_2017_selected)

# Save the cleaned dataset in the main directory where R scripts are placed for further analysis
write.csv(gss_2017_selected, file = "gss_2017_selected.csv", row.names = FALSE)