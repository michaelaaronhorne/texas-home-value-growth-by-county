# A Spatial Analysis of Texas Home Value Growth by County (2017–2023)

**Author:** Michael Horne  
**Tools:** R, tidyverse, sf, tigris, ggplot2  

## Project Overview
This project analyzes county-level residential home value growth across Texas using the Zillow Home Value Index (ZHVI). The goal is to identify spatial and temporal patterns in housing appreciation during the three years before and after the COVID-19 pandemic.

The analysis focuses on:
- 2017–2020 (pre-COVID)
- 2020–2023 (post-COVID)

## Methods
- Collected and transformed Zillow ZHVI data from wide to long format
- Filtered and aggregated county-level home values for selected years
- Calculated percentage growth rates over time
- Joined housing data with U.S. Census county shapefiles
- Produced choropleth maps visualizing spatial patterns in home value growth

## Key Findings
- Home value growth was strongest in urban and suburban counties in both periods
- Post-COVID growth accelerated significantly relative to pre-COVID trends
- Growth disparities between metropolitan and rural counties widened after 2020

## Repository Structure
- `report/` – Final PDF report with analysis and visualizations
- `code/` – R scripts for data preparation, analysis, and mapping
- `data/` – Documentation of data sources (raw data not included)

## Relevance
This project demonstrates applied research skills relevant to Texas residential real estate analysis, including data acquisition, spatial analysis, visualization, and clear communication of results.
