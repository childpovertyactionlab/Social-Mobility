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
counties <- c("dallas", "rockwall", "collin county", "denton", "tarrant", "kaufman", "ellis", "johnson")

#setting up the geocodes for the areas of interest to be pulled from tidycensus
zip <- import("Social-Mobility/Data/Reference Geographies/socmob_zcta.csv")
places <- import("Social-Mobility/Data/Reference Geographies/socmob_place.csv")

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
  tot.deg = "B06009_001",
  his.pop = "B03003_003",
  wh.pop = "B02001_002",
  bl.pop = "B02001_003",
  ai.pop = "B02001_004",
  as.pop = "B02001_005"
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

#tidycensus pull of census tract locations for 2013 and 2018 5-year acs Counties data
socmob.tract.2013 <- get_acs(geography = "tract", variables = socmob.var,
                             state = "TX", county = counties, year = 2013, survey = "acs5", output = "wide")
  
socmob.tract.2018 <- get_acs(geography = "tract", variables = socmob.var,
                             state = "TX", county = counties, year = 2018, survey = "acs5", output = "wide")

socmob.tract.2013 <- socmob.tract.2013 %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_13"))) %>%
  rename(NAME = NAME_13) %>%
  mutate(TYPE = "TRACT")

socmob.tract.2018 <- socmob.tract.2018 %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_18"))) %>%
  rename(NAME = NAME_18) %>%
  mutate(TYPE = "TRACT")

socmob.tract <- full_join(socmob.tract.2013, socmob.tract.2018)

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
         per.grad.deg = (grad.degE_18/tot.degE_18) - (grad.degE_13/tot.degE_13),
         per.wh = (wh.popE_18/tot.popE_18) - (wh.popE_13/tot.popE_13),
         per.bl = (bl.popE_18/tot.popE_18) - (bl.popE_13/tot.popE_13),
         per.as = (as.popE_18/tot.popE_18) - (as.popE_13/tot.popE_13),
         per.ai = (ai.popE_18/tot.popE_18) - (ai.popE_13/tot.popE_13),
         per.his = (his.popE_18/tot.popE_18) - (his.popE_13/tot.popE_13))

socmob.zip <- socmob.calc %>%
  filter(str_detect(TYPE, "ZIP"))

socmob.place <- socmob.calc %>%
  filter(str_detect(TYPE, "PLACE"))

socmob.tract <- socmob.calc %>%
  filter(str_detect(TYPE, "TRACT"))

#sdcut function which will divide dataset into 5 bins based on where in the standard deviation the value falls
sdcut <- function(x) {
  sd1p <- mean(x)+(sd(x)*0.50)
  sd1n <- mean(x)-(sd(x)*0.50)
  sd2p <- mean(x)+(sd(x)*1)
  sd2n <- mean(x)-(sd(x)*1)
  ifelse(x > sd2p, 4,
         ifelse(x > sd1p & x < sd2p, 3,
                ifelse(x > sd1n & x < sd1p, 2,
                       ifelse(x > sd2n & x < sd1n, 1, 0))))
}

#standardize all variables to z scores using the scale function
#second line of function omits the "SLN", "TEA", and "AreaSqMi" columns from being transformed with the 'scale' function
names(socmob.zip)

socmob.zip.sd <- socmob.zip %>%
  select(-(ends_with("M_13")), -(ends_with("M_18"))) %>%
  select(GEOID:as.popE_18, -(TYPE)) %>%
  mutate(tot.popE_13 = log(tot.popE_13),
         med.incE_13 = log(med.incE_13),
         giniE_13 = log(giniE_13),
         less.hsE_13 = log(less.hsE_13),
         hs.degE_13 = log(hs.degE_13),
         some.colE_13 = log(some.colE_13),
         ba.degE_13 = log(ba.degE_13),
         grad.degE_13 = log(grad.degE_13),
         tot.degE_13 = log(tot.degE_13),
         wh.popE_13 = log(wh.popE_13),
         bl.popE_13 = log(bl.popE_13),
         as.popE_13 = log(as.popE_13),
         ai.popE_13 = log(ai.popE_13),
         his.popE_13 = log(his.popE_13),
         tot.popE_18 = log(tot.popE_18),
         med.incE_18 = log(med.incE_18),
         giniE_18 = log(giniE_18),
         less.hsE_18 = log(less.hsE_18),
         hs.degE_18 = log(hs.degE_18),
         some.colE_18 = log(some.colE_18),
         ba.degE_18 = log(ba.degE_18),
         grad.degE_18 = log(grad.degE_18),
         tot.degE_18 = log(tot.degE_18),
         wh.popE_18 = log(wh.popE_18),
         bl.popE_18 = log(bl.popE_18),
         as.popE_18 = log(as.popE_18),
         ai.popE_18 = log(ai.popE_18),
         his.popE_18 = log(his.popE_18)) %>%
  drop_na() %>%
  mutate_all(function(x) ifelse(is.infinite(x), 0, x)) %>%
  mutate_at(c(3:30), funs(c(sdcut(.)))) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_sd"))) %>%
  rename(NAME = NAME_sd)

socmob.zip.upload <- left_join(socmob.zip.sd, socmob.zip)

socmob.place.sd <- socmob.place %>%
  select(-(ends_with("M_13")), -(ends_with("M_18"))) %>%
  select(GEOID:as.popE_18, -(TYPE)) %>%
  mutate(tot.popE_13 = log(tot.popE_13),
         med.incE_13 = log(med.incE_13),
         giniE_13 = log(giniE_13),
         less.hsE_13 = log(less.hsE_13),
         hs.degE_13 = log(hs.degE_13),
         some.colE_13 = log(some.colE_13),
         ba.degE_13 = log(ba.degE_13),
         grad.degE_13 = log(grad.degE_13),
         tot.degE_13 = log(tot.degE_13),
         wh.popE_13 = log(wh.popE_13),
         bl.popE_13 = log(bl.popE_13),
         as.popE_13 = log(as.popE_13),
         ai.popE_13 = log(ai.popE_13),
         his.popE_13 = log(his.popE_13),
         tot.popE_18 = log(tot.popE_18),
         med.incE_18 = log(med.incE_18),
         giniE_18 = log(giniE_18),
         less.hsE_18 = log(less.hsE_18),
         hs.degE_18 = log(hs.degE_18),
         some.colE_18 = log(some.colE_18),
         ba.degE_18 = log(ba.degE_18),
         grad.degE_18 = log(grad.degE_18),
         tot.degE_18 = log(tot.degE_18),
         wh.popE_18 = log(wh.popE_18),
         bl.popE_18 = log(bl.popE_18),
         as.popE_18 = log(as.popE_18),
         ai.popE_18 = log(ai.popE_18),
         his.popE_18 = log(his.popE_18)) %>%
  drop_na() %>%
  mutate_all(function(x) ifelse(is.infinite(x), 0, x)) %>%
  mutate_at(c(3:30), funs(c(sdcut(.)))) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_sd"))) %>%
  rename(NAME = NAME_sd)

socmob.place.upload <- left_join(socmob.place.sd, socmob.place)

socmob.tract.sd <- socmob.tract %>%
  select(-(ends_with("M_13")), -(ends_with("M_18"))) %>%
  select(GEOID:as.popE_18, -(TYPE)) %>%
  mutate(tot.popE_13 = log(tot.popE_13),
         med.incE_13 = log(med.incE_13),
         giniE_13 = log(giniE_13),
         less.hsE_13 = log(less.hsE_13),
         hs.degE_13 = log(hs.degE_13),
         some.colE_13 = log(some.colE_13),
         ba.degE_13 = log(ba.degE_13),
         grad.degE_13 = log(grad.degE_13),
         tot.degE_13 = log(tot.degE_13),
         wh.popE_13 = log(wh.popE_13),
         bl.popE_13 = log(bl.popE_13),
         as.popE_13 = log(as.popE_13),
         ai.popE_13 = log(ai.popE_13),
         his.popE_13 = log(his.popE_13),
         tot.popE_18 = log(tot.popE_18),
         med.incE_18 = log(med.incE_18),
         giniE_18 = log(giniE_18),
         less.hsE_18 = log(less.hsE_18),
         hs.degE_18 = log(hs.degE_18),
         some.colE_18 = log(some.colE_18),
         ba.degE_18 = log(ba.degE_18),
         grad.degE_18 = log(grad.degE_18),
         tot.degE_18 = log(tot.degE_18),
         wh.popE_18 = log(wh.popE_18),
         bl.popE_18 = log(bl.popE_18),
         as.popE_18 = log(as.popE_18),
         ai.popE_18 = log(ai.popE_18),
         his.popE_18 = log(his.popE_18)) %>%
  drop_na() %>%
  mutate_all(function(x) ifelse(is.infinite(x), 0, x)) %>%
  mutate_at(c(3:30), funs(c(sdcut(.)))) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_sd"))) %>%
  rename(NAME = NAME_sd)

socmob.tract.upload <- left_join(socmob.tract.sd, socmob.tract)

socmob.zip.table <- print(sapply(socmob.zip.sd, table))
socmob.place.table <- print(sapply(socmob.place.sd, table))
socmob.tract.table <- print(sapply(socmob.tract.sd, table))

rm(socmob.zip.sd)
rm(socmob.place.sd)
rm(socmob.tract.sd)

#export of above locations into csv files
export(socmob.zip.upload, "Social-Mobility/Data/ACS/SocialMobility_Zip.csv")
export(socmob.place.upload, "Social-Mobility/Data/ACS/SocialMobility_Place.csv")
export(socmob.tract.upload, "Social-Mobility/Data/ACS/SocialMobility_Tract.csv")
