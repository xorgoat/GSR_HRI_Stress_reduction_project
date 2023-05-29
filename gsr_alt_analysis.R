
library(tidyverse)
library(effectsize)
library(rstatix)
library(ggplot2)
library(ggpubr)
library(ggstatsplot)

robot<-read_csv('D:/Documents/S2Y3/Thesis/experiment/code_folder/DIFF Robot Conductance Total Avg.csv')
laptop<-read_csv('D:/Documents/S2Y3/Thesis/experiment/code_folder/DIFF Laptop Conductance Total Avg.csv')

shapiro.test(robot$Difference)
shapiro.test(laptop$Difference)


outliers_r <- boxplot(robot$Difference, plot=FALSE)$out
x<-robot
robot_cleaned<- x[-which(x$Difference %in% outliers_r),]

outliers_l <- boxplot(laptop$Difference, plot=FALSE)$out
y<-laptop
laptop_cleaned<- y[-which(y$Difference %in% outliers_l),]


shapiro.test(robot_cleaned$Difference)
shapiro.test(laptop_cleaned$Difference)


t.test(robot_cleaned$Difference, laptop_cleaned$Difference)

hedges_g(robot_cleaned$Difference, laptop_cleaned$Difference)


mean(robot_cleaned$Difference)
sd(robot_cleaned$Difference)
mean(laptop_cleaned$Difference)
sd(laptop_cleaned$Difference)

data <- data.frame(values = c(robot$Difference, laptop$Difference),                      # Combine variables in data frame
                   group = c(rep("Robot"),
                             rep("Laptop")))

boxplot(data$values~data$group,
        main = "Differences Between Relaxation \n and Stress GSR Averages",
        ylab = "Condition", xlab = "Differences",
        col = c("seagreen1","#00F5FF"),
        horizontal = TRUE
) 
