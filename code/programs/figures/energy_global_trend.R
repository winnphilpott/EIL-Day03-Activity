library(here)
library(tidyverse)
library(WDI)

# ── Colors ────────────────────────────────────────────────────────────────────

uva_navy   <- "#232D4B"
uva_orange <- "#E57200"

# ── Load data ─────────────────────────────────────────────────────────────────

ts_global <- WDI(
  indicator = c(energy_use = "EG.USE.PCAP.KG.OE"),
  country   = "all",
  start     = 2000,
  end       = 2023,
  extra     = TRUE
) %>%
  filter(region != "Aggregates")

# Compute mean energy use per year across all countries
global_avg <- ts_global %>%
  filter(!is.na(energy_use)) %>%
  group_by(year) %>%
  summarise(
    mean_energy = mean(energy_use, na.rm = TRUE),
    n_countries = n(),
    .groups = "drop"
  )

theme_set(theme_minimal(base_size = 12))

# ── Figure: Global average energy use over time ──────────────────────────────

fig <- global_avg %>%
  ggplot(aes(x = year, y = mean_energy)) +
  geom_line(color = uva_navy, linewidth = 1.2) +
  geom_point(color = uva_navy, size = 2.5) +
  geom_area(fill = uva_orange, alpha = 0.2) +
  labs(
    title = "Global Average Energy Use per Capita (2000–2023)",
    x     = NULL,
    y     = "Energy use (kg of oil equivalent per capita)",
    caption = "Mean across all countries with available data each year"
  )

ggsave(here("output", "figures", "energy_global_average_trend.png"),
       fig, width = 9, height = 6, dpi = 300)

message("Global average energy use figure saved.")
