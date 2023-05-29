
library(tidyverse)
library(effectsize)
library(rstatix)
library(ggplot2)
library(ggpubr)
library(ggstatsplot)

robot<-read_csv('D:/Documents/S2Y3/Thesis/experiment/code_folder/robot_psq_score.csv')
laptop<-read_csv('D:/Documents/S2Y3/Thesis/experiment/code_folder/laptop_psq_score.csv')

robot$Difference = robot$Post - robot$Pre
laptop$Difference = laptop$Post - laptop$Pre

shapiro.test(robot$Difference)
shapiro.test(laptop$Difference)

outliers_r <- boxplot(robot$Difference, plot=FALSE)$out
x<-robot
robot_cleaned<- x[-which(x$Difference %in% outliers_r),]

shapiro.test(robot_cleaned$Difference)
shapiro.test(laptop$Difference)

t.test(robot_cleaned$Difference, laptop$Difference)

hedges_g(robot_cleaned$Difference, laptop$Difference)


mean(robot_cleaned$Difference)
sd(robot_cleaned$Difference)
mean(laptop$Difference)
sd(laptop$Difference)

data <- data.frame(values = c(robot$Difference, laptop$Difference),                      # Combine variables in data frame
                   group = c(rep("Robot"),
                             rep("Laptop")))

boxplot(data$values~data$group,
        main = "Differences Between Pre \n and Post Stress Management\n PSQ Scores",
        ylab = "Condition", xlab = "Differences",
        col = c("seagreen1","#00F5FF"),
        horizontal = TRUE
) 
