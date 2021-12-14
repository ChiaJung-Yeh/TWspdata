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
  COUNTYNAME %in% c("宜蘭縣","基隆市","臺北市","新北市","新竹市", "新竹縣","桃園市") ~ "北區",
  COUNTYNAME %in% c("彰化縣","南投縣","雲林縣","苗栗縣","臺中市") ~ "中區",
  COUNTYNAME %in% c("雲林縣","臺南市","嘉義市","嘉義縣","高雄市", "屏東縣") ~ "南區",
  COUNTYNAME %in% c("臺東縣","花蓮縣") ~ "東區"),
  COUNTYENG=case_when(
    COUNTYNAME %in% c("新竹縣","新竹市","嘉義縣","嘉義市") ~ COUNTYENG,
    COUNTYNAME=="新北市" ~ "New Taipei",
    TRUE ~ substr(COUNTYENG, 1, regexpr(" ", COUNTYENG)-1)
))%>%
  left_join(social_economics)


taiwan_peak=mutate(taiwan_peak, geometry=st_as_sfc(paste0("POINT(", X, " ", Y, ")")))%>%
  st_sf(crs=3826)
taiwan_peak$Z=as.numeric(gsub("公尺", "", taiwan_peak$Z))


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

TWspdata::tw_county_main
TWspdata::taiwan_peak



