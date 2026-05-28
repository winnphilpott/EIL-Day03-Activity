# Both indicators were downloaded in a single WDI call in 01_download.R,
# so there are no separate datasets to merge.
#
# If you add a second data source later (e.g. a different database or a
# hand-collected variable), this is the script where you would join it
# to the cleaned World Bank data on iso3c.
#
# For now, the analysis-ready file is:
#   data/processed/wb_indicators_2023_clean.csv
#
# Proceed to 04_analysis.R.
