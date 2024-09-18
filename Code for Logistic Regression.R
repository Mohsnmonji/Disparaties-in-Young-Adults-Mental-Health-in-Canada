# Load required libraries

library(tidyverse)

# Load the cleaned dataset saved in the data wrangling step

gss_2017_selected <- read_csv("gss_2017_selected.csv")

# Filtering the cleaned data to include only young adults aged 18-39
gss_2017_young_adults <- gss_2017_selected %>% filter(age >= 18 & age <= 39)

# Transforming categorical variables into factors

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

# Performing Chi-Square Tests for self-rated mental health and categorical predictors
chi_tests <- list(
  sex = chisq.test(table(gss_2017_young_adults$self_rated_mental_health, gss_2017_young_adults$sex)),
  marital_status = chisq.test(table(gss_2017_young_adults$self_rated_mental_health, gss_2017_young_adults$marital_status)),
  visible_minority_status = chisq.test(table(gss_2017_young_adults$self_rated_mental_health, gss_2017_young_adults$visible_minority_status)),
  household_income = chisq.test(table(gss_2017_young_adults$self_rated_mental_health, gss_2017_young_adults$household_income)),
  immigrant_status = chisq.test(table(gss_2017_young_adults$self_rated_mental_health, gss_2017_young_adults$immigrant_status)),
  educational_attainment = chisq.test(table(gss_2017_young_adults$self_rated_mental_health, gss_2017_young_adults$educational_attainment))
)

# Displaying the Chi-square test results for each variable
for (test in names(chi_tests)) {
  cat("\nChi-Square Test for", test, ":\n")
  print(chi_tests[[test]])
  cat("\n")
}
# Logistic Regression: Self-rated mental health on predictors for young adults aged 18-39
model <- glm(self_rated_mental_health ~ sex + marital_status + visible_minority_status + 
               household_income + immigrant_status + educational_attainment + age,
             data = gss_2017_young_adults, family = binomial(link = "logit"))

# Displaying the summary of the logistic regression model
summary(model)

# Displaying odds ratios for easier interpretation
odds_ratios <- exp(coef(model))
cat("Odds Ratios:\n")
print(odds_ratios)

# Creating confidence intervals for the odds ratios

odds_ratios_ci <- exp(confint(model))
cat("Confidence Intervals for Odds Ratios:\n")

print(odds_ratios_ci)
