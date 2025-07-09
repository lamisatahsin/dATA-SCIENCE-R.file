install.packages('ggplot2')
install.packages("GGally")
mydata<- read.csv("D:/Download/AIUB-3.2/This/IDS/FINAL/CarPrice.csv",header = TRUE,sep = ",")
mydata 
View(mydata)
str(mydata)

total_missing<-sum(is.na(mydata))
total_missing

x<-mydata$carwidth
summary(x)
table(x)
mode_x <- as.numeric(names(sort(table(x), decreasing = TRUE)[1]))
mode_x
hist_data <- hist(x, plot = FALSE, breaks = 5) 
hist(x,main="Histogram of Carwidth",
     xlab="Carwidth",ylab="Frequency",
     xlim=c(60,75),ylim=c(0,100),
     col="pink",border="black")
mean_x <- mean(x)
sd_x <- sd(x)
x_range <- seq(min(x), max(x), length = 100)
density_curve <- density(x)
scaled_density <- density_curve$y * length(x) * diff(hist_data$breaks)[1]
lines(density_curve$x, scaled_density, col = "darkblue", lwd = 2)
lines(x_range, dnorm(x_range, mean = mean_x, sd = sd_x) * length(x) * diff(hist_data$breaks)[1],
      col = "red", lwd = 2, lty = 2) 
abline(v=mean(x),lwd=4,col="red")
abline(v=median(x),lwd=4,col="blue")
abline(v=mode_x,lwd=4,col="green")
legend("topright", legend = c("Mean", "Median", "Mode", "Histogram Density", "Normal Curve"),
       col = c("red", "blue", "green","darkblue", "red"), lwd = 2)


y <- mydata$carheight
summary(y)
table(y)

mode_y <- as.numeric(names(sort(table(y), decreasing = TRUE)[1]))
mode_y

hist_data <- hist(y, plot = FALSE, breaks = 5)
hist(y, main = "Histogram of Carheight",
     xlab = "Carheight", ylab = "Frequency",
     xlim = c(45, 60), ylim = c(0, 100),
     col = "pink", border = "black", breaks = 5)

mean_y <- mean(y)
sd_y <- sd(y)
nx_range <- seq(min(y), max(y), length = 100)
density_curve <- density(y)
scaled_density <- density_curve$y * length(y) * diff(hist_data$breaks)[1]
lines(density_curve$x, scaled_density, col = "darkblue", lwd = 2)

lines(nx_range, dnorm(nx_range, mean = mean_y, sd = sd_y) * length(y) * diff(hist_data$breaks)[1],
      col = "red", lwd = 2, lty = 2)
abline(v = mean(y), lwd = 4, col = "red")
abline(v = median(y), lwd = 4, col = "blue")
abline(v = mode_y, lwd = 4, col = "green")
legend("topright", legend = c("Mean", "Median", "Mode", "Density Curve", "Normal Curve"),
       col = c("red", "blue", "green", "darkblue", "red"), lwd = 2, lty = c(1, 1, 1, 1, 2))


library(ggplot2)
table(mydata$carbody)
ggplot(mydata, aes(x = carbody)) +
  geom_bar(fill = "lightblue", color = "black") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5) +  
  labs(title = "Bar Graph of Car Body", 
       x = "Car Body Type", 
       y = "Frequency") +
  theme_minimal()

library(ggplot2)
table(mydata$enginetype)
ggplot(mydata, aes(x = enginetype)) +
  geom_bar(fill = "lightblue", color = "black") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5) +  
  labs(title = "Bar Graph of EngineType", 
       x = "Engine Type", 
       y = "Frequency") +
  theme_minimal()

summary(mydata$enginesize)
ggplot(data = mydata, aes(x = "", y = enginesize)) +
  geom_boxplot(fill = "lightblue", color = "blue") +
  labs(title = "Boxplot of EngineSize",
       x = "", y = "Engine Size") +
  theme_minimal()

summary(mydata$enginesize)
ggplot(data = mydata, aes(x = "", y = enginesize)) +
  geom_boxplot(fill = "lightblue", color = "blue") +
  labs(title = "Boxplot of EngineSize",
       x = "", y = "Engine Size") +
  theme_minimal()
findoutliers <- boxplot.stats(mydata$enginesize)$out
findoutliers

summary(mydata$horsepower)
ggplot(data = mydata, aes(x = "", y = horsepower)) +
  geom_boxplot(fill = "lightblue", color = "blue") +
  labs(title = "Boxplot of Horsepower",
       x = "", y = "Horsepower") +
  theme_minimal()
findoutliers <- boxplot.stats(mydata$horsepower)$out
findoutliers

install.packages("ggplot2")
install.packages("GGally")

library(ggplot2)
library(GGally)
plot_list <- list() 
variables <- c("wheelbase", 
               "carlength", 
               "carwidth", 
               "carheight") 

for (var in variables){
  plot_list[[var]] <- ggplot(mydata, aes_string(x = "price", y = var)) + 
    geom_point() + 
    geom_smooth(method = "lm", se = FALSE, color = "red") + 
    labs(title = paste(var, "vs Price"), x = "Price", y = var) + 
    theme_minimal()
}

for (i in 1:length(plot_list)) {
  print(plot_list[[i]])
}

mydata$price_cat <- cut(mydata$price, 
                        breaks = 4, 
                        labels = c("Low", "Medium", "High", "Very High"))

library(GGally)
library(ggplot2)

mydata$price_cat <- cut(mydata$price, 
                        breaks = 3, 
                        labels = c("Low", "Medium", "High"))

selected_vars <- c("wheelbase", "carlength", "carwidth", "carheight")
category_colors <- c("Low" = "blue", "Medium" = "orange", "High" = "red")

ggpairs(mydata[, selected_vars], 
        aes(color = mydata$price_cat), 
        lower = list(continuous = wrap("points", size = 2)),  
        upper = list(continuous = wrap("points", size = 2)), 
        diag = list(continuous = "blankDiag")) + 
  scale_color_manual(values = category_colors) + 
  labs(title = "Scatter Plot with Low, Medium, High Price",
       color = "Category") +
  theme_minimal() 



class(mydata$carbody)
unique(mydata$carbody)
mydata$carbody<-factor(mydata$carbody,levels=c("convertible","hatchback","sedan", "wagon","hardtop"))
str(mydata$carbody)


library(ggplot2)

ggplot(mydata, aes(x = carbody, y = carwidth, fill = carbody)) + 
  geom_violin(trim = FALSE, size = 1.5, alpha = 0.7) + 
  geom_boxplot(width = 0.1, outlier.shape = NA, color = "black", size = 0.5) + 
  stat_summary(fun = median, geom = "point", size = 2, color = "red") + 
  theme_minimal() +
  labs(title = "Violin Plot",
       x = "Car Body Type",
       y = "Car Width") +
  scale_fill_brewer(palette = "Set3") 

mydata$price_cat <- cut(mydata$price, 
                        breaks = 3, 
                        labels = c("Low", "Medium", "High"))
library(ggplot2)

ggplot(mydata, aes(x = price_cat, y = horsepower, fill = price_cat)) + 
  geom_violin(trim = FALSE, size = 1.5, alpha = 0.7) + 
  geom_boxplot(width = 0.1, outlier.shape = NA, color = "black", size = 0.5) + 
  stat_summary(fun = median, geom = "point", size = 2, color = "red") + 
  theme_minimal() +
  labs(title = "Violin Plot",
       x = "Price",
       y = "Horsepower") +
  scale_fill_brewer(palette = "Set3") 
