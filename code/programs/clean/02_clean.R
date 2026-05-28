library(here)
library(tidyverse)
library(labelled)    # for variable labels (compatible with Stata/SPSS export)

# ── 1. Load the raw download ──────────────────────────────────────────────────

raw <- read_csv(here("data", "raw", "wb_indicators_2023.csv"))

# ── 2. Keep only the columns we need ─────────────────────────────────────────
# The WDI download includes many metadata columns (region, income group, etc.)
# We keep iso3c as our country identifier, plus the two indicator columns.

clean <- raw %>%
  select(
    iso3c,             # three-letter country code (our key variable)
    country,           # country name, kept for readability
    maternal_mortality,
    energy_use
  )

# ── 3. Drop rows where both indicators are missing ────────────────────────────
# A handful of countries have no data for either variable.
# We keep rows where at least one indicator is present.

clean <- clean %>%
  filter(!is.na(maternal_mortality) | !is.na(energy_use))

# ── 4. Check for and report any remaining missingness ─────────────────────────

missing_summary <- clean %>%
  summarise(
    missing_maternal = sum(is.na(maternal_mortality)),
    missing_energy   = sum(is.na(energy_use))
  )

message("Missingness after cleaning:")
print(missing_summary)

# ── 5. Add variable labels ────────────────────────────────────────────────────

var_label(clean$maternal_mortality) <- "Maternal mortality ratio (per 100,000 live births)"
var_label(clean$energy_use)         <- "Energy use per capita (kg of oil equivalent)"

# ── 6. Save cleaned data ──────────────────────────────────────────────────────

# .rds preserves variable labels (and all other R attributes); CSV does not.
saveRDS(clean, here("data", "processed", "wb_indicators_2023_clean.rds"))

message("Done. Rows saved: ", nrow(clean))
