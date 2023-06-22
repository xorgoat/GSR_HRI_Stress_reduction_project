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
  ggtitle("UTAUT Section Comparison between the Laptop and Robot Conditions")


utaut$`Effort Expectancy`[utaut$Condition == "Robot"]
