# Direct application of https://nceas.github.io/oss-lessons/spatial-data-gis-law/3-mon-intro-gis-in-r.html

#Load all the libraries
library(rgdal)
library(raster)
library(ggplot2)
library(rgeos)
library(mapview)
library(leaflet)
library(broom) # if you plot with ggplot and need to turn sp data into dataframes
options(stringsAsFactors = FALSE)
#Declare tempfile and temp directories where the data will be saved
tmpf  <-tempfile()
tmpd  <-tempdir()
#Download and unzip
unzip(system.file("inst/extdata","shapefile_currency_clum_50m1218m.zip",package="dataACLUMP"),exdir=tmpd)
x=grep(pattern=".shp", x=list.files(tmpd,recursive = T,full.names = T),value=T)


aus.sf<-sf::read_sf(x[[2]],quiet = T)
aus.df<-data.frame(aus.sf)
# load the data 
Rshp <- readOGR(x[[2]],verbose=TRUE)
class(Rshp)
extent(Rshp)
crs(Rshp)
#plot(Rshp, main = "ACLUMP")

# simplify geometry
Rshpsimp <- gSimplify(Rshp, 
                      tol = 3, 
                      topologyPreserve = TRUE)

plot(Rshpsimp,
     main = "map with boundaries simplified")

# simplify with a lower tolerance value (keeping more detail)
Rshpsimp2 <- gSimplify(Rshp, 
                       tol = 10, 
                       topologyPreserve = TRUE)
plot(Rshpsimp2, 
     main = "Map of coastlines - simplified geometry\n tol=10")
# turn the data into a spatial data frame 
Rshpsimp2 <- SpatialLinesDataFrame(Rshpsimp2,
                                   Rshp@data) 
#tidy(coastlines_sim2_df)

# plot the data 
ggplot() +
  geom_path(data = Rshpsimp2, aes(x = long, y = lat, group = group)) +
  labs(title = "Global Coastlines - using ggplot")

ggplot() +
  geom_path(data = Rshpsimp2, aes(x = long, y = lat, group = group)) + 
  coord_fixed() + 
  labs(title = "My awesome ggplot map of coastlines",
       subtitle = "my awesome subtitle",
       x = "", y = "") # cause we don't need x and y labels do we?
# create leaflet 
mapview::mapview(Rshpsimp2)

# create a leaflet object
leafl<-leaflet(Rshpsimp2) %>%
  addTiles() %>% # add basemap to your map
  # then add a lines layer
  addPolylines(color = "#444444", weight = 1, smoothFactor = 0.5,
               opacity = 1.0)

