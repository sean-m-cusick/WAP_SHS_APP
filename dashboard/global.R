# Loading in packages ----
library(tidyverse)
library(shiny)
library(DT)
library(shinydashboard)
library(leaflet)
library(sf)
library(here)
library(plotly)
library(lubridate)

# Data Files ------
# Daily COVID health Board?
# Loading in COVID / Health Board / ans?
cov_hb_ans <- read_csv(here("../clean_data/df_cov_hb_ans.csv"))

# Loading in COVID / Health Board / Deprivation
cov_hb_dep <- read_csv(here("../clean_data/df_cov_hb_dep.csv"))

# Loading in COVID / Health Board / Speciality
cov_hb_spe <- read_csv(here("../clean_data/df_cov_hb_spe.csv"))


# Daily Covid HSCP?
# Loading in COVID / Health Board / ans?
cov_hscp_ans <- read_csv(here("../clean_data/df_cov_hscp_ans.csv"))

# Loading in COVID / Health Board / Deprivation
cov_hscp_dep <- read_csv(here("../clean_data/df_cov_hscp_dep.csv"))

# Loading in COVID / Health Board / Speciality
cov_hscp_spe <- read_csv(here("../clean_data/df_cov_hscp_spe.csv"))



# TEMPORARY FILES -----
# Loading in Life expectancy data
# life_expectancy_data <- read_csv(here("clean_data/Temp_files/life_expectancy_clean.csv")) %>%
#   mutate(local_authority = if_else(local_authority == "Na h-Eileanan Siar", "Eilean Siar", local_authority),
#          value = round(value, 2)) %>%
#   rename(gender = sex) %>%
#   filter(age == "0 years")
# 
# # Loading in Scotland shape file
# scotland_shape <- st_read(here("clean_data/Temp_files/shape_data/pub_las.shp")) %>%
#   st_simplify(dTolerance = 1000) %>%
#   st_transform("+proj=longlat +datum=WGS84")
# 
# # Loading in drug data
# drug_deaths <- read_csv(here("clean_data/Temp_files/drug_deaths_clean.csv"))
# 
# # Loading in alcohol data
# alcohol_deaths <- read_csv(here("clean_data/Temp_files/alcohol_deaths_clean.csv")) %>%
#   mutate(gender = case_when(gender == "male" ~ "Male",
#                             gender == "female" ~ "Female"))
# alcohol_area <- read_csv(here("clean_data/Temp_files/alcohol_deaths_area.csv"))

#Launch App
#shinyApp(ui = ui, server = server)
