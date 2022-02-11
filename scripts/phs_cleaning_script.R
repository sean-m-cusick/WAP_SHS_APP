# Packages
#--------------------------------------------------------------------------#
library(tidyverse)
library(sf)
library(janitor)
library(jsonlite)
library(lubridate)
library(rgdal)
library(here)
library(broom)
require(readr)
require(here)


# Cleaning & Merging Dataset
#--------------------------------------------------------------------------#

## Data Group 00 - Hospital Location
# Hospital Location
df_hospital_location <-   read_csv("raw_data/backup_hospital_location.csv") %>%
  select(-ends_with("qf"), -id) %>% 
  mutate(x_coordinate = replace_na(x_coordinate, 327699),
         y_coordinate = replace_na(y_coordinate, 669148))


lat_long_convert <- df_hospital_location %>%
  st_as_sf(coords = c("x_coordinate", "y_coordinate"), crs = 27700) %>%
  st_transform(4326) %>%
  st_coordinates() %>%
  as_tibble() %>% 
  rename(longitude = X,
         latitude = Y)

df_hospital_location <- df_hospital_location %>% 
  bind_cols(lat_long_convert)

# function to assign hospital name, longitude & latitude to dataframe
# hospital_location_func(datafram, "key column")
hospital_location_func <- function(df, key_col){
  df <- df %>% 
    # Select location & hb as forgein keys
    # Join location_name, longitude & latitude to the main dataframe
    left_join(df_hospital_location %>% select(key_col, location_name, longitude, latitude),
              by = c(key_col),
              all.x = TRUE)
  
  return(df)
}


df_health_board <- read_csv("raw_data/backup_health_board.csv")
# 
# NHSBoards <- readOGR(dsn = "SG_NHS_HealthBoards_2019.shp", 
#                      layer = "SG_NHS_HealthBoards_2019")


## Data Group 01 - Hospital Activity ---
# clean_quart_func(dataframe)
clean_quart_func <- function(df){
  df <- df %>% 
    select(-ends_with("qf"), -id) %>% 
    mutate(year = substr(quarter, 1,4),
           quarter = substr(quarter,nchar(quarter), nchar(quarter))) %>% 
    # Relocate the year and quarter columns to the start
    relocate(c("year" ,"quarter"), .before = 1)
  # Return cleaned dataframe
  return(df)
}

# Dataset 1A - Hospital Activity by Speciality ---
df_ha_spe <- clean_quart_func(read_csv("raw_data/backup_ha_spe.csv"))
# Dataset 1B - Hospital Activity and Patient Demographics
# change column "age" to "age_group" for consisitency
df_ha_ans <- clean_quart_func(read_csv("raw_data/backup_ha_ans.csv")) %>% 
  rename(age_group = age)
# Dataset 1C - Hospital Activity and Deprivation
df_ha_dep <- clean_quart_func(read_csv("raw_data/backup_ha_dep.csv")) 


## Data Group 02 - Hospitalisations due to Covid 19
```{r, echo=FALSE, message=FALSE, results='hide'}
# Clean Hospitalisations Dataset function
clean_wkend_func <- function(df){
  df <- df %>% 
    # Remove any columns ends with qf (Qualifier)
    select(-ends_with("qf"), -id) %>% 
    # Extract he quarter, year info from week_ending
    mutate(week_ending = as.Date(ymd(week_ending)),
           quarter     = quarter(week_ending),
           year        = year(week_ending)) %>% 
    # Relocate the year and quarter columns to the start
    relocate(c("year" ,"quarter"), .before = 1)
  # Return cleaned dataframe
  return(df)
}

# Dataset 2A - Admissions By Health Board and Speciality ---
df_cov_hb_spe  <- clean_wkend_func(read_csv("raw_data/backup_cov_hb_spe.csv"))
# Dataset 2B - Admissions By Health Board and Patient Demographics
df_cov_hb_ans <- clean_wkend_func(read_csv("raw_data/backup_cov_hb_ans.csv"))
# Dataset 2C - Admissions By Health Board and Deprivation
df_cov_hb_dep <- clean_wkend_func(read_csv("raw_data/backup_cov_hb_dep.csv"))
# Dataset 2D - Admissions By HSCP and Speciality
df_cov_hscp_spe <- clean_wkend_func(read_csv("raw_data/backup_cov_hscp_spe.csv"))
# Dataset 2E - Admissions By HSCP and Patient Demographics
df_cov_hscp_ans <- clean_wkend_func(read_csv("raw_data/backup_cov_hscp_ans.csv"))
# Dataset 2F - Admissions By HSCP and Deprivation
df_cov_hscp_dep <- clean_wkend_func(read_csv("raw_data/backup_cov_hscp_dep.csv"))


##Data Group 03 - A&E Activity ---
# Data Group 03 -  A&E Activity

# Dataset 3A - A&E Activity by Health Board, Age and Sex
df_ane_hb_ans <- clean_wkend_func(read_csv("raw_data/backup_ane_hb_ans.csv"))

# Dataset 3B - A&E Activity by Health Board and Deprivation
df_ane_hb_dep <- clean_wkend_func(read_csv("raw_data/backup_ane_hb_dep.csv"))

# Dataset 3C - A&E Activity by HSCP, Age and Sex
df_ane_hscp_ans <-  clean_wkend_func(read_csv("raw_data/backup_ane_hscp_ans.csv"))

# Dataset 3D - A&E Activity by HSCP and Deprivation
df_ane_hscp_dep <-  clean_wkend_func(read_csv("raw_data/backup_ane_hscp_dep.csv"))
```


## Data Group 04 - Hospital Bed Information
df_bed_info <- clean_quart_func(read_csv("raw_data/backup_bed_info.csv"))


# Data Group 05 - COVID-19 Wider Impacts - Scottish Ambulance Services ----
df_sas_hb_ans <- clean_wkend_func(read_csv("raw_data/backup_sas_health_board_age_sex.csv"))
df_sas_hb_dep <- clean_wkend_func(read_csv("raw_data/backup_sas_health_deprivation.csv"))
df_sas_hscp_ans <- clean_wkend_func(read_csv("raw_data/backup_sas_hscp_age_sex.csv"))
df_sas_hscp_dep <- clean_wkend_func(read_csv("raw_data/backup_sas_hscp_deprivation.csv"))


# Data Group 06 - Daily COVID-19 Cases in Scotland ----

clean_general_func <- function(df){
  df <- df %>% 
    select(-ends_with("qf"), -id) %>% 
    mutate(date = as.Date(ymd(date))) 
  return(df)
}

df_tot_cov_hb <- read_csv("raw_data/backup_total_cov_health_board.csv") %>% 
  clean_general_func()
#local authority
df_tot_cov_loc <- read_csv("raw_data/backup_total_cov_local_authority.csv") %>% 
  clean_general_func()
df_tot_cov_ans <- read_csv("raw_data/backup_total_cov_age_sex.csv")  %>% 
  clean_general_func()
df_tot_cov_dep <- read_csv("raw_data/backup_total_cov_deprivation.csv") %>% 
  clean_general_func()

# commutative covid cases
df_day_cum_cov <- read_csv("raw_data/backup_daily_cumulative_cov.csv")  %>% 
  clean_general_func()
df_day_trend_hb <- read_csv("raw_data/backup_daily_trends_health_board.csv") %>% 
  clean_general_func()
df_day_trend_loc <- read_csv("raw_data/backup_daily_trends_local_authority.csv") %>% 
  clean_general_func()
df_day_trend_ans <- read_csv("raw_data/backup_daily_trend_age_sex.csv")  %>% 
  clean_general_func()

df_sevday_trend_neighbourhood <- read_csv("raw_data/backup_seven_day_trends_neighbourhood.csv")  %>% 
  clean_general_func()


## Age & Sex Data Frame related ----

df_age_group_ha_ans <- df_ha_ans %>% 
  mutate(age_group = factor(age_group, levels = c("0-9 years","10-19 years" ,"20-29 year", "30-39 years", "40-49 years", "50-59 years", "60-69 years", "70-79 years", "80-89 years", "90 years and over"))) %>%
  arrange(age_group)

df_age_group_cov_hb_ans <- df_cov_hb_ans %>% 
  filter(age_group != "All ages") %>% 
  mutate(age_group = factor(age_group, levels = c("Under 5","5 - 14" ,"15 - 44", "45 - 64", "65 - 74", "75 - 84", "85 and over")
  )) %>%
  arrange(age_group)

df_age_group_cov_hscp_ans <- df_cov_hscp_ans %>% 
  filter(age_group != "All ages") %>% 
  mutate(age_group = factor(age_group, levels = c("Under 5","5 - 14" ,"15 - 44", "45 - 64", "65 - 74", "75 - 84", "85 and over")
  )) %>%
  arrange(age_group)

df_age_ane_hscp_ans <- df_ane_hscp_ans %>% 
  filter(age_group != "All ages") %>% 
  mutate(age_group = factor(age_group, levels = c("Under 5","5 - 14" ,"15 - 44", "45 - 64", "65 - 74", "75 - 84", "85 and over")
  )) %>%
  arrange(age_group)

df_age_sas_hb_ans <- df_sas_hscp_ans %>% 
  filter(age_group != "All ages") %>% 
  mutate(age_group = factor(age_group, levels = c("Under 5","5 - 14" ,"15 - 44", "45 - 64", "65 - 74", "75 - 84", "85 and over")
  )) %>%
  arrange(age_group) 

df_age_sas_hscp_ans <- df_sas_hscp_ans %>% 
  filter(age_group != "All ages") %>% 
  mutate(age_group = factor(age_group, levels = c("Under 5","5 - 14" ,"15 - 44", "45 - 64", "65 - 74", "75 - 84", "85 and over")
  )) %>%
  arrange(age_group) 

df_age_tot_cov_ans <- df_tot_cov_ans %>%
  filter(age_group != "0 to 59" & age_group != "60+" & age_group != "Total") %>%
  mutate(
    age_group = case_when(
      age_group == "0 to 14" ~ "Under 14",
      age_group == "15 to 19" ~ "15 - 19",
      age_group == "20 to 24" ~ "20 - 24",
      age_group == "25 to 44" ~ "25 - 44",
      age_group == "45 to 64" ~ "45 - 64",
      age_group == "65 to 74" ~ "65 - 74",
      age_group ==  "85plus" ~ "85 and over")) %>%
  mutate(age_group = factor(age_group, levels = c(
    "Under 14",
    "15 - 19" ,
    "20 - 24",
    "25 - 44",
    "45 - 64",
    "65 - 74",
    "85 and over"))) %>%
  arrange(age_group)


df_age_day_trend_ans <- df_day_trend_ans %>%
  filter(age_group != "0 to 59" & age_group != "60+" & age_group != "Total") %>%
  mutate(
    age_group = case_when(
      age_group == "0 to 14" ~ "Under 14",
      age_group == "15 to 19" ~ "15 - 19",
      age_group == "20 to 24" ~ "20 - 24",
      age_group == "25 to 44" ~ "25 - 44",
      age_group == "45 to 64" ~ "45 - 64",
      age_group == "65 to 74" ~ "65 - 74",
      age_group ==  "85plus" ~ "85 and over")) %>%
  mutate(age_group = factor(age_group, levels = c(
    "Under 14",
    "15 - 19" ,
    "20 - 24",
    "25 - 44",
    "45 - 64",
    "65 - 74",
    "85 and over"))) %>%
  arrange(age_group)



make_file_names <- function(x) paste0(target_directory,x,".csv")
save_csv <- function(x) write_csv(obj_list[[x]],file_name[[x]])

target_directory <- here("clean_data//")

name_pattern <- grep("df_",names(.GlobalEnv),value=TRUE)
obj_list     <- do.call("list",mget(name_pattern))
file_name      <- make_file_names(names(obj_list))

for (i in seq_along(names(obj_list))) save_csv(i)

# Create Dataframe List
name_list <- as_tibble(name_pattern) %>% arrange(value)
namelist_path <- paste0(target_directory,"00_Clean_Dataframe_List.csv")

write.csv(name_list, namelist_path, row.names = FALSE)

# 
# Abbreviation      | Definition
# :------------- | :-------------
#   KLAS           | Kang, Lucy, Aboubakar, Seàn  
# MVP           | Minimum Viable Product 
# WP           | Work Package
# WPD          |  Work Package Description
# WBS            | Work Breakdown Structure
# App           | Application
# UI           | User Interface  
# A&E           | Accident and Emergency
# COVID           | Disease caused by the SARS-CoV2 virus
# IDR           | Initial Design Review
# DDR           | Detailed Design Review 
# IDR           | Initial Design Review
# DDR           | Detailed Design Review 
# IDR           | Initial Design Review
# DDR           | Detailed Design Review 