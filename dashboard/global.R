# Loading in packages ----
library(tidyverse)
library(shiny)
library(shinythemes)
library(CodeClanData)
library(giscoR)
library(sf)
library(DT)
library(leaflet)
#library(leaflet.extras)






# Loading in Scotland shape file ----
whisky_data_spatial <- whisky_data %>% 
  st_as_sf(coords = c("Latitude", "Longitude"), crs = 4326)
scotland <- giscoR::gisco_get_nuts(nuts_id = 'UKM',
                                   resolution = '01')
# Loading in Life expectancy data ----
whisky_data <- whisky
all_regions <- unique(whisky_data_spatial$Region)
all_distilleries <- unique(whisky_data_spatial$Distillery)
# scotland_shape <- st_read(here("clean_data/shape_data/pub_las.shp")) %>%
#   st_simplify(dTolerance = 1000) %>%
#   st_transform("+proj=longlat +datum=WGS84")

# palette ----
dregion_palette <- leaflet::colorFactor(
  palette = c(
    "Campbeltown" = "#CD3700",
    "Highlands" = "#BBFFFF",
    "Islay" = "#7CCD7C",
    "Lowlands" = "#FFDAB9",
    "Speyside" = "#912CEE"),
  domain = whisky_data_spatial$Region)


# Launch App  -----
#shinyApp(ui = ui, server = server)