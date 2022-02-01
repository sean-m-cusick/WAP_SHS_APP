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



# Loading in Life expectancy data
life_expectancy_data <- read_csv(here("clean_data/life_expectancy_clean.csv")) %>%
  mutate(local_authority = if_else(local_authority == "Na h-Eileanan Siar", "Eilean Siar", local_authority),
         value = round(value, 2)) %>%
  rename(gender = sex) %>%
  filter(age == "0 years")

# Loading in Scotland shape file
scotland_shape <- st_read(here("clean_data/shape_data/pub_las.shp")) %>%
  st_simplify(dTolerance = 1000) %>%
  st_transform("+proj=longlat +datum=WGS84")

# Loading in drug data
drug_deaths <- read_csv(here("clean_data/drug_deaths_clean.csv"))

# Loading in alcohol data
alcohol_deaths <- read_csv(here("clean_data/alcohol_deaths_clean.csv")) %>%
  mutate(gender = case_when(gender == "male" ~ "Male",
                            gender == "female" ~ "Female"))
alcohol_area <- read_csv(here("clean_data/alcohol_deaths_area.csv"))

#Launch App
#shinyApp(ui = ui, server = server)
