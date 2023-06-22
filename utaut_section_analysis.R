library(tidyverse)
library(rstatix)
library(ggplot2)
library(ggpubr)
library(ggstatsplot)
library(reshape)

utaut<-read_csv('D:/Documents/S2Y3/Thesis/experiment/Data files/Utaut_subsection_score.csv')

subsections = c("Effort Expectancy","Performance Expectancy",
                "Perceived Enjoyment","Satisfaction","Trust",
                "Perceived Risk","Behavioral Intention")

df <- gather(utaut, key = "UTAUT_Sections", value = "Scores", subsections) 
head(df)

# plot
ggplot(data=df) + 
  geom_boxplot( aes(x=factor(UTAUT_Sections), y=Scores, fill=Condition), position=position_dodge(1))+
  xlab("UTAUT Sections") +
  labs(title = "                                 UTAUT Section Comparison between the Laptop and Robot Conditions")

#########
effort_r = utaut$`Effort Expectancy`[utaut$Condition == "Robot"]
effort_l = utaut$`Effort Expectancy`[utaut$Condition == "Laptop"]
performance_r = utaut$`Performance Expectancy`[utaut$Condition == "Robot"]
performance_l = utaut$`Performance Expectancy`[utaut$Condition == "Laptop"]
enjoyment_r = utaut$`Perceived Enjoyment`[utaut$Condition == "Robot"]
enjoyment_l = utaut$`Perceived Enjoyment`[utaut$Condition == "Laptop"]
satisfaction_r = utaut$`Satisfaction`[utaut$Condition == "Robot"]
satisfaction_l = utaut$`Satisfaction`[utaut$Condition == "Laptop"]
trust_r = utaut$`Trust`[utaut$Condition == "Robot"]
trust_l = utaut$`Trust`[utaut$Condition == "Laptop"]
risk_r = utaut$`Perceived Risk`[utaut$Condition == "Robot"]
risk_l = utaut$`Perceived Risk`[utaut$Condition == "Laptop"]
behavior_r = utaut$`Behavioral Intention`[utaut$Condition == "Robot"]
behavior_l = utaut$`Behavioral Intention`[utaut$Condition == "Laptop"]
#########

shapiro.test(effort_r)
shapiro.test(effort_l)
shapiro.test(performance_r)
shapiro.test(performance_l)
shapiro.test(enjoyment_r)
shapiro.test(enjoyment_l)
shapiro.test(satisfaction_r)
shapiro.test(satisfaction_l)
shapiro.test(trust_r)
shapiro.test(trust_l)
shapiro.test(risk_r)
shapiro.test(risk_l)
shapiro.test(behavior_r)
shapiro.test(behavior_l)

wilcox.test(effort_r,effort_l)
t.test(effort_r,effort_l)
wilcox.test(performance_r,performance_l)
wilcox.test(enjoyment_r,enjoyment_l)
wilcox.test(satisfaction_r,satisfaction_l)
wilcox.test(trust_r,trust_l)
wilcox.test(risk_r,risk_l)
wilcox.test(behavior_r, behavior_l)   #significant
t.test(behavior_r, behavior_l)        #significant
