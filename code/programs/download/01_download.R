library(here)
library(WDI)
library(tidyverse)

# ── 1. Define the indicators we want ─────────────────────────────────────────
# WDI indicator codes come from the World Bank data catalog:
# https://data.worldbank.org/indicator

indicators <- c(
  maternal_mortality = "SH.STA.MMRT",    # per 100,000 live births
  energy_use         = "EG.USE.PCAP.KG.OE"  # kg of oil equivalent per capita
)

# ── 2. Download from the World Bank API ──────────────────────────────────────
# extra = TRUE adds region, income group, and other country metadata,
# which we need so we can drop regional aggregates in the next step.

raw <- WDI(
  indicator = indicators,
  country   = "all",
  start     = 2023,
  end       = 2023,
  extra     = TRUE
)

# ── 3. Drop regional aggregates, keep individual countries only ───────────────
# The World Bank API returns both country-level rows and regional/income-group
# aggregates (e.g. "Sub-Saharan Africa"). We only want individual countries.
# WDI flags aggregates with region == "Aggregates".

countries_only <- raw %>%
  filter(region != "Aggregates")

# ── 4. Save to data/raw/ ─────────────────────────────────────────────────────
# We save the data exactly as downloaded -- no modifications.
# Cleaning happens in 02_clean.R.

write_csv(countries_only, here("data", "raw", "wb_indicators_2023.csv"))

message("Done. Rows saved: ", nrow(countries_only))
