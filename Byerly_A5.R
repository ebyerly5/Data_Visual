# Name: Eric Byerly
# ID: w3114179
# Course: CSIS 334 #
# Description: Works with maps using ggplot2 with the goal 
#to create a map of the United States that visualizes median 
#household income.

# Pre-Documentation Item Commands
graphics.off()
rm(list=ls())
setwd("~/Desktop/Data Visualization")

## GGplot2 Library ##
library(ggplot2)

## Part 1 - Basic Mapping ##
#1. Download the file zipIncome.csv from Canvas and load it into R.
d <- read.csv("zipIncome.csv")

#2. Download a color terrain map of the United States, zoom level 4, 
#from Google maps. Use geocode to first get the location,
#setting override limit to true.
install.packages("ggmap")
library(ggmap)
register_google(key = "AIzaSyC9pr4hKGA2LEekuVI21j0xGSDaVzKuuOA", 
                write = TRUE)
US <- as.numeric(geocode("United States"))
USMAP <- get_map(location = US, source = "google", 
                zoom = 4, maptype= "road")
ggmap(USMAP)

#3. Visualize the map, and add a scatter points layer to image,
#mapping aesthetic color(Median). Your graphic should match Figure 1.
ggmap(USMAP) + geom_point(data = d, aes(x = longitude, y = latitude, 
                                        color = Median))

## Part 2 – Styling the information ##
#4. The default mapping of a continuous variable to color generates a 
#color gradient scale, where colors range from low = #132B43 to 
#high = #56B1F7. The default colours don’t lend themselves to our map.
#Set low to “beige” and high to “blue”. Set alpha to 0.5. Gracefully 
#handle NAs by removing them in your ggplot2 call (do not delete them 
#from your data frame. Handling them will prevent the annoying red 
#warnings). Your graphic should match Figure 2.
ggmap(USMAP) + geom_point(data = d, alpha = 0.5, na.rm = TRUE, 
                          aes(x = longitude, y = latitude, 
                              color = Median)) + 
  scale_color_continuous(low = "beige", high = "blue")

#5.  The map looks good, but we can do better.What’s relevant to readers
#is income data and the geographic positions of those data. The colors of
#the underlying map detract & distract from this information. Get a new 
#map, setting the colors to black and white. Overlay the same
#points layer from #4, again dropping NAs.
UnitedStates <- get_map(location = US, maptype = "terrain", 
                        source = "google",zoom = 4, color = "bw")

ggmap(UnitedStates) + 
  geom_point(data = d, alpha = 0.5, na.rm = TRUE, aes(x = longitude,
                                                      y = latitude, 
                                                      color = Median)) + 
  scale_color_continuous(low = "beige", high = "blue")

#6. Finally, replace high colour with “red”. The legend should range 
#from 0 to 250,000, in steps of 50,000. Give the legend an appropriate 
#name. Add a title to your graph. Add a source caption. Rename your
#two axes, including the degree symbol (you can insert the symbol ° 
#directly into your string). Set alpha to 0.1. 
#Your final graphic must match Figure 3 exactly.
ggmap(UnitedStates) + 
  geom_point(data = d, alpha = 0.1, na.rm = TRUE, aes(x = longitude, 
                                                      y = latitude, 
                                                      color = Median)) + 
  scale_color_continuous(low = "beige", high = "red", 
                         limit = c(0, 250000), breaks = seq(0, 250000,
                                                            by = 50000), 
                         labels = c("0", "50,000", "100,000", "150,000",
                                    "200,000", "250,000")) + 
  ggtitle("Median US Household Incomes") + 
  labs(col = "Median Income ($)", caption = "U.S. Census Bureau") + 
  xlab("Longitude(°)") + 
  ylab("Latitude(°)") 