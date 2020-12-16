rm(list=ls(all=TRUE))
#Owen(L) Directory: C:/Users/OwenWilson-Chavez/CPAL Dropbox
#Michael Directory: C:/Users/Michael Lopez/Documents/GitHub
setwd("C:/Users/Michael Lopez/Documents/GitHub")
library(tidyverse)
library(rio)
library(sf)

#import csv files of data
socmob.zip.csv <- import("Social-Mobility/Data/ACS/SocialMobility_Zip.csv")
socmob.place.csv <- import("Social-Mobility/Data/ACS/SocialMobility_Place.csv")
socmob.tract.csv <- import("Social-Mobility/Data/ACS/SocialMobility_Tract.csv")

#import shape files
zip.shape <- st_read("Social-Mobility/Data/Reference Geographies/Shapefiles/sm_zcta.shp")
place.shape <- st_read("Social-Mobility/Data/Reference Geographies/Shapefiles/sm_places.shp")
tract.shape <- st_read("Social-Mobility/Data/Reference Geographies/Shapefiles/sm_tracts.shp")
counties.shape <- st_read("Social-Mobility/Data/Reference Geographies/Shapefiles/sm_counties.shp")

#convert shape GEOID columns from factor to numeric to help merge
zip.shape <- zip.shape %>%
  mutate(GEOID2 = as.numeric(GEOID10))

place.shape <- place.shape %>%
  mutate(GEOID2 = as.numeric(GEOID))

tract.shape <- tract.shape %>%
  mutate(GEOID2 = as.numeric(GEOID))

counties.shape <- counties.shape %>%
  mutate(GEOID2 = as.numeric(GEOID))

socmob.zip.csv <- socmob.zip.csv %>%
  mutate(GEOID2 = as.numeric(GEOID))

socmob.place.csv <- socmob.place.csv %>%
  mutate(GEOID2 = as.numeric(GEOID))

socmob.tract.csv <- socmob.tract.csv %>%
  mutate(GEOID2 = as.numeric(GEOID))

#socmob.counties.csv <- socmob.counties.csv %>%
#  mutate(GEOID2 = as.integer(GEOID))


#merge csv and shape files into shape file
zip.merge <- left_join(zip.shape, socmob.zip.csv, by = "GEOID2")

place.merge <- left_join(place.shape, socmob.place.csv, by = "GEOID2")

tract.merge <- left_join(tract.shape, socmob.tract.csv, by = "GEOID2")

#counties.merge <- left_join(counties.shape, socmob.counties.csv, by = "GEOID2")
st_write(zip.merge, "Social-Mobility/Data/geojson/sm_zcta.geojson")#, layer_options = 'OVERWRITE=YES', append = TRUE)
st_write(place.merge, "Social-Mobility/Data/geojson/sm_places.geojson")#, layer_options = 'OVERWRITE=YES', append = TRUE)
st_write(tract.merge, "Social-Mobility/Data/geojson/sm_tracts.geojson")#, layer_options = 'OVERWRITE=YES', append = TRUE)
