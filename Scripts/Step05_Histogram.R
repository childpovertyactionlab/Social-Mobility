setwd("C:/Users/Michael Lopez/Documents/GitHub")

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

socmob.zip %>%
  mutate(per_tot_pop = as.double(per_tot_pop)) %>%
  ggplot(aes(x = per_tot_pop)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.zip %>%
  mutate(per_med_inc = as.double(per_med_inc)) %>%
  ggplot(aes(x = per_med_inc)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.zip %>%
  mutate(per_gini = as.double(per_gini)) %>%
  ggplot(aes(x = per_gini)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.zip %>%
  mutate(per_less_hs = as.double(per_less_hs)) %>%
  ggplot(aes(x = per_less_hs)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.zip %>%
  mutate(per_hs_deg = as.double(per_hs_deg)) %>%
  ggplot(aes(x = per_hs_deg)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.zip %>%
  mutate(per_wh = as.double(per_wh)) %>%
  ggplot(aes(x = per_wh)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.zip %>%
  mutate(per_bl = as.double(per_bl)) %>%
  ggplot(aes(x = per_bl)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.zip %>%
  mutate(per_as = as.double(per_as)) %>%
  ggplot(aes(x = per_as)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.zip %>%
  mutate(per_his = as.double(per_his)) %>%
  ggplot(aes(x = per_his)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.zip %>%
  mutate(per_hs_18t24 = as.double(per_hs_18t24)) %>%
  ggplot(aes(x = per_hs_18t24)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.zip %>%
  mutate(per_es_3t4 = as.double(per_es_3t4)) %>%
  ggplot(aes(x = per_es_3t4)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.zip %>%
  mutate(per_emp_pubtr = as.double(per_emp_pubtr)) %>%
  ggplot(aes(x = per_emp_pubtr)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.zip %>%
  mutate(per_bp = as.double(per_bp)) %>%
  ggplot(aes(x = per_bp)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.zip %>%
  mutate(per_cbp = as.double(per_cbp)) %>%
  ggplot(aes(x = per_cbp)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

##########################################################################################
##########################################################################################

socmob.tracts %>%
  mutate(per_rohh = as.double(per_rohh)) %>%
  ggplot(aes(x = per_rohh)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.tracts %>%
  mutate(per_tot_pop = as.double(per_tot_pop)) %>%
  ggplot(aes(x = per_tot_pop)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.tracts %>%
  mutate(per_med_inc = as.double(per_med_inc)) %>%
  ggplot(aes(x = per_med_inc)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.tracts %>%
  mutate(per_gini = as.double(per_gini)) %>%
  ggplot(aes(x = per_gini)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.tracts %>%
  mutate(per_less_hs = as.double(per_less_hs)) %>%
  ggplot(aes(x = per_less_hs)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.tracts %>%
  mutate(per_hs_deg = as.double(per_hs_deg)) %>%
  ggplot(aes(x = per_hs_deg)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.tracts %>%
  mutate(per_wh = as.double(per_wh)) %>%
  ggplot(aes(x = per_wh)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.tracts %>%
  mutate(per_bl = as.double(per_bl)) %>%
  ggplot(aes(x = per_bl)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.tracts %>%
  mutate(per_as = as.double(per_as)) %>%
  ggplot(aes(x = per_as)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.tracts %>%
  mutate(per_his = as.double(per_his)) %>%
  ggplot(aes(x = per_his)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.tracts %>%
  mutate(per_hs_18t24 = as.double(per_hs_18t24)) %>%
  ggplot(aes(x = per_hs_18t24)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.tracts %>%
  mutate(per_es_3t4 = as.double(per_es_3t4)) %>%
  ggplot(aes(x = per_es_3t4)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.tracts %>%
  mutate(per_emp_pubtr = as.double(per_emp_pubtr)) %>%
  ggplot(aes(x = per_emp_pubtr)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.tracts %>%
  mutate(per_bp = as.double(per_bp)) %>%
  ggplot(aes(x = per_bp)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.tracts %>%
  mutate(per_cbp = as.double(per_cbp)) %>%
  ggplot(aes(x = per_cbp)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

##########################################################################################
##########################################################################################

socmob.place %>%
  mutate(per_rohh = as.double(per_rohh)) %>%
  ggplot(aes(x = per_rohh)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.place %>%
  mutate(per_tot_pop = as.double(per_tot_pop)) %>%
  ggplot(aes(x = per_tot_pop)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.place %>%
  mutate(per_med_inc = as.double(per_med_inc)) %>%
  ggplot(aes(x = per_med_inc)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.place %>%
  mutate(per_gini = as.double(per_gini)) %>%
  ggplot(aes(x = per_gini)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.place %>%
  mutate(per_less_hs = as.double(per_less_hs)) %>%
  ggplot(aes(x = per_less_hs)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.place %>%
  mutate(per_hs_deg = as.double(per_hs_deg)) %>%
  ggplot(aes(x = per_hs_deg)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.place %>%
  mutate(per_wh = as.double(per_wh)) %>%
  ggplot(aes(x = per_wh)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.place %>%
  mutate(per_bl = as.double(per_bl)) %>%
  ggplot(aes(x = per_bl)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.place %>%
  mutate(per_as = as.double(per_as)) %>%
  ggplot(aes(x = per_as)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.place %>%
  mutate(per_his = as.double(per_his)) %>%
  ggplot(aes(x = per_his)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.place %>%
  mutate(per_hs_18t24 = as.double(per_hs_18t24)) %>%
  ggplot(aes(x = per_hs_18t24)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.place %>%
  mutate(per_es_3t4 = as.double(per_es_3t4)) %>%
  ggplot(aes(x = per_es_3t4)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.place %>%
  mutate(per_emp_pubtr = as.double(per_emp_pubtr)) %>%
  ggplot(aes(x = per_emp_pubtr)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.place %>%
  mutate(per_bp = as.double(per_bp)) %>%
  ggplot(aes(x = per_bp)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

socmob.place %>%
  mutate(per_cbp = as.double(per_cbp)) %>%
  ggplot(aes(x = per_cbp)) +
  geom_histogram(binwidth = 0.1, na.rm = TRUE)

##########################################################################################
##########################################################################################
