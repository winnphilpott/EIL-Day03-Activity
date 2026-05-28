library(here)

# Master script -- runs the full pipeline from download to figures.
# Execute this file to reproduce all results from scratch.

message("Step 1: Downloading data from World Bank API...")
source(here("code", "01_download.R"))

message("Step 2: Cleaning data...")
source(here("code", "02_clean.R"))

message("Step 3: Merge (skipped -- single data source)...")
# source(here("code", "03_merge.R"))

message("Step 4: Computing summary statistics...")
source(here("code", "04_analysis.R"))

message("Step 5: Producing figures...")
source(here("code", "05_figures.R"))

message("Pipeline complete. Outputs saved to output/tables/ and output/figures/")
