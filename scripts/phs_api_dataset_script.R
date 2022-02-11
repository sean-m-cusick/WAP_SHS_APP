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


# API Function
#--------------------------------------------------------------------------#
# Function for fetching phs dataframes
phs_df_func <- function(id){
  
  # Link templates for simplicity
  phs_url = "https://www.opendata.nhs.scot/api/3/action/datastore_search?resource_id="
  # fetch maximum 999'999 results for simplicity
  limit_url = "&limit=999999"
  
  # construct URL for fetching process
  url_link <- paste0(phs_url, id, limit_url) %>%
    fromJSON()
  
  # construct dataframe from url
  phs_df <-  url_link[["result"]][["records"]] %>% 
    clean_names()
  
  return(phs_df)
  
}


phs_dictionary_func <- function(id){
  
  # Link templates for simplicity
  phs_url = "https://www.opendata.nhs.scot/api/3/action/datastore_search?resource_id="
  # fetch maximum 999'999 results for simplicity
  limit_url = "&limit=10"
  
  # construct URL for fetching process
  url_link <- paste0(phs_url, id, limit_url) %>%
    fromJSON()
  
  # construct dataframe from url
  phs_dictionary <-  url_link[["result"]][["fields"]] %>% 
    jsonlite::flatten(recursive = TRUE) %>% 
    select(id, info.label, type)
  #    jsonlite::flatten(recursive = TRUE, use.names = TRUE)
  
  return(phs_dictionary)
}


# PHS API (ID)
#--------------------------------------------------------------------------#
# Data Group 00 -  Location / ID Identifier ----
# Hospital LOCATION List
api_hospital_location = "c698f450-eeed-41a0-88f7-c1e40a568acc"
# Health Board List (Health Board)
api_health_board = "652ff726-e676-4a20-abda-435b98dd7bdc"
api_special_health_board = "0450a5a2-f600-4569-a9ae-5d6317141899"
# HSCP List 
api_hscp = "944765d7-d0d9-46a0-b377-abb3de51d08e"
####
####
####
# Data Group 01 - Hospital Activity ----
# Dataset 1A - Hospital Activity by Speciality
api_ha_spe = "c3b4be64-5fb4-4a2f-af41-b0012f0a276a" 
# Dataset 1B - Hospital Activity and Patient Demographics
api_ha_ans = "00c00ecc-b533-426e-a433-42d79bdea5d4"
# Dataset 1C - Hospital Activity and Deprivation
api_ha_dep = "4fc640aa-bdd4-4fbe-805b-1da1c8ed6383"
####
####
####
# Data Group 02 - Hospitalisations due to Covid 19 ----
# Dataset 2A - Admissions By Health Board and Specialty
api_cov_hb_spe = "b8aeb539-fcf8-4f66-aae8-20213508a1b7"
# Dataset 2B - Admissions By Health Board and Patient Demographics
api_cov_hb_ans = "f8f3a435-1925-4c5a-b2e8-e58fdacf04bb"
# Dataset 2C - Admissions By Health Board and Deprivation
api_cov_hb_dep = "746f9bac-77f1-43fe-b69f-5ca2cde2201b"
# Dataset 2D - Admissions By HSCP and Specialty
api_cov_hscp_spe =  "02696773-7aaf-48ce-b3d5-479d86fc8334"
# Dataset 2E - Admissions By HSCP and Patient Demographics
api_cov_hscp_ans = "aec5cc00-3ad6-41fb-9101-37c66bad29d4"
# Dataset 2F - Admissions By HSCP and Deprivation
api_cov_hscp_dep = "95a324b3-7610-4151-9287-ccd9cb191686"


####
####
####
# Data Group 03 -  A&E Activity  ----
# A&E Activity by Health Board, Age and Sex
api_ane_hb_ans = "388fd86c-dc0b-4655-b4b1-f13644bfd8d2"
# A&E Activity by Health Board and Deprivation
api_ane_hb_dep = "ec70ded6-9f45-4348-aaa9-b1b40ddae6a4"
# A&E Activity by HSCP, Age and Sex
api_ane_hscp_ans =  "a5677672-cc57-4b36-a884-84d6befd570f"
# A&E Activity by HSCP and Deprivation
api_ane_hscp_dep =  "39da7e8d-0ecf-41b7-aef1-cd898ba8b4fa"
####
####
####
# Data Group 04 - Bed Capacity ----
# Beds by Board of Treatment and Specialty
api_bed_info = "f272bb7d-5320-4491-84c1-614a2c064007"

####
####
####
# Data Group 05 - COVID-19 Wider Impacts - Scottish Ambulance Services ----
# SAS Incidents By Health Board, Age and Sex
api_sas_health_board_age_sex = "d1d2d098-193f-489c-940a-a828fdcfc357"
# SAS Incidents By Health Board and Deprivation
api_sas_health_deprivation = "12e52d78-bff5-4fde-8085-f1b03667a8e5"
# SAS Incidents By HSCP, Age and Sex
api_sas_hscp_age_sex = "0a3992c3-a712-4adf-b3b3-928850cc65ff"
# SAS Incidents By HSCP and Deprivation
api_sas_hscp_deprivation = "1329dfdb-0dd7-428b-9afb-b8fb3e438518"
####
####
####
# Data Group 06 - COVID-19 Cases in Scotland ----
# Total Cases By Health Board
api_total_cov_health_board = "7fad90e5-6f19-455b-bc07-694a22f8d5dc"
# Total Cases By Local Authority
api_total_cov_local_authority = "e8454cf0-1152-4bcb-b9da-4343f625dfef"
# Total Cases By Age and Sex
api_total_cov_age_sex = "19646dce-d830-4ee0-a0a9-fcec79b5ac71"
# Total Cases By Deprivation
api_total_cov_deprivation = "a965ee86-0974-4c93-bbea-e839e27d7085"

# Daily and Cumulative Cases ---
api_daily_cumulative_cov = "287fc645-4352-4477-9c8c-55bc054b7e76"
# Daily Case Trends By Health Board
api_daily_trends_health_board = "2dd8534b-0a6f-4744-9253-9565d62f96c2"
# Daily Case Trends By Local Authority
api_daily_trends_local_authority = "427f9a25-db22-4014-a3bc-893b68243055"
# Daily Case Trends By Age and Sex
api_daily_trend_age_sex = "9393bd66-5012-4f01-9bc5-e7a10accacf4"
# Daily Case Trends By Deprivation
api_daily_trend_deprivation = "a38a4c21-7c75-4ecd-a511-3f83e0e8f0c3"

# Seven day trends by Neighbourhood ---
api_seven_day_trends_neighbourhood = "8906de12-f413-4b3f-95a0-11ed15e61773"


# Load in API Dataframe (Backup)
#--------------------------------------------------------------------------#
``{r, echo=FALSE, message=FALSE, results='hide'}
# Data Group 00 - Hospital Location Info ---
backup_hospital_location = phs_df_func(api_hospital_location)
backup_health_board = phs_dictionary_func(api_health_board)

# Data Group 01
# Dataset 1A - Hospital Activity by Speciality
backup_ha_spe = phs_df_func(api_ha_spe)
# Dataset 1B - Hospital Activity and Patient Demographics
backup_ha_ans = phs_df_func(api_ha_ans)
# Dataset 1C - Hospital Activity and Deprivation
backup_ha_dep = phs_df_func(api_ha_dep)


# Data Group 02 ---
# Hospitalisations due to Covid 19
# Dataset 2A - Admissions By Health Board and Specialty
backup_cov_hb_spe = phs_df_func(api_cov_hb_spe)
# Dataset 2B - Admissions By Health Board and Patient Demographics
backup_cov_hb_ans = phs_df_func(api_cov_hb_ans)
# Dataset 2C - Admissions By Health Board and Deprivation
backup_cov_hb_dep = phs_df_func(api_cov_hb_dep)
# Dataset 2D - Admissions By HSCP and Specialty
backup_cov_hscp_spe = phs_df_func(api_cov_hscp_spe)
# Dataset 2E - Admissions By HSCP and Patient Demographics
backup_cov_hscp_ans = phs_df_func(api_cov_hscp_ans)
# Dataset 2F - Admissions By HSCP and Deprivation
backup_cov_hscp_dep = phs_df_func(api_cov_hscp_dep)


# Data Group 03  ---
# A&E Activity by Health Board, Age and Sex
backup_ane_hb_ans <- phs_df_func(api_ane_hb_ans)
# A&E Activity by Health Board and Deprivation
backup_ane_hb_dep <- phs_df_func(api_ane_hb_dep)
# A&E Activity by HSCP, Age and Sex
backup_ane_hscp_ans =  phs_df_func(api_ane_hscp_ans)
# A&E Activity by HSCP and Deprivation
backup_ane_hscp_dep =  phs_df_func(api_ane_hscp_dep)


# Data Group 04 - Bed Capacity ---
# Beds by Board of Treatment and Specialty
backup_bed_info = phs_df_func(api_bed_info)


# Data Group 05 - COVID-19 Wider Impacts - Scottish Ambulance Services ----
backup_sas_health_board_age_sex = phs_df_func(api_sas_health_board_age_sex)
backup_sas_health_deprivation = phs_df_func(api_sas_health_deprivation)
backup_sas_hscp_age_sex = phs_df_func(api_sas_hscp_age_sex)
backup_sas_hscp_deprivation = phs_df_func(api_sas_hscp_deprivation)


# Data Group 06 - Daily COVID-19 Cases in Scotland ----
backup_total_cov_health_board  = phs_df_func(api_total_cov_health_board)
backup_total_cov_local_authority = phs_df_func(api_total_cov_local_authority)
backup_total_cov_age_sex = phs_df_func(api_total_cov_age_sex)
backup_total_cov_deprivation = phs_df_func(api_total_cov_deprivation)
backup_daily_cumulative_cov = phs_df_func(api_daily_cumulative_cov)
backup_daily_trends_health_board = phs_df_func(api_daily_trends_health_board)
backup_daily_trends_local_authority = phs_df_func(api_daily_trends_local_authority)
backup_seven_day_trends_neighbourhood = phs_df_func(api_seven_day_trends_neighbourhood)
backup_daily_trend_age_sex = phs_df_func(api_daily_trend_age_sex)
backup_daily_trend_deprivation = phs_df_func(api_daily_trend_deprivation)




# file name function ---
make_file_names <- function(x) paste0(target_directory,x,".csv")
save_csv <- function(x) write_csv(obj_list[[x]],file_name[[x]])

target_directory <- here("raw_data//")


name_pattern <- grep("backup_",names(.GlobalEnv),value=TRUE)
obj_list     <- do.call("list",mget(name_pattern))
file_name      <- make_file_names(names(obj_list))

for (i in seq_along(names(obj_list))) save_csv(i)

# Create Dataframe List ----
name_list <- as_tibble(name_pattern) %>% arrange(value)
namelist_path <- paste0(target_directory,"00_Backup_Dataframe_List.csv")

write.csv(name_list, namelist_path, row.names = FALSE)