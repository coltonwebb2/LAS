
# Colt Webb
# 12/19/2023

# Script Description: 

# Create a very general R scrip workflow to create a shapefile from a .csv document with coordinates




#==============================================================================#
#      Load Packages, working path, and EPSG codes ####
#==============================================================================#
require(sf)
require(mapview)
require(maptools)
require(tidyverse)

# My working path
myPath <- "C:/Users/colwebb/Documents/ClearCreekTelemetryProject/Data"  # Change this to the file path that your data live in (make sure slashs are facing / not \ )

# Set the EPSG for your desired Coordinate Reference System 
EPSG <- 5070  # Website to look up codes (https://epsg.io/)




#==============================================================================#
#      Read in Data from .csv file ####
#==============================================================================#
d <- data.frame(read.csv(paste0(myPath,"/name_of_datafile.csv"),
                         na.strings = c(""," ","na","NA", "Na"))) # this line makes sure blanks and NAs are properly made NAs in R (not just text)


# complete any data cleaning, add/delete columns, etc. Make dataframe at its attributes just the way you want them






#==============================================================================#
#      Make Spatial and Quickly View It   ####
#==============================================================================#

# Transform to be spatial
spatial_points <- d %>% 
  st_as_sf(coords = c("lat","long"),  # set as column names of your coordinates UTM or LatLong (ex. c("LWRUTME" "LWRUTMN") or c("Latitude", "Longitude"))
           dim = "XY",                # Pretty much always xy unless its 3D data
           crs = EPSG,                # This is the EPSG code you set at the begining
           remove = FALSE)            # FALSE = Keep the "lat","long" used to make it spatial. TRUE = it deletes these columns from data frame


# View it
mapview(spatial_points) # a basic interactive map should appear in the viewer panel



# Write to ESRI Shapefile
st_write(spatial_points, 
         dsn = paste0(myPath, "/file_path_you_keep_your_shapefile.shp"),
         driver = "ESRI Shapefile", delete_layer = TRUE)



# Now you have a shapefile ready to use in ArcPro