library(sf)
library(ggplot2)

# loal files from local
hsinchu_bus_route=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/csv_files/hsinchu_bus_route.csv")
hsinchu_scenicSpot=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/csv_files/hsinchu_scenicSpot.csv")
taipei_cycle_path=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_cycle_path/taipei_cycle_path.shp")
taipei_village_map=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_map/taipei_village_map.shp")
taipei_mrt_route=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_mrt/taipei_mrt_route.shp")
taipei_mrt_station=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_mrt/taipei_mrt_station.shp")
taipei_youbike=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taipei_youbike/taipei_youbike.shp")
taiwan_county=read_sf("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/taiwan_county/taiwan_county.shp")
TRA_line=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/TRA/TRA_line.csv", fileEncoding="UTF-8")
TRA_ridership=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/TRA/TRA_ridership.csv")
TRA_station=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/TRA/TRA_station.csv", fileEncoding="UTF-8")


# Add data files to project
usethis::use_data(hsinchu_bus_route, overwrite=T)
usethis::use_data(hsinchu_scenicSpot, overwrite=T)
usethis::use_data(taipei_cycle_path, overwrite=T)
usethis::use_data(taipei_village_map, overwrite=T)
usethis::use_data(taipei_mrt_route, overwrite=T)
usethis::use_data(taipei_mrt_station, overwrite=T)
usethis::use_data(taipei_youbike, overwrite=T)
usethis::use_data(taiwan_county, overwrite=T)
usethis::use_data(TRA_line, overwrite=T)
usethis::use_data(TRA_ridership, overwrite=T)
usethis::use_data(TRA_station, overwrite=T)


# upload the files to GitHub
usethis::use_git()


# after uploading, remember to push to GitHub in Terminal
# git push -u origin main



# download the files from my GitHub
devtools::install_github("ChiaJung-Yeh/TWspdata")
library(TWspdata)



class(taipei_village_map)

ggplot(taipei_village_map)+
  geom_sf()

