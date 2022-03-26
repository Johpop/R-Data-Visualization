library(gganimate)
library(ggplot2)
library(tidyr)
library(dplyr)
library(ggthemes)
library(extrafont)
library(gifski)
library(scales)


options(scipen=5)




car_pop <- read.csv("C:/Users/tyj61/Desktop/Ryde/annual-car-population-by-cc.csv")
car_pop$cc_rating_size = ifelse(car_pop$cc_rating == '1000cc and below', 5,
                                ifelse(car_pop$cc_rating == '1001-1600cc', 14,
                                       ifelse(car_pop$cc_rating == '1601-2000cc', 11,
                                              ifelse(car_pop$cc_rating == '2001-3000cc', 9, 6))))
head(car_pop)


graph_bad = car_pop %>%
  ggplot(aes(x=year, y=number, color=cc_rating)) +
  geom_point()

graph_bad


#plot_cols <- c('1000cc and below' = 'Yellow',
#               '1001-1600cc'= 'green',
#               '1601-2000cc' = 'blue',
#              '2001-3000cc' = 'yellow',
#               '3001cc and above' = 'purple')

graph1 = car_pop %>%
  ggplot(aes(x=year, y=number, color=cc_rating)) + 
  geom_point(size = car_pop$cc_rating_size, stroke = 0, alpha=0.5) +
  scale_y_continuous(label=comma) +
  scale_x_continuous(labels=label_number(accuracy=1)) +
  labs(title = "Singapore's vehicle population from 2005 to 2018",
       subtitle = "by CC Rating",
       x = 'Year',
       y = 'No. of Cars',
       color = 'CC Rating') + 
  theme_fivethirtyeight() +
  theme(axis.title = element_text(size=20), legend.text=element_text(size=12.5)) +
  scale_color_brewer(palette = "Dark2") +
  guides(colour = guide_legend(override.aes = list(size=10)))
  

graph1

graph1.animation = graph1 +
  transition_time(year) +
  labs(subtitle = "Year: {frame_time}")

animate(graph1.animation, height = 500, width = 800, fps=30, duration = 10, end_pause = 60)

anim_save('ryde_presentation.gif')
