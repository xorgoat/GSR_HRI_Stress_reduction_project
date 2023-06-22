
library(tidyverse)
library(rstatix)
library(ggplot2)
library(ggpubr)
library(ggstatsplot)

robot<-read_csv('D:/Documents/S2Y3/Thesis/experiment/Data Files/Robot_ati_score.csv')
laptop<-read_csv('D:/Documents/S2Y3/Thesis/experiment/Data Files/Laptop_ati_score.csv')

names(robot) = c('participant', 'Score')
names(laptop) = c('participant', 'Score')

shapiro.test(robot$Score)
shapiro.test(laptop$Score)

t.test(robot$Score,laptop$Score)


data <- data.frame(values = c(robot$Score, laptop$Score),                      
                   group = c(rep("Robot"),
                             rep("Laptop")))

boxplot(data$values~data$group,
        main = "ATI Scores per Condition",
        xlab = "Condition", ylab = "ATI Scores",
        col = c("#f8766d","#00bfc4"),
)

#mean(robot$score_ati)
#sd(robot$score_ati)
#mean(laptop$score_ati)
#sd(laptop$score_ati)

#ati_scores <- rbind.data.frame(
#  data.frame(participant = robot$participant, score = robot$Score,
#             Condition = "Robot"),
#  data.frame(participant = laptop$participant, score = laptop$Score, 
#             Condition = "Laptop")
#)
