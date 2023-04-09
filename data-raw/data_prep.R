library(sf)
library(dplyr)
library(ggplot2)
library(TDX)
library(data.table)

# reference: https://www.erikhoward.net/blog/how-to-create-an-r-data-package/

# load files from local
hsinchu_bus_route=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/csv_files/hsinchu_bus_route.csv", fileEncoding="Big5")
hsinchu_scenicSpot=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/csv_files/hsinchu_scenicSpot.csv", fileEncoding="Big5")
taipei_cycle_path=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_cycle_path/taipei_cycle_path.shp")
taipei_village_map=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_map/taipei_village_map.shp")
taipei_mrt_route=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_mrt/taipei_mrt_route.shp")
taipei_mrt_station=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_mrt/taipei_mrt_station.shp")%>%
  st_transform(crs=3826)
taipei_mrt_patronage=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_mrt/taipei_mrt_patronage.csv", fileEncoding="Big5")
taipei_youbike=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_youbike/taipei_youbike.shp")
taiwan_county=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taiwan_map/taiwan_county.shp")
taiwan_town=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taiwan_map/taiwan_town.shp")
taiwan_village=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taiwan_map/taiwan_village.shp")
taiwan_village_pop=fread("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taiwan_map/taiwan_village_pop.csv", encoding="UTF-8")
taiwan_village_pop$VILLCODE=as.character(taiwan_village_pop$VILLCODE)
TRA_line=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/TRA/TRA_line.csv", fileEncoding="UTF-8")
TRA_ridership=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/TRA/TRA_ridership.csv")
TRA_station=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/TRA/TRA_station.csv", fileEncoding="Big5")
taiwan_school=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taiwan_school/taiwan_school.csv", fileEncoding="Big5")
taipei_mrt_station_buf=st_buffer(taipei_mrt_station, 200)
write_sf(taipei_mrt_station_buf, "C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_mrt/taipei_mrt_station_buf.shp", layer_options="ENCODING=UTF-8")
taiwan_factory=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taiwan_factory/taiwan_factory.shp")
house_price=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/house_price/house_price.csv", fileEncoding="Big5")
shuangho_house_price=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/house_price/shuangho_house_price.csv", fileEncoding="Big5")
youbike_ridership=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_youbike/youbike_ridership.csv")
Miaoli_Road_Network=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/Miaoli_Road_Network/Miaoli_Road_Network.shp")
convenience_store=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/convenience_store/convenience_store.csv", fileEncoding="Big5")

# Hsinchu Data
hs_bus_route=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/TWspdata/hsinchu_data/bus_route_hsinchu.shp") %>% select(-DRTS_ty)
colnames(hs_bus_route)=c("RouteUID","RouteName","SubRouteUID","Direction","geometry")
hs_bus_stop=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/TWspdata/hsinchu_data/bus_stop_hsinchu.shp") %>% select(-DRTS_ty)
colnames(hs_bus_stop)=c("RouteUID","RouteName","SubRouteUID","SubRouteName","StopUID","StopName","StopBoarding","StopSequence","PositionLat","Positionon",
                        "weekday","weekend","geometry")
hs_village=filter(taiwan_village, COUNTYNAME %in% c("新竹縣","新竹市")) %>% select(VILLCODE, COUNTYNAME, TOWNNAME, VILLNAME, COUNTYCODE, TOWNCODE)
hs_youbike=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/TWspdata/hsinchu_data/hsinchu_youbike.shp")



# Add data files to project
usethis::use_data(hsinchu_bus_route, overwrite=T)
usethis::use_data(hsinchu_scenicSpot, overwrite=T)
usethis::use_data(taipei_cycle_path, overwrite=T)
usethis::use_data(taipei_village_map, overwrite=T)
usethis::use_data(taipei_mrt_route, overwrite=T)
usethis::use_data(taipei_mrt_station, overwrite=T)
usethis::use_data(taipei_mrt_patronage, overwrite=T)
usethis::use_data(taipei_youbike, overwrite=T)
usethis::use_data(taiwan_county, overwrite=T)
usethis::use_data(taiwan_town, overwrite=T)
usethis::use_data(taiwan_village, overwrite=T)
usethis::use_data(taiwan_village_pop, overwrite=T)
usethis::use_data(TRA_line, overwrite=T)
usethis::use_data(TRA_ridership, overwrite=T)
usethis::use_data(TRA_station, overwrite=T)
usethis::use_data(taiwan_school, overwrite=T)
usethis::use_data(taipei_mrt_station_buf, overwrite=T)
usethis::use_data(hs_bus_route, overwrite=T)
usethis::use_data(hs_bus_stop, overwrite=T)
usethis::use_data(hs_village, overwrite=T)
usethis::use_data(hs_youbike, overwrite=T)
usethis::use_data(taiwan_factory, overwrite=T)
usethis::use_data(house_price, overwrite=T)
usethis::use_data(shuangho_house_price, overwrite=T)
usethis::use_data(youbike_ridership, overwrite=T)
usethis::use_data(Miaoli_Road_Network, overwrite=T)
usethis::use_data(convenience_store, overwrite=T)
usethis::use_data(taipei_mrt_patronage, overwrite=T)


# upload the files to GitHub
usethis::use_git()


# after uploading, remember to push to GitHub in Terminal
# git push -u origin main



# download the files from my GitHub
devtools::install_github("ChiaJung-Yeh/TWspdata", force=T)
library(TWspdata)

TWspdata::hs
TWspdata::TRA_station
TWspdata::hsinchu_scenicSpot


ggplot()+
  geom_sf(data=taipei_mrt_route, size=1)+
  geom_sf(data=taipei_cycle_path, color="blue")





TWspdata::hs_bus_route
TWspdata::hs_bus_stop
TWspdata::hs_village
TWspdata::hs_youbike
TWspdata::hsinchu_bus_route
TWspdata::hsinchu_scenicSpot
TWspdata::taipei_cycle_path
TWspdata::taipei_mrt_route
TWspdata::taipei_mrt_station
TWspdata::taipei_mrt_station_buf
TWspdata::taipei_village_map
TWspdata::taipei_youbike
TWspdata::taiwan_county
TWspdata::taiwan_school
TWspdata::taiwan_town
TWspdata::taiwan_village
TWspdata::TRA_line
TWspdata::TRA_ridership
TWspdata::TRA_station






