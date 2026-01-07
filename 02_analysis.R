library(tidyverse)
library(lubridate)
library(tidyr)
library(dplyr)
library(sf)
library(tigris)


#Filter so that we only look at data from January of 2017, 2020, and 2023
zhvi_growth <- zhvi_tx_2017_2023 %>%
  filter(
    (year == 2017 & month == 1) |
      (year == 2020 & month == 1) |
      (year == max(year) & month ==1)
  ) %>%
  select(RegionName, Metro, year, month, date, zhvi)


#Convert back to wide format to prepare for calculations
zhvi_wide_tx_2017_2023 <- zhvi_growth %>%
  mutate(period = case_when(
    year == 2017 & month == 1 ~ "zhvi_2017",
    year == 2020 & month == 1 ~ "zhvi_2020",
    year == max(year) & month == 1 ~ "zhvi_2023"
  )) %>%
  select(RegionName, Metro, period, zhvi) %>%
  pivot_wider(
    names_from = period,
    values_from = zhvi
  )


#Calculate percentage increase in ZHVI for each county in both windows of time
zhvi_growth_tx_2017_2023_final <- zhvi_wide_tx_2017_2023 %>%
  mutate(
    pct_change_2017_2020 = (zhvi_2020 / zhvi_2017 - 1) * 100,
    pct_change_2020_2023 = (zhvi_2023 / zhvi_2020 - 1) * 100
  )
