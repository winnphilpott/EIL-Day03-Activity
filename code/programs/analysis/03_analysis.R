library(here)
library(tidyverse)

# ── 1. Load the cleaned data ──────────────────────────────────────────────────

data <- readRDS(here("data", "processed", "wb_indicators_2023_clean.rds"))

# ── 2. Summary statistics ─────────────────────────────────────────────────────
# Compute mean, standard deviation, min, max, and non-missing count
# for each indicator across all countries.

summarise_var <- function(df, var) {
  df %>%
    summarise(
      mean = mean({{ var }}, na.rm = TRUE),
      sd   = sd({{ var }},   na.rm = TRUE),
      min  = min({{ var }},  na.rm = TRUE),
      max  = max({{ var }},  na.rm = TRUE),
      n    = sum(!is.na({{ var }}))
    )
}

summary_maternal <- summarise_var(data, maternal_mortality)
summary_energy   <- summarise_var(data, energy_use)

print(summary_maternal)
print(summary_energy)

write_csv(summary_maternal, here("output", "tables", "summary_stats_maternal.csv"))
write_csv(summary_energy,   here("output", "tables", "summary_stats_energy.csv"))

message("Summary statistics saved.")

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
