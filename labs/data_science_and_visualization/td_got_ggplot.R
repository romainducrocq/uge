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

#####EX4
cat("--------------------------------------------------------------------------\n")
cat("EX4\n\n")

cat("\n4.1/ Create a jstime table containing for each episode Jon Snow’s screen time and then reproduce this graph : \n")
jstime = appearances %>%
  filter(name == "Jon Snow") %>%
  left_join(scenes) %>%
  group_by(episodeId) %>%
  summarise(time = sum(duration))

X11()
ggplot(jstime) + 
  geom_line(aes(x=episodeId, y=time)) + 
  theme_bw() +
  xlab("épisode") +
  ylab("temps") + 
  ggtitle("Temps de présence par épisode de John Snow")

cat("\n4.2/ Try other geom’s : area, bars. Compare and comment. \n")
deaths = scenes %>%
  select(nbdeath, duration, location, episodeId) %>%
  mutate(t = cumsum(duration), tdeath = cumsum(nbdeath))

season_t = episodes %>%
  mutate(ld = lag(total_duration)) %>%
  mutate(ld = if_else(is.na(ld), 0, ld), td = cumsum(ld)) %>%
  filter(episodeNum == 1) %>%
  pull(td)

X11()
ggplot(deaths) + 
  geom_line(aes(x = t / 3600, y = tdeath)) + 
  scale_x_continuous("", expand = c(0, 0), breaks = season_t / 3600, labels = paste("Saison", 1:8), ) +
  scale_y_continuous("Nombre de morts cumulés", expand=c(0, 0)) + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90)) + 
  ggtitle("Evolution du nombre de mort au cours du temps")

cat("\n4.4/ Build a data.frame containing for each episode its title, the season, the length of the longest scene, the number of scenes and the number of deaths. Then make a scater plot of the variables number of scenes and longest scene duration. \n")
scenes_stats = scenes %>%
  left_join(episodes) %>%
  group_by(episodeTitle, seasonNum) %>%
  summarise(nb_scenes = n(), duration_max = max(duration), nbdeath = sum(nbdeath))

X11()
ggplot(scenes_stats, aes(x = nb_scenes, y = duration_max)) +
  geom_point()

cat("\n4.5/ Finally, use the color and size of the dots to encode information about the seasons and the number of dead and finalize the graph that might look like this version by setting the scales and adding a few labels. \n")
labels = scenes_stats %>%
  filter(duration_max > 400 | nb_scenes > 200)

X11()
ggplot(scenes_stats, aes(x = nb_scenes, y = duration_max, col = factor(seasonNum))) +
  geom_point(aes(size = nbdeath)) +
  geom_text(data = labels, aes(label = episodeTitle), vjust = -0.6) + 
  scale_x_continuous("Nombre de scènes", limits = c(0, 280)) +
  scale_y_continuous("Durée de la scène la plus longue", limits = c(100, 800)) +
  scale_color_brewer("Saison", palette = "Spectral") +
  guides(colour = "legend", size = "legend") + 
  theme_bw()

cat("\n4.6/ Make a series of box plots to represent the distributions of scene durations by episode. \n")
X11()
ggplot(scenes %>% left_join(episodes)) +
  geom_boxplot(aes(x = factor(episodeId), y = duration))

cat("\n4.7/ Finalize the figure, you can be inspired by the following result: \n")
labels = scenes %>%
  filter(duration > 400)

X11()
ggplot(scenes %>% left_join(episodes)) + 
  geom_boxplot(aes(x = factor(episodeId), y = duration, fill = seasonNum)) + 
  geom_text(data = labels, aes(x = factor(episodeId), y = duration, label = subLocation), hjust = "right", vjust = "top") + 
  xlab("N° épisode") + 
  ylab("Durée des scènes (min)") + 
  ggtitle("Répartition des durées des scènes par épisodes") + 
  theme_bw()

cat("\n4.8/Build a table containing for each character and each season the time its screen time. Filter this table to keep only the characters that appear for more than one hour over the seasons. Reorder the levels of the name factor so that the levels are sorted in ascending order of appearance time.
Make a stacked bar-plot of this data identical to the following figure. Use color-brewer to find the palette used. \n")
screenTimePerSeasons = appearances %>%
  left_join(scenes) %>%
  left_join(episodes) %>%
  group_by(name, seasonNum) %>%
  summarise(screenTime = sum(duration)) %>%
  arrange(desc(screenTime))

screenTimeTotal = screenTimePerSeasons %>%
  group_by(name) %>%
  summarise(screenTimeTotal = sum(screenTime))

mainCharacters = screenTimeTotal %>%
  filter(screenTimeTotal > 60*60) %>%
  arrange(screenTimeTotal) %>%
  mutate(nameF = factor(name, levels = name))

data = screenTimePerSeasons %>%
  left_join(mainCharacters) %>%
  filter(!is.na(nameF))

data

X11()
ggplot(data) +
  geom_bar(aes(y = nameF, x = screenTime / 60, fill = factor(seasonNum, level = 8:1)), stat = "identity") + 
  scale_fill_brewer("Saison", palette = "Spectral") + 
  theme_bw() +
  geom_text(data = mainCharacters, aes(y = nameF, x = screenTimeTotal / 60 + 5, label = paste(round(screenTimeTotal / 60), 'min')), hjust = "left") +
  scale_x_continuous("Temps d'apparition (min)", breaks = seq(0, 750, by = 120), limits = c(0, 780), expand = c(0, 1)) + 
  ylab("") +
  ggtitle("Temps d'apparition cumulé par personnage et saison")

capture <- tk_messageBox(message="")
