rm(list=ls(all=TRUE))
#Owen(L) Directory: C:/Users/OwenWilson-Chavez/CPAL Dropbox
#Michael Directory: C:/Users/Michael Lopez/Documents/GitHub
setwd("C:/Users/Michael Lopez/Documents/GitHub")
library(tidycensus)
library(tidyverse)
library(rio)
library(tigris)

acs18 <- load_variables(2018, "acs5", cache = TRUE)
#view(acs18)
#data(fips_codes)
years <- lst(2013, 2018)
counties <- c("dallas", "rockwall", "collin county", "denton", "tarrant", "kaufman", "ellis")

#setting up the geocodes for the areas of interest to be pulled from tidycensus
zip <- import("Social-Mobility/Data/Geography/socmob_zcta.csv")
places <- import("Social-Mobility/Data/Geography/socmob_place.csv")

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
  select(-year) %>%
  mutate(TYPE = "ZIP")

socmob.zip.2018 <- socmob.zip %>%
  filter(year == 2018) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_18"))) %>%
  rename(GEOID = GEOID_18,
         NAME = NAME_18) %>%
  select(-year) %>%
  mutate(TYPE = "ZIP")

socmob.zip <- full_join(socmob.zip.2013, socmob.zip.2018)

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
  select(-year) %>%
  mutate(TYPE = "PLACE")

socmob.place.2018 <- socmob.place %>%
  filter(year == 2018) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_18"))) %>%
  rename(GEOID = GEOID_18,
         NAME = NAME_18) %>%
  select(-year) %>%
  mutate(TYPE = "PLACE")

socmob.place <- full_join(socmob.place.2013, socmob.place.2018)

rm(socmob.place.2013)
rm(socmob.place.2018)

socmob.place <- inner_join(places, socmob.place)

#tidycensus pull of census tract locations for 2013 and 2018 5-year acs Johnson County data
socmob.tract <- map_dfr(
  years,
  ~get_acs(
    geography = "tract", 
    state = "TX",
    county = "Johnson",
    variables = socmob.var,
    year = .x, 
    survey = "acs5", 
    output = "wide"),
  .id = "year"
)

socmob.tract.2013 <- socmob.tract %>%
  filter(year == 2013) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_13"))) %>%
  rename(GEOID = GEOID_13,
         NAME = NAME_13) %>%
  select(-year) %>%
  mutate(TYPE = "TRACT")

socmob.tract.2018 <- socmob.tract %>%
  filter(year == 2018) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_18"))) %>%
  rename(GEOID = GEOID_18,
         NAME = NAME_18) %>%
  select(-year) %>%
  mutate(TYPE = "TRACT")

socmob.tract <- full_join(socmob.tract.2013, socmob.tract.2018)

socmob.tract <- socmob.tract %>%
  mutate(ADJ_med.inc_13 = med.incE_13*(251.233/233.049)) #Inflation rate 2018/2013

rm(socmob.tract.2013)
rm(socmob.tract.2018)

#merge all acs geographies into one file in order to calculate variables
socmob.combine <- full_join(full_join(socmob.zip, socmob.place), socmob.tract)

#begin calculating percent changes between 2013 and 2018 data
names(socmob.combine)

socmob.calc <- socmob.combine %>%
  mutate(ADJ_med.inc_13 = med.incE_13*(251.233/233.049),                    #Inflation rate 2018/2013
         per.tot.pop = ((tot.popE_18 - tot.popE_13)/tot.popE_13),
         per.med.inc = ((med.incE_18 - ADJ_med.inc_13)/ADJ_med.inc_13),
         per.gini = ((giniE_18 - giniE_13)/giniE_13),
         per.less.hs = (less.hsE_18/tot.degE_18) - (less.hsE_13/tot.degE_13),
         per.hs.deg = (hs.degE_18/tot.degE_18) - (hs.degE_13/tot.degE_13),
         per.some.col = (some.colE_18/tot.degE_18) - (some.colE_13/tot.degE_13),
         per.ba.deg = (ba.degE_18/tot.degE_18) - (ba.degE_13/tot.degE_13),
         per.grad.deg = (grad.degE_18/tot.degE_18) - (grad.degE_13/tot.degE_13))

socmob.zip <- socmob.calc %>%
  filter(str_detect(TYPE, "ZIP"))

socmob.place <- socmob.calc %>%
  filter(str_detect(TYPE, "PLACE"))

socmob.tract <- socmob.calc %>%
  filter(str_detect(TYPE, "TRACT"))

#export of above locations into csv files
export(socmob.zip, "Social-Mobility/Data/ACS/SocialMobility_Zip.csv")
export(socmob.place, "Social-Mobility/Data/ACS/SocialMobility_Place.csv")
export(socmob.tract, "Social-Mobility/Data/ACS/SocialMobility_Tract.csv")
