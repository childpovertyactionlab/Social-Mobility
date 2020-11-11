rm(list=ls(all=TRUE))
setwd("E:/CPAL Dropbox")
library(tidycensus)
library(tidyverse)
library(rio)
library(tigris)

#census_api_key("aed7bfa15ecfb5bdac5fc798f4bd0aa63d56bab4", install = TRUE)
acs18 <- load_variables(2018, "acs5", cache = TRUE)
#view(acs18)
#data(fips_codes)
years <- lst(2013, 2018)
counties <- c("dallas", "rockwall", "collin county", "denton", "tarrant", "kaufman", "ellis")

#setting up the geocodes for the areas of interest to be pulled from tidycensus
zip <- import("Living Wage Jobs/04_Projects/Social Mobility/Data/Geography/socmob_zcta.csv")
places <- import("Living Wage Jobs/04_Projects/Social Mobility/Data/Geography/socmob_place.csv")

colnames(zip)
colnames(places)

zip <- zip %>%
  mutate(GEOID = as.character(GEOID10)) %>%
  select(GEOID)

places <- places %>%
  mutate(GEOID = as.character(GEOID)) %>%
  select(GEOID)

#list of the necessary variables to pull
socmob.var <- c(
  tot.pop = "B01003_001", 
  med.inc = "B19013_001",
  gini = "B19083_001",
  less.hs = "B06009_002",
  hs.deg = "B06009_003",
  some.col = "B06009_004",
  ba.deg = "B06009_005",
  grad.deg = "B06009_006",
  tot.deg = "B06009_001"
)

#tidycensus pull of zip locations for 2013 and 2018 5-year acs zcta data
socmob.zip <- map_dfr(
  years,
  ~get_acs(
    geography = "zcta", 
    variables = socmob.var,
    year = .x, 
    survey = "acs5", 
    output = "wide"),
  .id = "year"
)

socmob.zip.2013 <- socmob.zip %>%
  filter(year == 2013) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_13"))) %>%
  rename(GEOID = GEOID_13,
         NAME = NAME_13) %>%
  select(-year)

socmob.zip.2018 <- socmob.zip %>%
  filter(year == 2018) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_18"))) %>%
  rename(GEOID = GEOID_18,
         NAME = NAME_18) %>%
  select(-year)

socmob.zip <- full_join(socmob.zip.2013, socmob.zip.2018)

socmob.zip <- socmob.zip %>%
  mutate(ADJ_med.inc_13 = med.incE_13*(251.233/233.049)) #Inflation rate 2018/2013

rm(socmob.zip.2013)
rm(socmob.zip.2018)

socmob.zip <- inner_join(zip, socmob.zip)

#tidycensus pull of place locations for 2013 and 2018 5-year acs places data
socmob.place <- map_dfr(
  years,
  ~get_acs(
    geography = "place", 
    state = "TX",
    variables = socmob.var,
    year = .x, 
    survey = "acs5", 
    output = "wide"),
  .id = "year"
)

socmob.place.2013 <- socmob.place %>%
  filter(year == 2013) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_13"))) %>%
  rename(GEOID = GEOID_13,
         NAME = NAME_13) %>%
  select(-year)

socmob.place.2018 <- socmob.place %>%
  filter(year == 2018) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_18"))) %>%
  rename(GEOID = GEOID_18,
         NAME = NAME_18) %>%
  select(-year)

socmob.place <- full_join(socmob.place.2013, socmob.place.2018)

socmob.place <- socmob.place %>%
  mutate(ADJ_med.inc_13 = med.incE_13*(251.233/233.049)) #Inflation rate 2018/2013

rm(socmob.place.2013)
rm(socmob.place.2018)

socmob.place <- inner_join(places, socmob.place)

#tidycensus pull of census tract locations for 2013 and 2018 5-year acs Johnson County data
socmob.tract <- map(
  years,
  ~get_acs(
    geography = "tract",
    state = "TX",
    county = "Johnson",
    variables = socmob.var,
    year = .x, 
    survey = "acs5", 
    output = "wide",
    geometry = TRUE),
  .id = "year"
)

socmob.tract.2013 <- socmob.tract %>%
  filter(year == 2013) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_13"))) %>%
  rename(GEOID = GEOID_13,
         NAME = NAME_13) %>%
  select(-year)

socmob.tract.2018 <- socmob.tract %>%
  filter(year == 2018) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_18"))) %>%
  rename(GEOID = GEOID_18,
         NAME = NAME_18) %>%
  select(-year)

socmob.tract <- full_join(socmob.tract.2013, socmob.tract.2018)

socmob.tract <- socmob.tract %>%
  mutate(ADJ_med.inc_13 = med.incE_13*(251.233/233.049)) #Inflation rate 2018/2013

rm(socmob.tract.2013)
rm(socmob.tract.2018)

#export of above locations into csv files
export(socmob.zip, "Living Wage Jobs/04_Projects/Social Mobility/Data/ACS/SocialMobility_Zip.csv")
export(socmob.place, "Living Wage Jobs/04_Projects/Social Mobility/Data/ACS/SocialMobility_Place.csv")
export(socmob.tract, "Living Wage Jobs/04_Projects/Social Mobility/Data/ACS/SocialMobility_Tract.csv")
