#!/usr/bin/Rscript

library(readr)
library(dplyr)
library(tidyr)
library(tcltk)
library(ggplot2)

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

#####EX2
cat("--------------------------------------------------------------------------\n")
cat("EX2\n\n")

cat("\n2.1/ number of dead characters in the whole series:\n")
sum(scenes$nbdeath)


cat("\n2.2/ number of dead characters in s1:\n")
sum(scenes$nbdeath[(scenes$episodeId <= sum(episodes$seasonNum == 1))])
sum(scenes$nbdeath[scenes$episodeId %in% episodes$episodeId[which(episodes$seasonNum == 1)]])

cat("\n2.3/ 5 biggest murderers:\n")
sort(table(characters$killedBy), TRUE)[1:5]

cat("\n2.4/ length of the longest scene and the id of the episode:\n")
scenes[which.max(scenes$duration),]

#####EX3
cat("--------------------------------------------------------------------------\n")
cat("EX3\n\n")

cat("\n3.1/ longest scene duration and episode id with dplyr:\n")
scenes %>%
  arrange(desc(duration)) %>%
  head(1) %>%
  select(duration, episodeId)

cat("\n3.2/ characters in the longest scene\n")
scenes %>%
  arrange(desc(duration)) %>%
  head(1) %>%
  left_join(appearances, by=c("sceneId")) %>%
  select(name)

cat("\n3.3/ most visited place:\n")
scenes %>%
  group_by(location) %>%
  summarise(nbscenes = n()) %>%
  arrange(desc(nbscenes)) %>%
  head(1) %>%
  select(location)

cat("\n3.4/  How many scenes take place in King's Landing ?\n")
scenes %>%
  filter(location == "King's Landing") %>%
  group_by(location) %>%
  summarise(nbscenes = n())

cat("\n3.5/ Find the precise location (subLocation) where the most people die? :\n")
scenes %>%
  group_by(subLocation) %>%
  summarise(nd = sum(nbdeath)) %>%
  arrange(desc(nd))

cat("\n3.6/ Find the episode where Jon Snow has the longuest screen time. :\n")
appearances %>%
  filter(name == "Jon Snow") %>%
  left_join(scenes) %>%
  left_join(episodes) %>%
  group_by(name, episodeId, episodeTitle) %>%
  summarise(screenTime = sum(duration)) %>%
  arrange(desc(screenTime)) %>%
  head(1)

cat("\n3.7/  how many characters do have more than 30 minutes of screen time ? :\n")
appearances %>%
  left_join(scenes) %>%
  group_by(name) %>%
  summarise(screenTime = sum(duration)) %>%
  filter(screenTime>30*60) %>%
  nrow()

cat("\n3.8/ Which characters do have the more scenes together. :n")
appearances %>%
  left_join(appearances, by=c("sceneId"="sceneId")) %>%
  filter(name.x != name.y) %>%
  group_by(name.x, name.y) %>%
  summarise(nbscenes = n()) %>%
  arrange(desc(nbscenes))
  
cat("\n3.9/ Which two characters spend the most time together? :\n")
appearances %>%
  left_join(appearances, by=c("sceneId"="sceneId")) %>%
  filter(name.x != name.y) %>%
  left_join(scenes %>% select(sceneId, duration)) %>%
  group_by(name.x, name.y) %>%
  summarise(screenTime = sum(duration)) %>%
  arrange(desc(screenTime))

cat("\n3.10/ Build a data.frame with one line per character containing a name column and a column for each place with the duration of presence of each character. If a character has never been in a place the value is equal to 0. :")
df <- scenes %>%
  left_join(appearances) %>%
  group_by(name, location) %>%
  summarise(screenTime = sum(duration)) %>%
  pivot_wider(values_from=screenTime, names_from=location, values_fill=c("duration"=0))

df
  
cat("\n3.11/ Construct from the previous data.frame a matrix containing only the numerical variables. Filter it to keep only the lines whose sum is higher than 3600. Normalize it so that the sums in lines are equal to 1. Give the name of each character kept to the corresponding line in the matrix with the function rownames. :\n")
X <- as.matrix(df[,-1])
Xs <- X[rowSums(X)>3600,]
Xns <- Xs / rowSums(Xs)
rownames(Xns) <- df$name[rowSums(X)>3600]

Xns

cat("\n3.12/ Using the function `dist calculate the manhatan distance between each line of the previous matrix. Then perform a hierarchical clustering with this distance matrix and display the result. You should get a figure similar to the following one :\n")

hc <- hclust(dist(Xns, method="manhattan"))

X11()
plot(hc, main="Clustering of the main characters (geographical profiles)", sub="@roorthroor, 2020", xlab="")

capture <- tk_messageBox(message="")
