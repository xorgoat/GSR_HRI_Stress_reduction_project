library(tidyverse)
library(rstatix)
library(ggplot2)
library(ggpubr)
library(ggstatsplot)

robot_utaut<-read_csv('D:/Documents/S2Y3/Thesis/experiment/Data files/Robot_utaut_score.csv')
laptop_utaut<-read_csv('D:/Documents/S2Y3/Thesis/experiment/Data files/Laptop_utaut_score.csv')

robot_gsr<-read_csv('D:/Documents/S2Y3/Thesis/experiment/Data files/DIFF Robot Conductance Total Avg.csv')
laptop_gsr<-read_csv('D:/Documents/S2Y3/Thesis/experiment/Data files/DIFF Laptop Conductance Total Avg.csv')

robot_psq<-read_csv('D:/Documents/S2Y3/Thesis/experiment/Data files/data/robot_psq_score.csv')
laptop_psq<-read_csv('D:/Documents/S2Y3/Thesis/experiment/Data files/data/laptop_psq_score.csv')

names(robot_utaut) = c('participant', 'Score')
names(laptop_utaut) = c('participant', 'Score')

names(robot_gsr) = c('participant', 'Difference')
names(laptop_gsr) = c('participant', 'Difference')

names(robot_psq) = c('','participant', 'Pre', 'Post')
names(laptop_psq) = c('','participant', 'Pre', 'Post')

robot_psq$Difference = robot_psq$Post - robot_psq$Pre
laptop_psq$Difference = laptop_psq$Post - laptop_psq$Pre

r_psq <- robot_psq[ , c("participant", "Difference")]
l_psq <- laptop_psq[ , c("participant", "Difference")]

### Tests ###

shapiro.test(robot_utaut$Score)
shapiro.test(laptop_utaut$Score)

shapiro.test(robot_gsr$Difference)
shapiro.test(laptop_gsr$Difference)

shapiro.test(r_psq$Difference)
shapiro.test(l_psq$Difference)

### Correlation ###

robot_cor_ug <- cor.test(robot_utaut$Score, robot_gsr$Difference, 
                      method = "spearman")
laptop_cor_ug <- cor.test(laptop_utaut$Score, laptop_gsr$Difference, 
                      method = "spearman")
robot_cor_up <- cor.test(robot_utaut$Score, r_psq$Difference, 
                         method = "spearman")
laptop_cor_up <- cor.test(laptop_utaut$Score, l_psq$Difference, 
                          method = "spearman")

robot_cor_ug
laptop_cor_ug
robot_cor_up
laptop_cor_up


robot_ug <- merge(x = robot_utaut, y = robot_gsr, by = "participant")
laptop_ug <- merge(x = laptop_utaut, y = laptop_gsr, by = "participant")
robot_up <- merge(x = robot_utaut, y = r_psq, by = "participant")
laptop_up <- merge(x = laptop_utaut, y = l_psq, by = "participant")


### Graphs ###

ug <- rbind.data.frame(
  data.frame(participant = robot_ug$participant, score = robot_ug$Score, 
             diff = robot_ug$Difference, Condition = "Robot"),
  data.frame(participant = laptop_ug$participant, score = laptop_ug$Score, 
             diff = laptop_ug$Difference, Condition = "Laptop")
)

ggplot(ug, aes(score, diff, color = Condition, fill = Condition)) +
  geom_point() +
  geom_smooth(method = "lm") +
  stat_cor(method = "spearman") +
  scale_color_manual(values = c(Laptop = "#f8766d", Robot = "#00bfc4"), aesthetics = c("color", "fill")) +
  labs(title = "Correlation between Summed UTAUT Scores and GSR Measurement Differences",
       x = "UTAUT Scores", y = "GSR Differences")


up <- rbind.data.frame(
  data.frame(participant = robot_up$participant, score = robot_ug$Score, 
             diff = robot_up$Difference, Condition = "Robot"),
  data.frame(participant = laptop_up$participant, score = laptop_up$Score, 
             diff = laptop_up$Difference, Condition = "Laptop")
)

ggplot(up, aes(score, diff, color = Condition, fill = Condition)) +
  geom_point() +
  geom_smooth(method = "lm") +
  stat_cor(method = "spearman") +
  scale_color_manual(values = c(Laptop = "#f8766d", Robot = "#00bfc4"), aesthetics = c("color", "fill")) +
  labs(title = "Correlation between Summed UTAUT Scores and PSQ Score Differences",
       x = "UTAUT Scores", y = "PSQ Differences") 


### Separated Graphs ###

ggscatter(data = robot_ug, x = "Score", y = "Difference",
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "spearman",
          ylab = "GSR Differences", xlab = "UTAUT Scores",
          main = "Robot", color = '#00bfc4')

ggscatter(data = robot_up, x = "Score", y = "Difference",
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "spearman",
          ylab = "PSQ Differences", xlab = "UTAUT Scores",
          main = "Robot", color = '#00bfc4')

ggscatter(data = laptop_ug, x = "Score", y = "Difference",
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "speaman",
          ylab = "GSR Differences", xlab = "UTAUT Scores",
          main = "Laptop", color = '#f8766d')

ggscatter(data = laptop_up, x = "Score", y = "Difference",
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "spearman",
          ylab = "PSQ Differences", xlab = "UTAUT Scores",
          main = "Laptop", color = '#f8766d')
