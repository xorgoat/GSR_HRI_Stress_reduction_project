
library(tidyverse)
library(rstatix)
library(ggplot2)
library(ggpubr)
library(ggstatsplot)

robot<-read_csv('D:/Documents/S2Y3/Thesis/experiment/code_folder/robot_ati_utaut_scores.csv')
laptop<-read_csv('D:/Documents/S2Y3/Thesis/experiment/code_folder/laptop_ati_utaut_scores.csv')

shapiro.test(robot$score_ati)
shapiro.test(laptop$score_ati)

shapiro.test(robot$score_utaut)
shapiro.test(laptop$score_utaut)


outliers_l <- boxplot(laptop$score_utaut, plot=FALSE)$out
y<-laptop
laptop_cleaned<- y[-which(y$score_utaut %in% outliers_l),]

shapiro.test(laptop_cleaned$score_utaut)


robot_cor <- cor.test(robot$score_ati, robot$score_utaut, 
                      method = "pearson")
laptop_cor<- cor.test(laptop_cleaned$score_ati, laptop_cleaned$score_utaut, 
                      method = "pearson")

robot_cor
laptop_cor

ggscatter(robot, x = "score_ati", y = "score_utaut", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          ylab = "utaut", xlab = "ati")

ggscatter(laptop_cleaned, x = "score_ati", y = "score_utaut", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          ylab = "utaut", xlab = "ati")


mean(robot$score_ati)
sd(robot$score_ati)
mean(laptop$score_ati)
sd(laptop$score_ati)


data <- data.frame(values = c(robot$score_ati, laptop$score_ati),                      
                   group = c(rep("Robot"),
                             rep("Laptop")))

boxplot(data$values~data$group,
        main = "ati",
        ylab = "Condition", xlab = "Scores",
        col = c("seagreen1","#00F5FF"),
        horizontal = TRUE
)