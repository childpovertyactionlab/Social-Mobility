rm(list=ls(all=TRUE))
#Owen(L) Directory: C:/Users/OwenWilson-Chavez/CPAL Dropbox
#Michael Directory: E:/CPAL Dropbox
setwd("E:/CPAL Dropbox")
library(tidyverse)
library(rio)
library(tigris)
library(sf)
library(lubridate)

#import geography comparison shape file
zip.sh <- st_read("C:/Users/Michael Lopez/Documents/GitHub/Social-Mobility/Data/Reference Geographies/Shapefiles/sm_zcta.shp")

#import feature shape files
snap.sh <- st_read("Data Library/USDA/GIS/SNAP_Store_Locations_TX_Dec2020.shp")
banks.sh <- st_read("Data Library/01_Data Update Projects/Dallas Features/Verification/Banks.shp") 
comcen.sh <- st_read("Data Library/NCTCOG/CommunityCenters.shp")
comhealth.sh <- st_read("Data Library/Miscellaneous/Community Health Clinics/CommunityHealthClincs_June2020.shp")
creditunions.sh <- st_read("Data Library/Google/GIS/Shapefiles/CreditUnions_Dec2020.shp") 
supermarket.sh <- st_read("Data Library/Miscellaneous/Grocery Stores/FoodandGrocery_DallasCounty_July2020.shp")
pharmacies.sh <-st_read("Data Library/Texas State Board of Pharmacy/GIS/TBSP_NTX_Dec2020.shp")
libraries.sh <- st_read("Data Library/City of Dallas/02_Boundaries and Features/Libraries.shp")
schools.sh <- st_read("Data Library/Texas Education Agency/GIS/Current_Schools_2020-2021.shp")
wic.sh <- st_read("Data Library/Google/GIS/Shapefiles/WIC_Locations_Dec2020.shp") 
childcare.sh <- st_read("Data Library/Texas Department of Family and Protective Services/SubsidyAccepting_ChildcareCenters_Feb2020.shp")

#edit shape files to only contain necessary columns
snap.join <- snap.sh %>%
  mutate(Display = "SNAP Retailer") %>%
  rename(Name = Store_Name) %>%
  select(Display, Name, Address, City, Longitude, Latitude, geometry)
rm(snap.sh)

banks.join <- banks.sh %>%
  st_transform(crs = 4326) %>%
  mutate(Display = "Bank") %>%
  rename(Longitude = X,
         Latitude = Y) %>%
  select(Display, Name, Address, City, Longitude, Latitude, geometry)
rm(banks.sh)

comcen.join <- comcen.sh %>%
  st_transform(crs = 4326) %>%
  mutate(Longitude = st_coordinates(.)[,1],
         Latitude = st_coordinates(.)[,2],
         Display = "Community Center") %>%
  select(Display, Name, Address, City, Longitude, Latitude, geometry)
rm(comcen.sh)

comhealth.join <- comhealth.sh %>%
  mutate(Display = "Community Health Clinic") %>%
  rename(Name = USER_Clini,
         Address = StAddr,
         Longitude = X,
         Latitude = Y) %>%
  select(Display, Name, Address, City, Longitude, Latitude, geometry)
rm(comhealth.sh)

creditunions.join <- creditunions.sh %>%
  mutate(Longitude = st_coordinates(.)[,1],
         Latitude = st_coordinates(.)[,2],
         Display = "Credit Union",
         City = word(plcs_dd,-1)) %>%
  rename(Name = plcs_nm,
         Address = plcs_dd) %>%
  select(Display, Name, Address, City, Longitude, Latitude, geometry)
st_crs(creditunions.join) = 4326
rm(creditunions.sh)

supermarket.join <- supermarket.sh %>%
  mutate(Display = "Supermarket") %>%
  rename(Name = BusinessNa,
         Address = Bus_Addres) %>%
  select(Display, Name, Address, City, Longitude, Latitude, geometry)
rm(supermarket.sh)

pharmacies.join <- pharmacies.sh %>%
  mutate(Display = "Pharmacy") %>%
  rename(Address = StAddr,
         Longitude = X,
         Latitude = Y,
         Name = USER_phy_n) %>%
  select(Display, Name, Address, City, Longitude, Latitude, geometry)
rm(pharmacies.sh)

libraries.join <- libraries.sh %>%
  mutate(Display = "Library",
         City = "NA") %>%
  rename(Name = LIBRARY,
         Address = ADDRESS,
         Longitude = X,
         Latitude = Y) %>%
  select(Display, Name, Address, City, Longitude, Latitude, geometry)
rm(libraries.sh)

schools.join <- schools.sh %>%
  rename(Address = StAddr,
         Name = School_Nam,
         Longitude = X,
         Latitude = Y,
         District_Type = District_T,
         Grade_Level = Grade_Leve
         ) %>%
  mutate(Display = ifelse(District_Type == "INDEPENDENT" & Grade_Level == "High School", "Independent High School",
                       ifelse(District_Type == "INDEPENDENT" & Grade_Level == "Middle", "Independent Middle School",
                              ifelse(District_Type == "INDEPENDENT" & Grade_Level == "Elementary", "Independent Elementary School",
                                     ifelse(District_Type == "INDEPENDENT" & Grade_Level == "Elementary/Secondary", "Independent Elementary/Secondary School",
                                            ifelse(District_Type == "INDEPENDENT" & Grade_Level == "Junior High", "Independent Junior High School",
                                                   ifelse(District_Type == "CHARTER" & Grade_Level == "High School", "Charter High School",
                                                          ifelse(District_Type == "CHARTER" & Grade_Level == "Middle", "Charter Middle School",
                                                                 ifelse(District_Type == "CHARTER" & Grade_Level == "Elementary", "Charter Elementary School",
                                                                        ifelse(District_Type == "CHARTER" & Grade_Level == "Elementary/Secondary", "Charter Elementary/Secondary School",
                                                                               ifelse(District_Type == "CHARTER" & Grade_Level == "Junior High", "Charter Junior High School",
                                                                                      "Other School"))))))))))) %>%
  select(Display, Name, Address, City, Longitude, Latitude, geometry)
rm(schools.sh)

wic.join <- wic.sh %>%
  mutate(Longitude = st_coordinates(.)[,1],
         Latitude = st_coordinates(.)[,2],
         Display = "WIC Clinic",
         City = word(plcs_dd,-1)) %>%
  rename(Name = plcs_nm,
         Address = plcs_dd) %>%
  select(Display, Name, Address, City, Longitude, Latitude, geometry)
st_crs(wic.join) = 4326
rm(wic.sh)

childcare.join <- childcare.sh %>%
  mutate(Display = "Subsidized Childcare Center",
         City = word(Address,-4)) %>%
  rename(Longitude = X,
         Latitude = Y) %>%
  select(Display, Name, Address, City, Longitude, Latitude, geometry)
rm(childcare.sh)

#select points within geography of interest
snap.zip <- snap.join[zip.sh, ]
banks.zip <- banks.join[zip.sh, ]
comcen.zip <- comcen.join[zip.sh, ]
comhealth.zip <- comhealth.join[zip.sh, ]
creditunions.zip <- creditunions.join[zip.sh, ]
supermarket.zip <- supermarket.join[zip.sh, ]
pharmacies.zip <- pharmacies.join[zip.sh, ]
libraries.zip <- libraries.join[zip.sh, ]
schools.zip <- schools.join[zip.sh, ]
wic.zip <- wic.join[zip.sh, ]
childcare.zip <- childcare.join[zip.sh, ]

#join all files into one
featureset <- rbind(rbind(rbind(rbind(rbind(rbind(rbind(rbind(rbind(rbind(
                    snap.zip, banks.zip), comcen.zip), comhealth.zip), creditunions.zip), supermarket.zip), pharmacies.zip), libraries.zip), schools.zip), wic.zip), childcare.zip)

#adding new features to shapefile
featureset_mut <- featureset %>%
  mutate(variable = ifelse(Display == "SNAP Retailer", "snap", 
                           ifelse(Display == "Bank", "bank",
                                  ifelse(Display == "Community Center", "comcen",
                                         ifelse(Display == "Community Health Clinic", "comhel",
                                                ifelse(Display == "Credit Union", "crunion",
                                                       ifelse(Display == "Supermarket", "market",
                                                              ifelse(Display == "Pharmacy", "pharm",
                                                                     ifelse(Display == "Library", "lib",
                                                                            ifelse(Display == "Independent High School", "ihs",
                                                                                   ifelse(Display == "Independent Middle School", "ims",
                                                                                          ifelse(Display == "Independent Elementary School", "ies",
                                                                                                 ifelse(Display == "Independent Elementary/Secondary School", "iss",
                                                                                                        ifelse(Display == "Independent Junior High School", "ijhs",
                                                                                                               ifelse(Display == "Charter High School", "chs",
                                                                                                                      ifelse(Display == "Charter Middle School", "cms",
                                                                                                                             ifelse(Display == "Charter Elementary School", "ces",
                                                                                                                                    ifelse(Display == "Charter Elementary/Secondary School", "cesc",
                                                                                                                                           ifelse(Display == "Charter Junior High School", "cjhs",
                                                                                                                                                  ifelse(Display == "Other School", "os",
                                                                                                                                                         ifelse(Display == "WIC Clinic", "wic",
                                                                                                                                                                ifelse(Display == "Subsidized Childcare Center", "scc",
                                                                                                                                                                       "ERROR"
                                                                                                                                                                ))))))))))))))))))))))

#export to geojson
geojsonio::geojson_write(featureset_mut, file = "C:/Users/Michael Lopez/Documents/GitHub/Social-Mobility/Data/geojson/sm_featureset.geojson")
