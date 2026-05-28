library(here)

# Master script -- runs the full pipeline from download to figures.
# Execute this file to reproduce all results from scratch.

message("Step 1: Downloading data from World Bank API...")
source(here("code", "programs", "download", "01_download.R"))

message("Step 2: Cleaning data...")
source(here("code", "programs", "clean", "02_clean.R"))

message("Step 3: Computing summary statistics...")
source(here("code", "programs", "analysis", "03_analysis.R"))

message("Step 4: Producing figures...")
source(here("code", "programs", "figures", "04_figures.R"))

message("Pipeline complete. Outputs saved to output/tables/ and output/figures/")
