library(sf)
library(dplyr)
library(ggplot2)

# reference: https://www.erikhoward.net/blog/how-to-create-an-r-data-package/

# load files from local
hsinchu_bus_route=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/csv_files/hsinchu_bus_route.csv")
hsinchu_scenicSpot=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/csv_files/hsinchu_scenicSpot.csv")
taipei_cycle_path=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_cycle_path/taipei_cycle_path.shp")
taipei_village_map=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_map/taipei_village_map.shp")
taipei_mrt_route=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_mrt/taipei_mrt_route.shp")
taipei_mrt_station=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_mrt/taipei_mrt_station.shp")
taipei_youbike=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_youbike/taipei_youbike.shp")
taiwan_county=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taiwan_map/taiwan_county.shp")
taiwan_town=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taiwan_map/taiwan_town.shp")
taiwan_village=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taiwan_map/taiwan_village.shp")
TRA_line=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/TRA/TRA_line.csv", fileEncoding="UTF-8")
TRA_ridership=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/TRA/TRA_ridership.csv")
TRA_station=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/TRA/TRA_station.csv")
taiwan_school=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/school/school.csv")
taipei_mrt_station_buf=st_buffer(taipei_mrt_station, 200)
write_sf(taipei_mrt_station_buf, "C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_mrt/taipei_mrt_station_buf.shp", layer_options="ENCODING=UTF-8")



# Hsinchu Data
hs_bus_route=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/TWspdata/hsinchu_data/bus_route_hsinchu.shp") %>% select(-DRTS_ty)
colnames(hs_bus_route)=c("RouteUID","RouteName","SubRouteUID","Direction","geometry")
hs_bus_stop=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/TWspdata/hsinchu_data/bus_stop_hsinchu.shp") %>% select(-DRTS_ty)
colnames(hs_bus_stop)=c("RouteUID","RouteName","SubRouteUID","SubRouteName","StopUID","StopName","StopBoarding","StopSequence","PositionLat","Positionon",
                        "weekday","weekend","geometry")
hs_village=filter(taiwan_village, COUNTYNAME %in% c("·s¦Ë¿¤","·s¦Ë¥«")) %>% select(VILLCODE, COUNTYNAME, TOWNNAME, VILLNAME, COUNTYCODE, TOWNCODE)
hs_youbike=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/TWspdata/hsinchu_data/hsinchu_youbike.shp")




# Add data files to project
usethis::use_data(hsinchu_bus_route, overwrite=T)
usethis::use_data(hsinchu_scenicSpot, overwrite=T)
usethis::use_data(taipei_cycle_path, overwrite=T)
usethis::use_data(taipei_village_map, overwrite=T)
usethis::use_data(taipei_mrt_route, overwrite=T)
usethis::use_data(taipei_mrt_station, overwrite=T)
usethis::use_data(taipei_youbike, overwrite=T)
usethis::use_data(taiwan_county, overwrite=T)
usethis::use_data(taiwan_town, overwrite=T)
usethis::use_data(taiwan_village, overwrite=T)
usethis::use_data(TRA_line, overwrite=T)
usethis::use_data(TRA_ridership, overwrite=T)
usethis::use_data(TRA_station, overwrite=T)
usethis::use_data(taiwan_school, overwrite=T)
usethis::use_data(taipei_mrt_station_buf, overwrite=T)


# upload the files to GitHub
usethis::use_git()


# after uploading, remember to push to GitHub in Terminal
# git push -u origin main



# download the files from my GitHub
devtools::install_github("ChiaJung-Yeh/TWspdata", force=T)
library(TWspdata)

TWspdata::TRA_station
TWspdata::hsinchu_scenicSpot


ggplot()+
  geom_sf(data=taipei_mrt_route, size=1)+
  geom_sf(data=taipei_cycle_path, color="blue")

