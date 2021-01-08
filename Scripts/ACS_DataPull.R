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
  tot_pop = "B01003_001", 
  med_inc = "B19013_001",
  gini = "B19083_001",
  less_hs = "B06009_002",
  hs_deg = "B06009_003",
  some_col = "B06009_004",
  ba_deg = "B06009_005",
  grad_deg = "B06009_006",
  tot_deg = "B06009_001",
  his_pop = "B03002_012", #hispanic
  wh_pop = "B03002_003", #white
  bl_pop = "B03002_004", #black
  ai_pop = "B02001_005", #american indian
  as_pop = "B03002_006" #asian
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
  mutate(wh_per_18 = wh_popE_18/tot_popE_18,
         bl_per_18 = bl_popE_18/tot_popE_18,
         ai_per_18 = ai_popE_18/tot_popE_18,
         as_per_18 = as_popE_18/tot_popE_18,
         his_per_18 = his_popE_18/tot_popE_18,
         wh_per_13 = wh_popE_13/tot_popE_13,
         bl_per_13 = bl_popE_13/tot_popE_13,
         ai_per_13 = ai_popE_13/tot_popE_13,
         as_per_13 = as_popE_13/tot_popE_13,
         his_per_13 = his_popE_13/tot_popE_13,
         adj_med_inc_13 = med_incE_13*(251.233/233.049),                    #Inflation rate 2018/2013
         per_tot_pop = ((tot_popE_18 - tot_popE_13)/tot_popE_13),
         per_med_inc = ((med_incE_18 - adj_med_inc_13)/adj_med_inc_13),
         per_gini = ((giniE_18 - giniE_13)/giniE_13),
         per_less_hs = (less_hsE_18/tot_degE_18) - (less_hsE_13/tot_degE_13),
         per_hs_deg = (hs_degE_18/tot_degE_18) - (hs_degE_13/tot_degE_13),
         per_some_col = (some_colE_18/tot_degE_18) - (some_colE_13/tot_degE_13),
         per_ba_deg = (ba_degE_18/tot_degE_18) - (ba_degE_13/tot_degE_13),
         per_grad_deg = (grad_degE_18/tot_degE_18) - (grad_degE_13/tot_degE_13),
         per_wh = (wh_popE_18/tot_popE_18) - (wh_popE_13/tot_popE_13),
         per_bl = (bl_popE_18/tot_popE_18) - (bl_popE_13/tot_popE_13),
         per_as = (as_popE_18/tot_popE_18) - (as_popE_13/tot_popE_13),
         per_ai = (ai_popE_18/tot_popE_18) - (ai_popE_13/tot_popE_13),
         per_his = (his_popE_18/tot_popE_18) - (his_popE_13/tot_popE_13))

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
  select(GEOID:as_popE_18, -(TYPE)) %>%
  mutate(tot_popE_13 = log(tot_popE_13),
         med_incE_13 = log(med_incE_13),
         giniE_13 = log(giniE_13),
         less_hsE_13 = log(less_hsE_13),
         hs_degE_13 = log(hs_degE_13),
         some_colE_13 = log(some_colE_13),
         ba_degE_13 = log(ba_degE_13),
         grad_degE_13 = log(grad_degE_13),
         tot_degE_13 = log(tot_degE_13),
         wh_popE_13 = log(wh_popE_13),
         bl_popE_13 = log(bl_popE_13),
         as_popE_13 = log(as_popE_13),
         ai_popE_13 = log(ai_popE_13),
         his_popE_13 = log(his_popE_13),
         tot_popE_18 = log(tot_popE_18),
         med_incE_18 = log(med_incE_18),
         giniE_18 = log(giniE_18),
         less_hsE_18 = log(less_hsE_18),
         hs_degE_18 = log(hs_degE_18),
         some_colE_18 = log(some_colE_18),
         ba_degE_18 = log(ba_degE_18),
         grad_degE_18 = log(grad_degE_18),
         tot_degE_18 = log(tot_degE_18),
         wh_popE_18 = log(wh_popE_18),
         bl_popE_18 = log(bl_popE_18),
         as_popE_18 = log(as_popE_18),
         ai_popE_18 = log(ai_popE_18),
         his_popE_18 = log(his_popE_18)) %>%
  drop_na() %>%
  mutate_all(function(x) ifelse(is.infinite(x), 0, x)) %>%
  mutate_at(c(3:30), funs(c(sdcut(.)))) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_sd"))) %>%
  rename(NAME = NAME_sd)

socmob.zip.upload <- left_join(socmob.zip.sd, socmob.zip)

socmob.place.sd <- socmob.place %>%
  select(-(ends_with("M_13")), -(ends_with("M_18"))) %>%
  select(GEOID:as_popE_18, -(TYPE)) %>%
  mutate(tot_popE_13 = log(tot_popE_13),
         med_incE_13 = log(med_incE_13),
         giniE_13 = log(giniE_13),
         less_hsE_13 = log(less_hsE_13),
         hs_degE_13 = log(hs_degE_13),
         some_colE_13 = log(some_colE_13),
         ba_degE_13 = log(ba_degE_13),
         grad_degE_13 = log(grad_degE_13),
         tot_degE_13 = log(tot_degE_13),
         wh_popE_13 = log(wh_popE_13),
         bl_popE_13 = log(bl_popE_13),
         as_popE_13 = log(as_popE_13),
         ai_popE_13 = log(ai_popE_13),
         his_popE_13 = log(his_popE_13),
         tot_popE_18 = log(tot_popE_18),
         med_incE_18 = log(med_incE_18),
         giniE_18 = log(giniE_18),
         less_hsE_18 = log(less_hsE_18),
         hs_degE_18 = log(hs_degE_18),
         some_colE_18 = log(some_colE_18),
         ba_degE_18 = log(ba_degE_18),
         grad_degE_18 = log(grad_degE_18),
         tot_degE_18 = log(tot_degE_18),
         wh_popE_18 = log(wh_popE_18),
         bl_popE_18 = log(bl_popE_18),
         as_popE_18 = log(as_popE_18),
         ai_popE_18 = log(ai_popE_18),
         his_popE_18 = log(his_popE_18)) %>%
  drop_na() %>%
  mutate_all(function(x) ifelse(is.infinite(x), 0, x)) %>%
  mutate_at(c(3:30), funs(c(sdcut(.)))) %>%
  setNames(c(names(.)[1], paste0(names(.)[-1],"_sd"))) %>%
  rename(NAME = NAME_sd)

socmob.place.upload <- left_join(socmob.place.sd, socmob.place)

socmob.tract.sd <- socmob.tract %>%
  select(-(ends_with("M_13")), -(ends_with("M_18"))) %>%
  select(GEOID:as_popE_18, -(TYPE)) %>%
  mutate(tot_popE_13 = log(tot_popE_13),
         med_incE_13 = log(med_incE_13),
         giniE_13 = log(giniE_13),
         less_hsE_13 = log(less_hsE_13),
         hs_degE_13 = log(hs_degE_13),
         some_colE_13 = log(some_colE_13),
         ba_degE_13 = log(ba_degE_13),
         grad_degE_13 = log(grad_degE_13),
         tot_degE_13 = log(tot_degE_13),
         wh_popE_13 = log(wh_popE_13),
         bl_popE_13 = log(bl_popE_13),
         as_popE_13 = log(as_popE_13),
         ai_popE_13 = log(ai_popE_13),
         his_popE_13 = log(his_popE_13),
         tot_popE_18 = log(tot_popE_18),
         med_incE_18 = log(med_incE_18),
         giniE_18 = log(giniE_18),
         less_hsE_18 = log(less_hsE_18),
         hs_degE_18 = log(hs_degE_18),
         some_colE_18 = log(some_colE_18),
         ba_degE_18 = log(ba_degE_18),
         grad_degE_18 = log(grad_degE_18),
         tot_degE_18 = log(tot_degE_18),
         wh_popE_18 = log(wh_popE_18),
         bl_popE_18 = log(bl_popE_18),
         as_popE_18 = log(as_popE_18),
         ai_popE_18 = log(ai_popE_18),
         his_popE_18 = log(his_popE_18)) %>%
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

#descriptive stats for each dataframe
var <-  c("nbr.val", "nbr.null", "nbr.na", "min", "max", "range", "sum", "median", "mean", "SE.mean", "CI.mean.0.95", "var", "std.dev", "coef.var")
socmob.calc.d <- cbind(var, pastecs::stat.desc(socmob.calc))

#export of above locations into csv files
export(socmob.calc.d, "Social-Mobility/Data/ACS/SocialMobility_DescriptiveStats.csv")
export(socmob.zip.upload, "Social-Mobility/Data/ACS/SocialMobility_Zip.csv")
export(socmob.place.upload, "Social-Mobility/Data/ACS/SocialMobility_Place.csv")
export(socmob.tract.upload, "Social-Mobility/Data/ACS/SocialMobility_Tract.csv")
