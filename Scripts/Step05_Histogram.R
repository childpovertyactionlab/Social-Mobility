setwd("C:/Users/Michael Lopez/Documents/GitHub")

library(tidyverse)
library(sf)

socmob.zip <- st_read("Social-Mobility/Data/geojson/sm_zcta.geojson")
socmob.place <- st_read("Social-Mobility/Data/geojson/sm_places.geojson")
socmob.tracts <- st_read("Social-Mobility/Data/geojson/sm_tracts.geojson")
socmob.county <- st_read("Social-Mobility/Data/geojson/sm_counties.geojson")

names(socmob.zip)
##########################################################################################
##########################################################################################
socmob.zip %>%
  mutate(per_rohh = as.double(per_rohh)) %>%
  ggplot(aes(x = per_rohh)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_ROHH_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')

socmob.zip %>%
  mutate(per_tot_pop = as.double(per_tot_pop)) %>%
  ggplot(aes(x = per_tot_pop)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Tot_Pop_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')

socmob.zip %>%
  mutate(per_med_inc = as.double(per_med_inc)) %>%
  ggplot(aes(x = per_med_inc)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Med_Inc_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.zip %>%
  mutate(per_gini = as.double(per_gini)) %>%
  ggplot(aes(x = per_gini)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Gini_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.zip %>%
  mutate(per_less_hs = as.double(per_less_hs)) %>%
  ggplot(aes(x = per_less_hs)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Less_HS_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.zip %>%
  mutate(per_hs_deg = as.double(per_hs_deg)) %>%
  ggplot(aes(x = per_hs_deg)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_HS_deg_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.zip %>%
  mutate(per_wh = as.double(per_wh)) %>%
  ggplot(aes(x = per_wh)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Wh_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.zip %>%
  mutate(per_bl = as.double(per_bl)) %>%
  ggplot(aes(x = per_bl)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Bl_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.zip %>%
  mutate(per_as = as.double(per_as)) %>%
  ggplot(aes(x = per_as)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_As_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.zip %>%
  mutate(per_his = as.double(per_his)) %>%
  ggplot(aes(x = per_his)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_His_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.zip %>%
  mutate(per_hs_18t24 = as.double(per_hs_18t24)) %>%
  ggplot(aes(x = per_hs_18t24)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_HS_18t24_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.zip %>%
  mutate(per_es_3t4 = as.double(per_es_3t4)) %>%
  ggplot(aes(x = per_es_3t4)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_es_3t4_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.zip %>%
  mutate(per_emp_pubtr = as.double(per_emp_pubtr)) %>%
  ggplot(aes(x = per_emp_pubtr)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_emp_pubtr_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.zip %>%
  mutate(per_bp = as.double(per_bp)) %>%
  ggplot(aes(x = per_bp)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_bp_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.zip %>%
  mutate(per_cbp = as.double(per_cbp)) %>%
  ggplot(aes(x = per_cbp)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_cbp_ZCTA.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')

##########################################################################################
##########################################################################################
socmob.tracts %>%
  mutate(per_rohh = as.double(per_rohh)) %>%
  ggplot(aes(x = per_rohh)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_ROHH_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')

socmob.tracts %>%
  mutate(per_tot_pop = as.double(per_tot_pop)) %>%
  ggplot(aes(x = per_tot_pop)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Tot_Pop_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')

socmob.tracts %>%
  mutate(per_med_inc = as.double(per_med_inc)) %>%
  ggplot(aes(x = per_med_inc)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Med_Inc_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.tracts %>%
  mutate(per_gini = as.double(per_gini)) %>%
  ggplot(aes(x = per_gini)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Gini_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.tracts %>%
  mutate(per_less_hs = as.double(per_less_hs)) %>%
  ggplot(aes(x = per_less_hs)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Less_HS_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.tracts %>%
  mutate(per_hs_deg = as.double(per_hs_deg)) %>%
  ggplot(aes(x = per_hs_deg)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_HS_deg_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.tracts %>%
  mutate(per_wh = as.double(per_wh)) %>%
  ggplot(aes(x = per_wh)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Wh_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.tracts %>%
  mutate(per_bl = as.double(per_bl)) %>%
  ggplot(aes(x = per_bl)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Bl_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.tracts %>%
  mutate(per_as = as.double(per_as)) %>%
  ggplot(aes(x = per_as)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_As_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.tracts %>%
  mutate(per_his = as.double(per_his)) %>%
  ggplot(aes(x = per_his)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_His_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.tracts %>%
  mutate(per_hs_18t24 = as.double(per_hs_18t24)) %>%
  ggplot(aes(x = per_hs_18t24)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_HS_18t24_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.tracts %>%
  mutate(per_es_3t4 = as.double(per_es_3t4)) %>%
  ggplot(aes(x = per_es_3t4)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_es_3t4_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.tracts %>%
  mutate(per_emp_pubtr = as.double(per_emp_pubtr)) %>%
  ggplot(aes(x = per_emp_pubtr)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_emp_pubtr_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.tracts %>%
  mutate(per_bp = as.double(per_bp)) %>%
  ggplot(aes(x = per_bp)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_bp_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.tracts %>%
  mutate(per_cbp = as.double(per_cbp)) %>%
  ggplot(aes(x = per_cbp)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_cbp_Tract.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


##########################################################################################
##########################################################################################
socmob.place %>%
  mutate(per_rohh = as.double(per_rohh)) %>%
  ggplot(aes(x = per_rohh)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_ROHH_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')

socmob.place %>%
  mutate(per_tot_pop = as.double(per_tot_pop)) %>%
  ggplot(aes(x = per_tot_pop)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Tot_Pop_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')

socmob.place %>%
  mutate(per_med_inc = as.double(per_med_inc)) %>%
  ggplot(aes(x = per_med_inc)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Med_Inc_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.place %>%
  mutate(per_gini = as.double(per_gini)) %>%
  ggplot(aes(x = per_gini)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Gini_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.place %>%
  mutate(per_less_hs = as.double(per_less_hs)) %>%
  ggplot(aes(x = per_less_hs)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Less_HS_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.place %>%
  mutate(per_hs_deg = as.double(per_hs_deg)) %>%
  ggplot(aes(x = per_hs_deg)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_HS_deg_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.place %>%
  mutate(per_wh = as.double(per_wh)) %>%
  ggplot(aes(x = per_wh)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Wh_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.place %>%
  mutate(per_bl = as.double(per_bl)) %>%
  ggplot(aes(x = per_bl)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_Bl_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.place %>%
  mutate(per_as = as.double(per_as)) %>%
  ggplot(aes(x = per_as)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_As_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.place %>%
  mutate(per_his = as.double(per_his)) %>%
  ggplot(aes(x = per_his)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_His_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.place %>%
  mutate(per_hs_18t24 = as.double(per_hs_18t24)) %>%
  ggplot(aes(x = per_hs_18t24)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_HS_18t24_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.place %>%
  mutate(per_es_3t4 = as.double(per_es_3t4)) %>%
  ggplot(aes(x = per_es_3t4)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_es_3t4_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.place %>%
  mutate(per_emp_pubtr = as.double(per_emp_pubtr)) %>%
  ggplot(aes(x = per_emp_pubtr)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_emp_pubtr_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.place %>%
  mutate(per_bp = as.double(per_bp)) %>%
  ggplot(aes(x = per_bp)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_bp_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')


socmob.place %>%
  mutate(per_cbp = as.double(per_cbp)) %>%
  ggplot(aes(x = per_cbp)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

ggsave("Social-Mobility/Graphics/Plots/Per_cbp_Place.jpg",
       width = 10, height = 8, dpi = 300, units = "in", device='jpg')

##########################################################################################
##########################################################################################
