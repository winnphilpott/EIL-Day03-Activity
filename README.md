# Country-Level Energy and Environment Data Project
- EIL Bootcamp Day 3 Activity

## Overview

This short project is focused on building a small, well-documented repository of country-level data
that allows me to compute stylized facts about economic growth and the environ-
ment. Using data from the World Bank, I take a look at recent global data about maternal mortality rates and energy use per capita (aggregated at the country level). Though these data help start to answer some questions we might have about energy and environment economics, my main goal of this activity was to become more familiar with tools like VSCode, Claude Code, and GitHub.

## Indicators

| Indicator | WB Code | Unit | Year | Countries |
|-----------|---------|------|------|-----------|
| Maternal mortality ratio | `SH.STA.MMRT` | per 100,000 live births | 2023 | 146 |
| Energy use per capita | `EG.USE.PCAP.KG.OE` | kg of oil equivalent | 2023 | 146 |

Coverage note: 146 individual countries have non-missing data for both indicators in 2023.
Regional and income-group aggregates are excluded.

## Data Sources and Provenance

| Dataset | Source | Access | License | Year |
|---------|--------|--------|---------|------|
| World Bank Development Indicators | World Bank | `WDI` R package (API) | CC BY 4.0 | 2023 |

All raw files are stored in `data/raw/` and are **never edited by hand**.
Processed/merged outputs written by scripts live in `data/processed/`.

## Repository Structure

```
project_root/
├── code/
│   ├── logs/                          # log output (not tracked)
│   └── programs/
│       ├── download/                  # 01_download.R + README
│       ├── clean/                     # 02_clean.R + README
│       ├── analysis/                  # 03_analysis.R + README
│       └── figures/                   # 04_figures.R + README
├── data/
│   ├── documentation/                 # codebooks, data dictionaries
│   ├── raw/                           # downloaded data, never edited by hand
│   └── processed/                     # cleaned outputs from scripts
├── output/
│   ├── figures/                       # plots
│   ├── tables/                        # summary statistics
│   └── statistics/                    # other statistical output
├── run.R                              # master script — runs full pipeline
├── global_paths.R                     # project-wide constants and indicator codes
├── README.md
├── TODO.md
└── LICENSE.md
```

## Software Requirements

- **R** ≥ 4.3
- R packages (install via `install.packages(c(...))`):
  - `tidyverse`
  - `here`
  - `WDI`
  - `labelled`

No commercial software is required. Package versions can be pinned with
[`renv`](https://rstudio.github.io/renv/) — see `renv.lock` if present.

## How to Reproduce

To run the full pipeline from scratch, execute the master script from the project root:

```r
source("run.R")
```

Or run modules individually in this order:

| Step | Script | Description |
|------|--------|-------------|
| 1 | `code/programs/download/01_download.R` | Download raw data from World Bank API |
| 2 | `code/programs/clean/02_clean.R`       | Clean data, add variable labels |
| 3 | `code/programs/analysis/03_analysis.R` | Compute summary statistics |
| 4 | `code/programs/figures/04_figures.R`   | Produce all output figures |

> **Tip:** The [`here`](https://here.r-lib.org/) package is used throughout so
> scripts work regardless of working directory — always open the project via
> the `.Rproj` file or set the root with `here::i_am()`.

## Output

| File | Location | Description |
|------|----------|-------------|
| `summary_stats.csv` | `output/tables/` | Mean, SD, min, max, N for each indicator |
| `fig1_maternal_mortality_distribution.png` | `output/figures/` | Histogram of maternal mortality |
| `fig2_energy_use_distribution.png` | `output/figures/` | Histogram of energy use per capita |
| `fig3_energy_vs_maternal.png` | `output/figures/` | Scatter plot: energy use vs. maternal mortality |
