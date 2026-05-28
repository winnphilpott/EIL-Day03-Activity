library(here)
library(tidyverse)

# ── 1. Load panel ─────────────────────────────────────────────────────────────

# panel <- read_csv(here("data", "processed", "panel.csv"))

# ── 2. Summary statistics ─────────────────────────────────────────────────────

# TODO: compute country- or year-level summaries, e.g.:
#
# summary_stats <- panel |>
#   summarise(
#     across(where(is.numeric), list(mean = mean, sd = sd, n = ~sum(!is.na(.))),
#            na.rm = TRUE)
#   )
#
# write_csv(summary_stats, here("output", "tables", "summary_stats.csv"))

# ── 3. Models (optional) ──────────────────────────────────────────────────────

# TODO: add regression or other modelling code here
