library(tidyverse)
library(lubridate)
library(tidyr)
library(dplyr)
library(sf)
library(tigris)

#Load the data from Zillow into R
zhvi_raw <- read.csv("C:/Users/intern1/Downloads/County_zhvi_uc_sfrcondo_tier_0.33_0.67_sm_sa_month.csv")


#Create a vector of ID columns so we can filter them out from the rest of the data
id_columns <- names(zhvi_raw)[1:9]


#Convert the raw, wide data into long form
zhvi_transposed <- zhvi_raw %>% 
  pivot_longer(
    cols = -all_of(id_columns), 
    names_to = "date", 
    values_to = "zhvi"
  )  %>%
  mutate(
    date = gsub("^X", "", date), #Remove the leading X from the date strings
    date = ymd(date)             #Convert date strings to actual dates
  )


#Ensure we have proper dates in the date column
zhvi_transposed <- zhvi_transposed %>% 
  mutate(date = as.Date(unlist(date)))


#Filter down so that we are only looking at Texas counties
zhvi_tx <- zhvi_transposed %>% 
  filter(StateName == "TX")


#Filter so that we are only looking at data from 2017-2023 
zhvi_tx_2017_2023 <-zhvi_tx  %>%
  filter(date >= as.Date("2017-01-01") & date <= "2023-01-01")


#Add columns to store the year and month for each data point separately 
zhvi_tx_2017_2023 <- zhvi_tx_2017_2023 %>%
  mutate(
    year = year(date),
    month = month(date)
  )
