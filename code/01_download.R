library(here)
library(tidyverse)
library(httr2)       # for API requests; swap for curl/jsonlite as needed

# ── 1. Define sources ─────────────────────────────────────────────────────────

sources <- tribble(
  ~name,   ~url,
  # "wb_gdp", "https://api.worldbank.org/v2/..."   # TODO: add source URLs
)

# ── 2. Download ───────────────────────────────────────────────────────────────

# TODO: loop over sources and save each to data/raw/
# Example pattern:
#
# walk(sources$name, function(nm) {
#   url <- sources$url[sources$name == nm]
#   resp <- request(url) |> req_perform()
#   resp_body_raw(resp) |>
#     writeBin(here("data", "raw", paste0(nm, ".csv")))
#   message("Downloaded: ", nm)
# })
