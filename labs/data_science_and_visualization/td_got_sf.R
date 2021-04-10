#!/usr/bin/Rscript

library(readr)
library(dplyr)
library(tidyr)
library(tcltk)
library(ggplot2)
library(sf)

#####EX1
cat("--------------------------------------------------------------------------\n")
cat("EX1\n")

cat('\n\n#####characters\n'); characters = read_csv("data/characters.csv")
cat('\n###summary\n'); summary(characters)
cat('\n###str\n'); str(characters)

cat('\n\n#####episodes\n'); episodes = read_csv("data/episodes.csv")
cat('\n###summary\n'); summary(episodes)
cat('\n###str\n'); str(episodes)

cat('\n\n#####scenes\n'); scenes = read_csv("data/scenes.csv")
cat('\n###summary\n'); summary(scenes) 
cat('\n###str\n'); str(scenes)

cat('\n\n#####appearances\n'); appearances = read_csv("data/appearances.csv")
cat('\n###summary\n'); summary(appearances)
cat('\n###str\n'); str(appearances)

#####EX5
cat("--------------------------------------------------------------------------\n")
cat("EX5\n")

cat("\n5.1/ Read the geographical data describing the GoT universe stored in the data/GoTRelease directory as shapefile files with the sf libraries and load them in data-frames with explicit names, you will specify during the import that the coordinate system is (comparable with) the wgs-84 system whose crs code is 4326. Observe the different tables created: dimensions, variables, type of geometry, metadata. \n")
locations=st_read("data/GoTRelease/Locations.shp", crs=4326)
lakes=st_read("data/GoTRelease/Lakes.shp", crs=4326)
conts=st_read("data/GoTRelease/Continents.shp", crs=4326)
land=st_read("data/GoTRelease/Land.shp", crs=4326)
wall=st_read("data/GoTRelease/Wall.shp", crs=4326)
islands=st_read("data/GoTRelease/Islands.shp", crs=4326)
kingdoms=st_read("data/GoTRelease/Political.shp", crs=4326)
landscapes=st_read("data/GoTRelease/Landscape.shp", crs=4326)
roads=st_read("data/GoTRelease/Roads.shp", crs=4326)
rivers=st_read("data/GoTRelease/Rivers.shp", crs=4326)
scenes_locations=st_read("data/GoTRelease/ScenesLocations.shp", crs=4326)

cat("\n5.2/ Use the st_distance function to calculate distances in m between locations of size5. Which cities are the closest? The farthest ones? \n")
cities = locations %>%
  filter(size == 5)
dists = st_distance(cities)
cities$name[which(dists == max(dists), arr.ind = TRUE)[1,]]

cities$name[which(dists == min(dists[upper.tri(dists)]), arr.ind = TRUE)[1,]]

cat("\n5.3/ Which family owns the most castles? Use the function st_join to make a spatial join between the location table and the kingdoms table (political). \n")
CastlesPerKingdoms = st_join(locations, kingdoms) %>%
  filter(type == "Castle") %>%
  st_drop_geometry() %>%
  count(ClaimedBy)

CastlesPerKingdoms

cat("\n5.4/ Which family owns the most castles? This time if you use the function `st_covers . \n")
castles_cover = st_covers(kingdoms, locations %>% filter(type == "Castle"))
kingdoms$nbcastles = sapply(castles_cover, length)
kingdoms %>% 
  arrange(desc(nbcastles))

cat("\n5.5/ Which family has the largest area of forest? \n")
st_intersection(kingdoms, landscapes) %>%
  mutate(area = st_area(geometry)) %>%
  count(ClaimedBy, wt = area) %>%
  st_drop_geometry() %>%
  arrange(desc(n))

cat("\n5.6/ How far did the main characters of the series (“Jon Snow”, “Tyrion Lannister”, “Daenerys Targaryen”, “Sansa Stark”, “Cersei Lannister”, “Arya Stark”) travel ? The spatial table data/GoTRelease/ScenesLocations.shp will give you the locations of the places referenced in the scene table and you will use the lag function of dplyr. \n")
main_char = c("Jon Snow", "Tyrion Lannister", "Daenerys Targaryen", "Sansa Stark", "Cersei Lannister", "Arya Stark")
distance_characters = scenes %>%
  left_join(appearances) %>%
  filter(name %in% main_char) %>%
  group_by(name) %>%
  mutate(previous_location = lag(location)) %>%
  filter(location != previous_location) %>%
  left_join(scenes_locations) %>%
  left_join(scenes_locations, by=c("previous_location"="location")) %>%
  mutate(dist = st_distance(geometry.x, geometry.y, by_element = TRUE)) %>%
  summarise(total_dist = sum(as.numeric(dist), na.rm = TRUE) / 1000)

distance_characters

cat("\n5.7/ Same question but without using the `lag function of dplyr. \n")
distance_characters = scenes %>%
  left_join(appearances) %>%
  filter(name %in% main_char) %>%
  left_join(scenes_locations) %>%
  st_as_sf() %>%
  group_by(name) %>%
  summarise(do_union = FALSE) %>%
  sf::st_cast("LINESTRING") %>%
  mutate(dist = as.numeric(st_length(geometry)) / 1000)

distance_characters

#####EX6
cat("--------------------------------------------------------------------------\n")
cat("EX6\n")

cat("\n6.1/ Make a background map of the GoT universe with the lakes, rivers and forests as well as the names of the main cities. You can use geom_sf` andgeom_sf_text` and be inspired by this map: \n")
colforest="#c0d7c2"
colriver="#7ec9dc"
colland="ivory"
borderland="ivory3"

X11()
ggplot() + 
  geom_sf(data=land, fill=colland, col=borderland, size=0.1) +
  geom_sf(data=islands, fill=colland, col="ivory3") +
  geom_sf(data=landscapes %>% filter(type=="forest"), fill=colforest, col=colforest) +
  geom_sf(data=rivers, col=colriver) +
  geom_sf(data=lakes, col=colriver, fill=colriver) +
  geom_sf(data=wall, col="black", size=1) + 
  geom_sf_text(data=locations %>% filter(size>4, name!="Tolos"), aes(label=name), size=2.5, family="Palatino", fontface="italic") +
  theme_minimal() +
  coord_sf(expand=0, ndiscr=0) + 
  theme(panel.background=element_rect(fill=colriver, color=NA)) +
  labs(title="GoT", caption="roortheroor, 2020", x="", y="")

cat("\n6.2/ Build a data.frame containing for each location the time of presence on the screen of “Tyrion Lannister”. Load the spatial data data//GoTRelease/ScenesLocations.shp and join it with the previous table. Finally make a map with proportional symbols to visualize these data. \n")
tyrion_places = appearances %>%
  filter(name == "Tyrion Lannister") %>%
  left_join(scenes) %>%
  group_by(location) %>%
  summarize(duration=sum(duration / 60)) %>%
  left_join(scenes_locations) %>%
  st_as_sf()
  
X11()
ggplot() +
  geom_sf(data=land, fill=colland, col=borderland, size=0.1) +
  geom_sf(data=islands, fill=colland, col="ivory3") +
  geom_sf(data=landscapes %>% filter(type=="forest"), fill=colforest, col=colforest) +
  geom_sf(data=rivers, col=colriver) +
  geom_sf(data=lakes, col=colriver, fill=colriver) +
  geom_sf(data=tyrion_places, aes(size=duration), color="purple") +
  scale_size_area("Time on screen", breaks=c(0, 30, 60, 120, 240)) +
  geom_sf_text(data=locations %>% filter(size>4, name!="Tolos"), aes(label=name), size=2.5, family="Palatino", fontface="italic") +
  theme_minimal() +
  coord_sf(expand=0, ndiscr=0) +
  theme(panel.background=element_rect(fill=colriver, color=NA)) +
  labs(title="Tyrion Lannister time on screen per location", caption="roortheroor, 2020", x="", y="")

cat("\n6.3/ Preparation of simplified background maps : Create a spatial data.frame backgound using the function st_as_sf containing a column name with the names of the 6 main characters of the series “Jon Snow”, “Tyrion Lannister”, “Daenerys Targaryen”, “Sansa Stark”, “Cersei Lannister”, “Arya Stark” and an identical geometry column for all characters containing the union of all land and island polygons. \n")
main_char=c("Jon Snow", "Tyrion Lannister", "Daenerys Targaryen", "Sansa Stark", "Cersei Lannister", "Arya Stark")
landpol=st_union(st_geometry(land))
islandpol=st_union(st_geometry(islands))
backpol=st_union(landpol, islandpol)
background=st_as_sf(data.frame(name=main_char, geometry=rep(backpol, 6)))

background

cat("\n6.4/ Create a data.frame with for each main character and each location the time of presence on the screen. Attach this table to the table of georeferenced locations. \n")
loc_time=appearances %>%
  filter(name %in% main_char) %>%
  left_join(scenes) %>%
  group_by(location, name) %>%
  summarize(duration=sum(duration, na.rm=TRUE))

loc_time_mc=scenes_locations %>%
  left_join(loc_time)

cat("\n6.5/ Make a series of map (one per character) with their screen times represented in proportional symbols. The final figure might look like this: \n")

X11()
ggplot() + 
  geom_sf(data=background, fill=colland, col=borderland, size=0.1) +
  geom_sf(data=loc_time_mc %>% filter(!is.na(duration)), aes(size=duration / 60, color=name)) +
  geom_sf_text(data=loc_time_mc %>% filter(duration > 60*60), aes(label=location), color="#000000", vjust="bottom", family="Palatino", fontface="italic") +
  coord_sf(expand=0, ndiscr=0) +
  scale_color_discrete(guide="none") +
  scale_size_area("Time on screen (min)", max_size=12, breaks=c(30, 60, 120, 240)) +
  facet_wrap(~name) +
  theme(panel.background=element_rect(fill=colriver, color=NA), text=element_text(family="Palatino", face="bold", size=14), legend.key=element_rect(fill="#ffffff")) +
  labs(title="Main characters time on screen per location", caption="@roortheroor, 2020", x="", y="")

capture <- tk_messageBox(message="")
























