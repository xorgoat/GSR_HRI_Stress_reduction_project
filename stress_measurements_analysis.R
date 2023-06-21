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

psq <- data.frame(values = c(robot_psq$Difference, laptop_psq$Difference),                      # Combine variables in data frame
                   group = c(rep("Robot", 19), rep("Laptop", 19)))

boxplot(psq$values~psq$group,
        main = "Differences Between Pre and Post \nRelax Condition;\nSubjective Measurement",
        ylab = "Condition",
        xlab = "Differences",
        col = c("seagreen1","#00F5FF"),
) 

gsr <- data.frame(values = c(robot_gsr$Difference, laptop_gsr$Difference),                      # Combine variables in data frame
                   group = c(rep("Robot", 19),
                             rep("Laptop", 19)))

boxplot(gsr$values~gsr$group,
        main = "Differences Between Relaxation \n and Stress GSR Averages",
        ylab = "Condition", xlab = "Differences",
        col = c("seagreen1","#00F5FF"),
)  



shapiro.test(robot_gsr$Difference)
shapiro.test(laptop_gsr$Difference)
wilcox.test(robot_gsr$Difference, laptop_gsr$Difference)

shapiro.test(robot_psq$Difference)
shapiro.test(laptop_psq$Difference)
wilcox.test(robot_psq$Difference, laptop_psq$Difference)
