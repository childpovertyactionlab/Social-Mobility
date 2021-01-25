#Calculating Exposure Index#

names(socmob.tract)

popwh <- sum(socmob.tract$wh_popE_18)
popbl <- sum(socmob.tract$bl_popE_18)
popas <- sum(socmob.tract$as_popE_18)
pophis <- sum(socmob.tract$his_popE_18)
poptot <- sum(socmob.tract$tot_popE_18)
popnonwh <- poptot-popwh

socmob.exposure <- socmob.tract %>%
  transmute(GEOID, NAME, 
            exp_blwh = (bl_popE_18/popbl)*(wh_popE_18/tot_popE_18),
            exp_aswh = (as_popE_18/popas)*(wh_popE_18/tot_popE_18),
            exp_hiswh = (his_popE_18/pophis)*(wh_popE_18/tot_popE_18),
            exp_whbl = (wh_popE_18/popwh)*(bl_popE_18/tot_popE_18),
            exp_asbl = (as_popE_18/popas)*(bl_popE_18/tot_popE_18),
            exp_hisbl = (his_popE_18/pophis)*(bl_popE_18/tot_popE_18),
            exp_blhis = (bl_popE_18/popbl)*(his_popE_18/tot_popE_18),
            exp_ashis = (as_popE_18/popas)*(his_popE_18/tot_popE_18),
            exp_whhis = (wh_popE_18/popwh)*(his_popE_18/tot_popE_18),
            exp_blas = (bl_popE_18/popbl)*(as_popE_18/tot_popE_18),
            exp_whas = (wh_popE_18/popwh)*(as_popE_18/tot_popE_18),
            exp_hisas = (his_popE_18/pophis)*(as_popE_18/tot_popE_18),
            exp_whnon = (wh_popE_18/popwh)*(popnonwh/tot_popE_18))

sum(socmob.exposure$exp_blwh, na.rm = TRUE)
sum(socmob.exposure$exp_aswh, na.rm = TRUE)
sum(socmob.exposure$exp_hiswh, na.rm = TRUE)
sum(socmob.exposure$exp_whbl, na.rm = TRUE)
sum(socmob.exposure$exp_asbl, na.rm = TRUE)
sum(socmob.exposure$exp_hisbl, na.rm = TRUE)
sum(socmob.exposure$exp_blhis, na.rm = TRUE)
sum(socmob.exposure$exp_ashis, na.rm = TRUE)
sum(socmob.exposure$exp_whhis, na.rm = TRUE)
sum(socmob.exposure$exp_blas, na.rm = TRUE)
sum(socmob.exposure$exp_whas, na.rm = TRUE)
sum(socmob.exposure$exp_hisas, na.rm = TRUE)
sum(socmob.exposure$exp_whnon, na.rm = TRUE)


#BLACK
ggplot(socmob.exposure, aes(x=exp_blas)) +
  geom_histogram(binwidth = 0.00005, fill = "#008097", na.rm = TRUE) +
  geom_vline(xintercept = mean(socmob.exposure$exp_blas, na.rm = TRUE), size = 2, color = "#ec008c") +
  geom_vline(xintercept = median(socmob.exposure$exp_blas, na.rm = TRUE), size = 2, color = "#eaca2d")

ggplot(socmob.exposure, aes(x=exp_blwh)) +
  geom_histogram(binwidth = 0.00005, fill = "#008097", na.rm = TRUE) +
  geom_vline(xintercept = mean(socmob.exposure$exp_blwh, na.rm = TRUE), size = 2, color = "#ec008c") +
  geom_vline(xintercept = median(socmob.exposure$exp_blwh, na.rm = TRUE), size = 2, color = "#eaca2d")

ggplot(socmob.exposure, aes(x=exp_blhis)) +
  geom_histogram(binwidth = 0.00005, fill = "#008097", na.rm = TRUE) +
  geom_vline(xintercept = mean(socmob.exposure$exp_blhis, na.rm = TRUE), size = 2, color = "#ec008c") +
  geom_vline(xintercept = median(socmob.exposure$exp_blhis, na.rm = TRUE), size = 2, color = "#eaca2d")

#HISPANIC
ggplot(socmob.exposure, aes(x=exp_hisbl)) +
  geom_histogram(binwidth = 0.00005, fill = "#008097", na.rm = TRUE) +
  geom_vline(xintercept = mean(socmob.exposure$exp_hisbl, na.rm = TRUE), size = 2, color = "#ec008c") +
  geom_vline(xintercept = median(socmob.exposure$exp_hisbl, na.rm = TRUE), size = 2, color = "#eaca2d")

ggplot(socmob.exposure, aes(x=exp_hiswh)) +
  geom_histogram(binwidth = 0.00005, fill = "#008097", na.rm = TRUE) +
  geom_vline(xintercept = mean(socmob.exposure$exp_hiswh, na.rm = TRUE), size = 2, color = "#ec008c") +
  geom_vline(xintercept = median(socmob.exposure$exp_hiswh, na.rm = TRUE), size = 2, color = "#eaca2d")

ggplot(socmob.exposure, aes(x=exp_hisas)) +
  geom_histogram(binwidth = 0.00005, fill = "#008097", na.rm = TRUE) +
  geom_vline(xintercept = mean(socmob.exposure$exp_hisas, na.rm = TRUE), size = 2, color = "#ec008c") +
  geom_vline(xintercept = median(socmob.exposure$exp_hisas, na.rm = TRUE), size = 2, color = "#eaca2d")

#ASIAN
ggplot(socmob.exposure, aes(x=exp_aswh)) +
  geom_histogram(binwidth = 0.00005, fill = "#008097", na.rm = TRUE) +
  geom_vline(xintercept = mean(socmob.exposure$exp_aswh, na.rm = TRUE), size = 2, color = "#ec008c") +
  geom_vline(xintercept = median(socmob.exposure$exp_aswh, na.rm = TRUE), size = 2, color = "#eaca2d")

ggplot(socmob.exposure, aes(x=exp_asbl)) +
  geom_histogram(binwidth = 0.00005, fill = "#008097", na.rm = TRUE) +
  geom_vline(xintercept = mean(socmob.exposure$exp_asbl, na.rm = TRUE), size = 2, color = "#ec008c") +
  geom_vline(xintercept = median(socmob.exposure$exp_asbl, na.rm = TRUE), size = 2, color = "#eaca2d")

ggplot(socmob.exposure, aes(x=exp_ashis)) +
  geom_histogram(binwidth = 0.00005, fill = "#008097", na.rm = TRUE) +
  geom_vline(xintercept = mean(socmob.exposure$exp_ashis, na.rm = TRUE), size = 2, color = "#ec008c") +
  geom_vline(xintercept = median(socmob.exposure$exp_ashis, na.rm = TRUE), size = 2, color = "#eaca2d")

#WHITE
ggplot(socmob.exposure, aes(x=exp_whbl)) +
  geom_histogram(binwidth = 0.00005, fill = "#008097", na.rm = TRUE) +
  geom_vline(xintercept = mean(socmob.exposure$exp_whbl, na.rm = TRUE), size = 2, color = "#ec008c") +
  geom_vline(xintercept = median(socmob.exposure$exp_whbl, na.rm = TRUE), size = 2, color = "#eaca2d")

ggplot(socmob.exposure, aes(x=exp_whhis)) +
  geom_histogram(binwidth = 0.00005, fill = "#008097", na.rm = TRUE) +
  geom_vline(xintercept = mean(socmob.exposure$exp_whhis, na.rm = TRUE), size = 2, color = "#ec008c") +
  geom_vline(xintercept = median(socmob.exposure$exp_whhis, na.rm = TRUE), size = 2, color = "#eaca2d")

ggplot(socmob.exposure, aes(x=exp_whas)) +
  geom_histogram(binwidth = 0.00005, fill = "#008097", na.rm = TRUE) +
  geom_vline(xintercept = mean(socmob.exposure$exp_whas, na.rm = TRUE), size = 2, color = "#ec008c") +
  geom_vline(xintercept = median(socmob.exposure$exp_whas, na.rm = TRUE), size = 2, color = "#eaca2d")

#Join to Tracts 
tract.shape <- st_read("Social-Mobility/Data/Reference Geographies/Shapefiles/sm_tracts.shp")
socmob.exposure <- socmob.exposure %>%
  mutate(Geoid2 = as.numeric(GEOID))
tract.merge <- left_join(tract.shape, socmob.exposure, by = "Geoid2")

str(tract.shape)
str(socmob.exposure)
str(tract.merge)

names(tract.merge)

export(socmob.exposure, "Social-Mobility/Data/ACS/Exposure_Index.csv")
