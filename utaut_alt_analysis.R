
library(tidyverse)
library(effectsize)
library(rstatix)
library(ggplot2)
library(ggpubr)
library(ggstatsplot)

robot<-read_csv('D:/Documents/S2Y3/Thesis/experiment/code_folder/Robot_utaut_score.csv')
laptop<-read_csv('D:/Documents/S2Y3/Thesis/experiment/code_folder/Laptop_utaut_score.csv')

shapiro.test(robot$Score)
shapiro.test(laptop$Score)

outliers_l <- boxplot(laptop$Score, plot=FALSE)$out
y<-laptop
laptop_cleaned<- y[-which(y$Score %in% outliers_l),]


shapiro.test(robot$Score)
shapiro.test(laptop_cleaned$Score)

t.test(robot$Score, laptop_cleaned$Score)

hedges_g(robot$Score, laptop_cleaned$Score)

mean(robot$Score)
sd(robot$Score)
mean(laptop_cleaned$Score)
sd(laptop_cleaned$Score)

data <- data.frame(values = c(robot$Score, laptop$Score),                      # Combine variables in data frame
                   group = c(rep("Robot"),
                             rep("Laptop")))

boxplot(data$values~data$group,
        main = "UTAUT Scores Separated by\nLaptop and Robot Conditions",
        ylab = "Condition", xlab = "Scores",
        col = c("seagreen1","#00F5FF"),
        horizontal = TRUE
)
