library(gutenbergr)

timemachine <- gutenberg_download(35)$text
timemachine <- timemachine[9:length(timemachine)]


hsinchu_bus_route=read.csv("C:/Users/ASUS/Desktop/R Transportation/R Github Project/Spatial-Analysis/data/csv_files/hsinchu_bus_route.csv")



## Add data files to project
usethis::use_data(hsinchu_bus_route, overwrite = TRUE)


devtools::install_github("ChiaJung-Yeh/TWspdata")



library(TWspdata)
TWspdata::timemachine
