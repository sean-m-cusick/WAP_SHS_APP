# Loading in packages
library(tidyverse)
library(shiny)
library(shinyjs)
library(shinydashboard)
library(shinythemes)
library(DT)
library(leaflet)
library(sf)
library(here)
library(plotly)
library(lubridate)
library(slider)
library(broom)
library(janitor)
library(stringr)
library(rgdal)

# Loading in PHS data
# loading hospitan location data
df_hospital_location  <- read_csv(here("clean_data/df_hospital_location.csv"))
hospital_activty_dep  <- read_csv(here("clean_data/df_ha_dep.csv"))
df_cov_hb_ans         <- read_csv(here("clean_data/df_cov_hb_ans.csv"))
df_general_stat       <- read_csv(here("clean_data/df_day_trend_loc.csv"))
ane_weekly_full       <- read_csv(here("clean_data/df_ane_hb_ans.csv"))

 
#Launch App
#shinyApp(ui = ui, server = server)
