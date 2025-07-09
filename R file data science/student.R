# Install necessary packages
install.packages("metan")
install.packages("AgroR")
install.packages("ggplot2")
install.packages("tidyverse")
install.packages("dplyr")

library(AgroR)
library(ggplot2)

mydata <- read.csv("C:/Users/HP/Downloads/student/Student Depression Dataset.csv", header = TRUE, sep = ",")
View(mydata)
str(mydata)


mydata <- na.omit(mydata)



attach(mydata)
plot_cor(CGPA, Work.Pressure,  
         method = "pearson",
         ylab = "Work Pressure",
         xlab = "CGPA",
         theme = theme_classic(),
         pointsize = 2,
         shape = 20,
         fill = "black",
         color = "red",
         axis.size = 12,
         ic = TRUE,
         title = "Correlation Using Pearson")


plot_cor(CGPA, Work.Pressure,  
         method = "spearman",
         ylab = "Work Pressure",
         xlab = "CGPA",
         theme = theme_classic(),
         pointsize = 2,
         shape = 20,
         fill = "black",
         color = "red",
         axis.size = 12,
         ic = TRUE,
         title = "Correlation Using Spearman")


aov_result <- aov(Depression ~ Gender, data = mydata)  
summary(aov_result)


unique(mydata$Family.History.of.Mental.Illness)
mydata$Family.History.of.Mental.Illness <- factor(mydata$Family.History.of.Mental.Illness, levels = c("Yes", "No"))

str(mydata$Family.History.of.Mental.Illness)

chisq_result <- chisq.test(table(mydata$Depression, mydata$Family.History.of.Mental.Illness))
chisq_result

colnames(mydata)
str(mydata)
