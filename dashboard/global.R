# Loading in packages
library(tidyverse)
library(shiny)
library(DT)
library(shinydashboard)
library(leaflet)
library(sf)
library(here)
library(plotly)
library(lubridate)
library(slider)


# Loading in PHS data
# loading hospitan location data
df_hospital_location  <- read_csv(here("clean_data/df_hospital_location.csv"))
hospital_activty_dep  <- read_csv(here("clean_data/df_ha_dep.csv"))
df_cov_hb_ans         <- read_csv(here("clean_data/df_cov_hb_ans.csv"))
#df_hospital_location  <- read_csv(here("clean_data/df_hospital_location.csv"))
life_expectancy_data <- df_hospital_location
# Loading in Scotland shape file
scotland_shape <- st_read(here("clean_data/Temp_files/shape_data/pub_las.shp")) %>%
  st_simplify(dTolerance = 1000) %>%
  st_transform("+proj=longlat +datum=WGS84")

# Loading in drug data
drug_deaths <- read_csv(here("clean_data/Temp_files/drug_deaths_clean.csv"))

# Loading in alcohol data
alcohol_deaths <- read_csv(here("clean_data/Temp_files/alcohol_deaths_clean.csv")) %>%
  mutate(gender = case_when(gender == "male" ~ "Male",
                            gender == "female" ~ "Female"))
alcohol_area <- read_csv(here("clean_data/Temp_files/alcohol_deaths_area.csv"))

#Launch App
#shinyApp(ui = ui, server = server)
