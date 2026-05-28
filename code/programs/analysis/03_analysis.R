library(here)
library(tidyverse)

# ── 1. Load the cleaned data ──────────────────────────────────────────────────

data <- readRDS(here("data", "processed", "wb_indicators_2023_clean.rds"))

# ── 2. Summary statistics ─────────────────────────────────────────────────────
# Compute mean, standard deviation, min, max, and non-missing count
# for each indicator across all countries.

summary_stats <- data %>%
  summarise(
    across(
      c(maternal_mortality, energy_use),
      list(
        mean = ~ mean(.x, na.rm = TRUE),
        sd   = ~ sd(.x,   na.rm = TRUE),
        min  = ~ min(.x,  na.rm = TRUE),
        max  = ~ max(.x,  na.rm = TRUE),
        n    = ~ sum(!is.na(.x))
      ),
      .names = "{.col}__{.fn}"   # e.g. maternal_mortality__mean
    )
  ) %>%
  # Reshape from wide to long so the table is easier to read
  pivot_longer(
    everything(),
    names_to  = c("indicator", "statistic"),
    names_sep = "__"
  ) %>%
  pivot_wider(names_from = statistic, values_from = value)

print(summary_stats)

write_csv(summary_stats, here("output", "tables", "summary_stats.csv"))

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
