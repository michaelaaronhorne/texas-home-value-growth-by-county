library(tidyverse)
library(lubridate)
library(tidyr)
library(dplyr)
library(sf)
library(tigris)


#Cache shapefiles 
options(tigris_use_cache = TRUE)


#Make sf object with Texas county boundaries
tx_counties_sf <- counties(
  state = "TX",
  cb = TRUE,
)


#Clean county names from analysis step and from the shapefiles to prep for joining
zhvi_growth_tx_2017_2023_final <- zhvi_growth_tx_2017_2023_final %>%
  mutate(
    county_clean = str_remove(RegionName, " County")
  )

tx_counties_sf <- tx_counties_sf %>%
  mutate(
    county_clean = NAME
  )

zhvi_growth_tx_2017_2023_final <- zhvi_growth_tx_2017_2023_final %>%
  mutate(county_clean = str_squish(county_clean))

zhvi_growth_tx_2017_2023_final <- zhvi_growth_tx_2017_2023_final %>%
  mutate(county_clean = str_to_title(county_clean))

tx_counties_sf <- tx_counties_sf %>%
  mutate(county_clean = str_squish(county_clean))

tx_counties_sf <- tx_counties_sf %>%
  mutate(county_clean = str_to_title(county_clean))


#Join Zillow data to the spatial data frame (sf object)
tx_housing_sf <- tx_counties_sf %>%
  left_join(
    zhvi_growth_tx_2017_2023_final,
    by = "county_clean"
  )


#Use extremes from the percentage change analysis to standardize the color scale for both graphs
global_limits <- range(
  tx_housing_sf$pct_change_2017_2020,
  tx_housing_sf$pct_change_2020_2023,
  na.rm = TRUE
)


#Create choropleth graph of our results 
ggplot(tx_housing_sf) +
  geom_sf(aes(fill = pct_change_2017_2020), color = "white") +
  scale_fill_viridis_c(
    option = "C", 
    limits = global_limits,
    na.value = "grey80",   # Gray color for counties with missing data
    name = "% Change\n(2017–2020)"
  ) +
  labs(
    title = "Texas Home Value Growth by County",
    subtitle = "ZHVI, 2017 to 2020 (Missing counties in gray)",
    caption = "Source: Zillow Housing Data"
  ) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank()
  )


ggplot(tx_housing_sf) +
  geom_sf(aes(fill = pct_change_2020_2023), color = "white") +
  scale_fill_viridis_c(
    option = "C", 
    limits = global_limits,
    na.value = "grey80",   # Gray for missing
    name = "% Change\n(2020–2023)"
  ) +
  labs(
    title = "Post-Pandemic Texas Home Value Growth by County",
    subtitle = "ZHVI, 2020 to 2023 (Missing counties in gray)",
    caption = "Source: Zillow Housing Data"
  ) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank()
  )
