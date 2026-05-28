# Country-Level Data Project

## Overview

Brief description of the project's purpose, research question, and geographic scope.
(Replace this placeholder with 2–3 sentences summarizing what this repository does and why.)

## Indicators

List each indicator collected or constructed, one per row.

| Indicator | Unit | Frequency | Coverage |
|-----------|------|-----------|----------|
| TBD       |      |           |          |

## Data Sources and Provenance

Document every raw data source so the analysis is fully reproducible from scratch.

| Dataset | Source | URL / Access path | License | Date retrieved |
|---------|--------|-------------------|---------|----------------|
| TBD     |        |                   |         |                |

All raw files are stored in `data/raw/` and are **never edited by hand**.
Processed/merged outputs written by scripts live in `data/processed/`.

## Software Requirements

- **R** ≥ 4.3
- R packages (install via `install.packages(c(...))`):
  - `tidyverse`
  - `here`
  - *(add others as needed)*

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
