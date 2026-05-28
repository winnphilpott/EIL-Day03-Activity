# Country-Level Data Project

## Overview

Brief description of the project's purpose, research question, and geographic scope.
(Replace this placeholder with 2–3 sentences summarizing what this repository does and why.)

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

## Software Requirements

- **R** ≥ 4.3
- R packages (install via `install.packages(c(...))`):
  - `tidyverse`
  - `here`
  - `WDI`

No commercial software is required. Package versions can be pinned with
[`renv`](https://rstudio.github.io/renv/) — see `renv.lock` if present.

## How to Reproduce

Run scripts in the following order from the project root:

| Step | Script | Description |
|------|--------|-------------|
| 1    | `code/01_download.R`  | Download raw data from source APIs / URLs |
| 2    | `code/02_clean.R`     | Clean and reshape raw data |
| 3    | `code/03_merge.R`     | Merge datasets into analysis panel |
| 4    | `code/04_analysis.R`  | Compute summary statistics and run models |
| 5    | `code/05_figures.R`   | Produce all output figures |

> **Tip:** The [`here`](https://here.r-lib.org/) package is used throughout so
> scripts work regardless of working directory — always open the project via
> the `.Rproj` file or set the root with `here::i_am()`.

## Output

| File | Location | Description |
|------|----------|-------------|
| TBD  | `output/tables/` | Summary statistics tables |
| TBD  | `output/figures/` | Plots and maps |
