library(sf)
library(dplyr)
library(ggplot2)
library(data.table)
library(TWspdata)

social_economics=fread("C:/Users/ASUS/Desktop/R Transportation/R Github Project/TWspdata/data_new/social_economics.csv")
taiwan_peak=fread("C:/Users/ASUS/Desktop/R Transportation/R Github Project/TWspdata/data_new/taiwan_peak.csv")

# tw_border=st_bbox(c(xmin=117.910836, xmax=122.079171, ymin=21.883065, ymax=26.556588), crs=4326)
tw_border=st_bbox(c(xmin=119.910836, xmax=122.079171, ymin=21.883065, ymax=25.356588), crs=4326)
tw_border=st_as_sfc(tw_border)
tw_border=st_transform(tw_border, crs=3826)
tw_county_main=st_transform(taiwan_county, crs=3826)
tw_county_main=st_intersection(tw_county_main, tw_border)
ggplot()+
  geom_sf(data=tw_county_main)

tw_county_main=mutate(tw_county_main, REGION=case_when(
  COUNTYNAME %in% c("?y????","?򶩥?","?O?_??","?s?_??","?s?˥?", "?s?˿?","???�?") ~ "?_??",
  COUNTYNAME %in% c("???ƿ?","?n?�?","???L??","?]?߿?","?O????") ~ "????",
  COUNTYNAME %in% c("???L??","?O?n??","?Ÿq??","?Ÿq??","??????", "?̪F??") ~ "?n??",
  COUNTYNAME %in% c("?O?F??","?�???") ~ "?F??"),
  COUNTYENG=case_when(
    COUNTYNAME %in% c("?s?˿?","?s?˥?","?Ÿq??","?Ÿq??") ~ COUNTYENG,
    COUNTYNAME=="?s?_??" ~ "New Taipei",
    TRUE ~ substr(COUNTYENG, 1, regexpr(" ", COUNTYENG)-1)
))%>%
  left_join(social_economics)


taiwan_peak=mutate(taiwan_peak, geometry=st_as_sfc(paste0("POINT(", X, " ", Y, ")")))%>%
  st_sf(crs=3826)
taiwan_peak$Z=as.numeric(gsub("????", "", taiwan_peak$Z))


ggplot()+
  geom_sf(data=tw_county_main)+
  geom_sf(data=taiwan_peak)



# Add data files to project
usethis::use_data(tw_county_main, overwrite=T)
usethis::use_data(taiwan_peak, overwrite=T)


# upload the files to GitHub
usethis::use_git()


# after uploading, remember to push to GitHub in Terminal
# git push -u origin main



# download the files from my GitHub
devtools::install_github("ChiaJung-Yeh/TWspdata", force=T)
library(TWspdata)
??TWspdata
TWspdata::tw_county_main
TWspdata::taiwan_peak



