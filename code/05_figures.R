library(here)
library(tidyverse)

# ── 1. Load data ──────────────────────────────────────────────────────────────

# panel <- read_csv(here("data", "processed", "panel.csv"))

# ── 2. Theme ──────────────────────────────────────────────────────────────────

theme_set(theme_minimal(base_size = 12))

# ── 3. Figures ────────────────────────────────────────────────────────────────

# TODO: add one block per figure, then save with ggsave(), e.g.:
#
# fig1 <- panel |>
#   ggplot(aes(x = year, y = gdp_pc, group = iso3)) +
#   geom_line(alpha = 0.4) +
#   labs(title = "GDP per capita over time", x = NULL, y = "USD")
#
# ggsave(here("output", "figures", "fig1_gdp_trends.png"),
#        fig1, width = 8, height = 5, dpi = 300)
