# ── Load packages ─────────────────────────────────────────────────────────────
# here:       builds file paths relative to the project root, so the script
#             works on any machine regardless of where the project is stored
# tidyverse:  a collection of packages for data manipulation and visualization
#             (we use dplyr for summarising and readr for writing CSV files)
# knitr:      provides kable(), which formats data frames as publication-ready tables
# kableExtra: extends kable() with options for LaTeX output (e.g., booktabs formatting)

library(here)
library(tidyverse)
library(knitr)
library(kableExtra)


# ── 1. Load the cleaned data ──────────────────────────────────────────────────
# We load the processed data file created in 02_clean.R.
# RDS is R's native file format — it preserves variable types and labels,
# which is why we use it instead of CSV for intermediate data files.

data <- readRDS(here("data", "processed", "wb_indicators_2023_clean.rds"))


# ── 2. Summary statistics ─────────────────────────────────────────────────────
# We compute five descriptive statistics for each variable:
#   mean  — average value across all countries
#   sd    — standard deviation (spread around the mean)
#   min   — lowest observed value
#   max   — highest observed value
#   n     — number of countries with non-missing data
#
# na.rm = TRUE tells R to ignore missing values when computing each statistic.
# Without this, a single missing value would cause the result to be NA.

# Summary statistics for maternal mortality (deaths per 100,000 live births)
summary_maternal <- data %>%
  summarise(
    mean = mean(maternal_mortality, na.rm = TRUE),
    sd   = sd(maternal_mortality,   na.rm = TRUE),
    min  = min(maternal_mortality,  na.rm = TRUE),
    max  = max(maternal_mortality,  na.rm = TRUE),
    n    = sum(!is.na(maternal_mortality))
  )

# Summary statistics for energy use (kg of oil equivalent per capita)
summary_energy <- data %>%
  summarise(
    mean = mean(energy_use, na.rm = TRUE),
    sd   = sd(energy_use,   na.rm = TRUE),
    min  = min(energy_use,  na.rm = TRUE),
    max  = max(energy_use,  na.rm = TRUE),
    n    = sum(!is.na(energy_use))
  )

# Print results to the console so we can do a quick sanity check
print(summary_maternal)
print(summary_energy)


# ── 3. Save tables as CSV ─────────────────────────────────────────────────────
# CSV files are easy to open in Excel or share with collaborators.

write_csv(summary_maternal, here("output", "tables", "summary_stats_maternal.csv"))
write_csv(summary_energy,   here("output", "tables", "summary_stats_energy.csv"))

message("CSV tables saved.")


# ── 4. Save tables as LaTeX ───────────────────────────────────────────────────
# kable() converts a data frame into a formatted table.
# format = "latex"  tells kable to produce LaTeX code instead of plain text.
# booktabs = TRUE   uses the LaTeX booktabs package for cleaner horizontal rules
#                   (\toprule, \midrule, \bottomrule) instead of default borders.
# digits = 1        rounds all numbers to one decimal place in the output.
# caption =         sets the table caption that will appear in your LaTeX document.
#
# save_kable() writes the LaTeX code to a .tex file, which you can then include
# in your LaTeX document using \input{} or \include{}.

kable(summary_maternal, format = "latex", booktabs = TRUE,
      digits = 1, caption = "Summary Statistics: Maternal Mortality") %>%
  save_kable(here("output", "tables", "summary_stats_maternal.tex"))

kable(summary_energy, format = "latex", booktabs = TRUE,
      digits = 1, caption = "Summary Statistics: Energy Use") %>%
  save_kable(here("output", "tables", "summary_stats_energy.tex"))

message("LaTeX tables saved.")


# ── Notes on the distributions ────────────────────────────────────────────────
# Both variables are heavily right-skewed: the standard deviation is roughly
# equal to or larger than the mean, indicating a long upper tail.
#
# Notable high-end outliers:
#   - Energy use:          Qatar (16,343 kg) and Iceland (15,686 kg)
#   - Maternal mortality:  Nigeria (993 per 100,000 live births)
#
# Energy use has 45 fewer observations than maternal mortality (149 vs. 194)
# due to missing World Bank data for small island states and a handful of
# low-income countries. Keep this in mind when comparing across indicators.
