library(here)
library(tidyverse)

# ── 1. Load the cleaned data ──────────────────────────────────────────────────

data <- read_csv(here("data", "processed", "wb_indicators_2023_clean.csv"))

# ── 2. Set a consistent plot theme and UVA brand colors ──────────────────────

theme_set(theme_minimal(base_size = 12))

uva_navy  <- "#232D4B"
uva_orange <- "#E57200"

# ── 3. Figure 1: Distribution of maternal mortality across countries ──────────

fig1 <- data %>%
  ggplot(aes(x = maternal_mortality)) +
  geom_histogram(bins = 30, fill = uva_navy, color = "white") +
  labs(
    title = "Distribution of Maternal Mortality Ratio (2023)",
    x     = "Maternal mortality (per 100,000 live births)",
    y     = "Number of countries"
  )

ggsave(
  here("output", "figures", "fig1_maternal_mortality_distribution.png"),
  fig1, width = 8, height = 5, dpi = 300
)

# ── 4. Figure 2: Distribution of energy use across countries ──────────────────

fig2 <- data %>%
  ggplot(aes(x = energy_use)) +
  geom_histogram(bins = 30, fill = uva_orange, color = "white") +
  labs(
    title = "Distribution of Energy Use per Capita (2023)",
    x     = "Energy use (kg of oil equivalent per capita)",
    y     = "Number of countries"
  )

ggsave(
  here("output", "figures", "fig2_energy_use_distribution.png"),
  fig2, width = 8, height = 5, dpi = 300
)

# ── 5. Figure 3: Scatter plot — energy use vs. maternal mortality ─────────────

fig3 <- data %>%
  ggplot(aes(x = energy_use, y = maternal_mortality)) +
  geom_point(alpha = 0.6, color = uva_navy) +
  geom_smooth(method = "loess", se = TRUE, color = uva_orange, fill = uva_orange) +
  labs(
    title = "Energy Use vs. Maternal Mortality (2023)",
    x     = "Energy use (kg of oil equivalent per capita)",
    y     = "Maternal mortality (per 100,000 live births)"
  )

ggsave(
  here("output", "figures", "fig3_energy_vs_maternal.png"),
  fig3, width = 8, height = 6, dpi = 300
)

message("All figures saved to output/figures/")
