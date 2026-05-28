library(here)
library(tidyverse)

# ── 1. Load cleaned datasets ──────────────────────────────────────────────────

# TODO: read each processed file, e.g.:
# df_a <- read_csv(here("data", "processed", "source_a_clean.csv"))
# df_b <- read_csv(here("data", "processed", "source_b_clean.csv"))

# ── 2. Merge ──────────────────────────────────────────────────────────────────

# Join key: country (ISO-3) × year
# TODO: replace df_a / df_b with your actual objects
#
# panel <- df_a |>
#   full_join(df_b, by = c("iso3", "year"))

# ── 3. Validate ───────────────────────────────────────────────────────────────

# TODO: check for unexpected row count changes, duplicate keys, coverage gaps
# stopifnot(nrow(panel) == nrow(df_a))   # adjust expectation as needed

# ── 4. Save ───────────────────────────────────────────────────────────────────

# write_csv(panel, here("data", "processed", "panel.csv"))
