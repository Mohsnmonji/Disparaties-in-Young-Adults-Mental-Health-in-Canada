# Load required libraries
library(tidyverse)
library(gtsummary)
library(sjPlot)

# Load the cleaned dataset saved in the previous step

gss_2017_selected <- read_csv("gss_2017_selected.csv")

# Filtering the cleaned data to include only young adults aged 18-39
gss_2017_young_adults <- gss_2017_selected %>% filter(age >= 18 & age <= 39)

# Turning categorical variables into factor 
gss_2017_young_adults <- gss_2017_young_adults %>%
  mutate(
    self_rated_mental_health = factor(self_rated_mental_health, levels = c(0, 1), labels = c("Excellent/Very Good/Good", "Poor/Fair")),
    sex = factor(sex, levels = c(0, 1), labels = c("Male", "Female")),
    marital_status = factor(marital_status, levels = c(0, 1, 2), labels = c("Married/Common Law", "Single", "Divorced/Widowed")),
    visible_minority_status = factor(visible_minority_status, levels = c(0, 1), labels = c("Not Visible Minority", "Visible Minority")),
    household_income = factor(household_income, levels = c(0, 1, 2), labels = c("< 50k", "50k-99k", "100k+")),
    immigrant_status = factor(immigrant_status, levels = c(0, 1), labels = c("Non-Immigrant", "Immigrant")),
    educational_attainment = factor(educational_attainment, levels = c(0, 1, 2), labels = c("Less than High School", "High School/Trade/College", "University Degree"))
  )

# Creating and displaying the sample characteristics in a publishable table
gss_2017_young_adults %>%
  tbl_summary(missing = "no") %>%
  as_gt() %>%
  gt::tab_header(title = "Table 1: Sample Characteristics-GSS 2017 Young Adults (Age 18-39)")

# Calculating frequencies and proportions of self-rated mental health by predictors

calc_freq_prop <- function(variable) {
  freq <- table(gss_2017_young_adults$self_rated_mental_health, variable)
  proportions <- prop.table(freq, margin = 2) * 100
  list(freq = freq, proportions = proportions)
}

# Applying the function to all categorical variables

freq_prop_list <- list(
  sex = calc_freq_prop(gss_2017_young_adults$sex),
  marital_status = calc_freq_prop(gss_2017_young_adults$marital_status),
  visible_minority = calc_freq_prop(gss_2017_young_adults$visible_minority_status),
  household_income = calc_freq_prop(gss_2017_young_adults$household_income),
  immigrant_status = calc_freq_prop(gss_2017_young_adults$immigrant_status),
  educational_attainment = calc_freq_prop(gss_2017_young_adults$educational_attainment)
)

# Creating a dataframe with combined frequencies and proportions

combined_table <- tibble(
  Category = c("Sex (Male)", "Sex (Female)", 
               "Marital Status (Married/Common Law)", "Marital Status (Single)", "Marital Status (Divorced/Widowed)", 
               "Visible Minority (No)", "Visible Minority (Yes)", 
               "Household Income (< 50k)", "Household Income (50k-99k)", "Household Income (100k+)", 
               "Immigrant Status (Non-Immigrant)", "Immigrant Status (Immigrant)", 
               "Educational Attainment (Less than High School)", "Educational Attainment (High School/Trade/College)", "Educational Attainment (University Degree)"),
  `Poor/Fair (Count)` = unlist(lapply(freq_prop_list, function(x) x$freq[2, ])),
  `Excellent/Very Good/Good (Count)` = unlist(lapply(freq_prop_list, function(x) x$freq[1, ])),
  `Poor/Fair (%)` = unlist(lapply(freq_prop_list, function(x) x$proportions[2, ])),
  `Excellent/Very Good/Good (%)` = unlist(lapply(freq_prop_list, function(x) x$proportions[1, ]))
)

# Displaying the combined table
print(combined_table)

# Displaying a publishable table

tab_df(combined_table,
       title = "Table2: Frequencies and Percentages of Self-Rated Mental Health by Predictors",
       show.rownames = FALSE,
       digits = 2)
