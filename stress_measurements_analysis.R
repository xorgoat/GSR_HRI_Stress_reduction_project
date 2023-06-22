library(tidyverse)
library(rstatix)
library(ggplot2)
library(ggpubr)
library(ggstatsplot)

robot_gsr<-read_csv('D:/Documents/S2Y3/Thesis/experiment/Data files/DIFF Robot Conductance Total Avg.csv')
laptop_gsr<-read_csv('D:/Documents/S2Y3/Thesis/experiment/Data files/DIFF Laptop Conductance Total Avg.csv')

robot_psq<-read_csv('D:/Documents/S2Y3/Thesis/experiment/Data files/data/robot_psq_score.csv')
laptop_psq<-read_csv('D:/Documents/S2Y3/Thesis/experiment/Data files/data/laptop_psq_score.csv')

robot_psq$Difference = robot_psq$Post - robot_psq$Pre
laptop_psq$Difference = laptop_psq$Post - laptop_psq$Pre


### Graphs ###

gsr <- data.frame(values = c(robot_gsr$Difference, laptop_gsr$Difference),                      # Combine variables in data frame
                   group = c(rep("Robot", 19), rep("Laptop", 19)))

boxplot(gsr$values~gsr$group,
        main = "Differences Between Relaxation\nand Stress GSR Averages",
        xlab = "Condition", ylab = "Differences",
        col = c("#f8766d","#00bfc4"),
)  

psq <- data.frame(values = c(robot_psq$Difference, laptop_psq$Difference),                      # Combine variables in data frame
                  group = c(rep("Robot", 19), rep("Laptop", 19)))

boxplot(psq$values~psq$group,
        main = "Differences Between Relaxation\nand Stress PSQ Averages",
        ylab = "Differences",
        xlab = "Condition",
        col = c("#f8766d","#00bfc4"),
) 


### Tests ###

shapiro.test(robot_gsr$Difference)
shapiro.test(laptop_gsr$Difference)
wilcox.test(robot_gsr$Difference, laptop_gsr$Difference)

shapiro.test(robot_psq$Difference)
shapiro.test(laptop_psq$Difference)
wilcox.test(robot_psq$Difference, laptop_psq$Difference)
