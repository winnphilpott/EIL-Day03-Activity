library(here)
library(tidyverse)
library(WDI)
library(rnaturalearth)
library(rnaturalearthdata)
library(sf)

# ── Colors ────────────────────────────────────────────────────────────────────

uva_navy   <- "#232D4B"
uva_orange <- "#E57200"

# Palette for multi-country time series: shades between navy and orange
country_colors <- c(
  "#232D4B", "#E57200", "#5B6E9A", "#F0A050",
  "#3A4F7A", "#C86800"
)

# ── Load data ─────────────────────────────────────────────────────────────────

# Cross-section (2023), with region and income group from the raw download
clean   <- readRDS(here("data", "processed", "wb_indicators_2023_clean.rds"))
raw     <- read_csv(here("data", "raw", "wb_indicators_2023.csv"),
                    show_col_types = FALSE)

# Add region and income group to the cleaned dataset
data <- clean %>%
  left_join(
    raw %>%
      filter(region != "Aggregates") %>%
      select(iso3c, region, income),
    by = "iso3c"
  )

theme_set(theme_minimal(base_size = 12))

# ── Figure 1: Choropleth world map ────────────────────────────────────────────

world <- ne_countries(scale = "medium", returnclass = "sf")

world_joined <- world %>%
  left_join(
    data %>% select(iso3c, maternal_mortality),
    by = c("iso_a3" = "iso3c")
  )

fig1 <- world_joined %>%
  ggplot() +
  geom_sf(aes(fill = maternal_mortality), color = "white", linewidth = 0.1) +
  scale_fill_gradient(
    low      = "#D4D9E8",
    high     = uva_navy,
    na.value = "grey85",
    name     = "Deaths per\n100,000 births"
  ) +
  labs(title = "Maternal Mortality Ratio by Country (2023)") +
  theme_void(base_size = 12) +
  theme(legend.position = "bottom")

ggsave(here("output", "figures", "maternal_fig1_map.png"),
       fig1, width = 10, height = 6, dpi = 300)

# ── Figure 2: Scatter plot — maternal mortality vs. GDP per capita ────────────

gdp_raw <- WDI(
  indicator = c(gdp_per_capita = "NY.GDP.PCAP.CD"),
  country   = "all",
  start     = 2023,
  end       = 2023,
  extra     = TRUE
)

gdp <- gdp_raw %>%
  filter(region != "Aggregates", !is.na(gdp_per_capita)) %>%
  select(iso3c, gdp_per_capita)

data_with_gdp <- data %>%
  left_join(gdp, by = "iso3c")

# Pull out the two countries we want to label
labels <- data_with_gdp %>%
  filter(iso3c %in% c("NGA", "USA"))

fig2 <- data_with_gdp %>%
  filter(!is.na(maternal_mortality), !is.na(gdp_per_capita)) %>%
  ggplot(aes(x = gdp_per_capita, y = maternal_mortality)) +
  geom_point(alpha = 0.6, color = uva_navy, size = 2) +
  geom_smooth(method = "loess", se = TRUE, color = uva_orange, fill = uva_orange) +
  geom_point(data = labels, color = uva_orange, size = 3) +
  geom_text(data = labels, aes(label = country),
            nudge_y = 40, nudge_x = 0.1, size = 3.5, color = uva_navy) +
  scale_x_log10(labels = scales::comma) +
  labs(
    title = "Maternal Mortality vs. GDP per Capita (2023)",
    x     = "GDP per capita (current USD, log scale)",
    y     = "Maternal mortality (per 100,000 live births)"
  )

ggsave(here("output", "figures", "maternal_fig2_gdp_scatter.png"),
       fig2, width = 9, height = 6, dpi = 300)

# ── Figure 3: Time series for six diverse countries ───────────────────────────
# Countries chosen to represent a range of income levels and regions

selected_countries <- c("USA", "NGA", "IND", "BRA", "ETH", "DEU")

ts_data <- WDI(
  indicator = c(maternal_mortality = "SH.STA.MMRT"),
  country   = selected_countries,
  start     = 2000,
  end       = 2023
)

fig3 <- ts_data %>%
  filter(!is.na(maternal_mortality)) %>%
  ggplot(aes(x = year, y = maternal_mortality, color = country)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  scale_color_manual(values = setNames(country_colors, sort(unique(ts_data$country)))) +
  labs(
    title = "Maternal Mortality Over Time: Selected Countries (2000–2023)",
    x     = NULL,
    y     = "Maternal mortality (per 100,000 live births)",
    color = NULL
  ) +
  theme(legend.position = "bottom")

ggsave(here("output", "figures", "maternal_fig3_time_series.png"),
       fig3, width = 9, height = 6, dpi = 300)

# ── Figure 4: Lollipop chart — highest and lowest 15 countries ────────────────

ranked <- data %>%
  filter(!is.na(maternal_mortality)) %>%
  arrange(maternal_mortality)

top_bottom <- bind_rows(
  head(ranked, 15) %>% mutate(group = "Lowest 15"),
  tail(ranked, 15) %>% mutate(group = "Highest 15")
) %>%
  mutate(country = fct_reorder(country, maternal_mortality))

fig4 <- top_bottom %>%
  ggplot(aes(x = maternal_mortality, y = country, color = group)) +
  geom_segment(aes(x = 0, xend = maternal_mortality, yend = country),
               color = "grey80") +
  geom_point(size = 3) +
  scale_color_manual(values = c("Highest 15" = uva_navy, "Lowest 15" = uva_orange)) +
  facet_wrap(~ group, scales = "free_y") +
  labs(
    title = "Countries with Highest and Lowest Maternal Mortality (2023)",
    x     = "Maternal mortality (per 100,000 live births)",
    y     = NULL
  ) +
  theme(legend.position = "none")

ggsave(here("output", "figures", "maternal_fig4_lollipop.png"),
       fig4, width = 10, height = 7, dpi = 300)

# ── Figure 5: Violin + jitter by income group ─────────────────────────────────

income_order <- c("Low income", "Lower middle income",
                  "Upper middle income", "High income")

fig5 <- data %>%
  filter(!is.na(maternal_mortality), !is.na(income)) %>%
  mutate(income = factor(income, levels = income_order)) %>%
  ggplot(aes(x = income, y = maternal_mortality)) +
  geom_violin(fill = uva_navy, alpha = 0.35, color = uva_navy) +
  geom_jitter(width = 0.15, alpha = 0.6, color = uva_orange, size = 1.8) +
  labs(
    title = "Maternal Mortality by Income Group (2023)",
    x     = NULL,
    y     = "Maternal mortality (per 100,000 live births)"
  )

ggsave(here("output", "figures", "maternal_fig5_violin.png"),
       fig5, width = 9, height = 6, dpi = 300)

message("All 5 figures saved to output/figures/")
