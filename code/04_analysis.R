library(here)
library(tidyverse)

# ── 1. Load the cleaned data ──────────────────────────────────────────────────

data <- read_csv(here("data", "processed", "wb_indicators_2023_clean.csv"))

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
