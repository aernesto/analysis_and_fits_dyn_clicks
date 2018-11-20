setwd("/home/adrian/clicks/analysis_and_fits_dyn_clicks/")
library(ggplot2)
fig4_data_raw <- read.csv(file="/home/adrian/programing/data/clicks/fig4_data.csv", header=TRUE, sep=",")
fig4_data <- subset(fig4_data_raw, method == "stoch")
fig4_data$model_pair = factor(
  fig4_data$model_pair, levels = c("linlin","linnonlin","nonlinlin","nonlinnonlin"),
  labels = c("L-L", "L-NL", "NL-L","NL-NL")
)

# the following will plot relative error
y_label <- "Relative Error"
gg <- ggplot(fig4_data,aes(x=trial_nb,y=error)) +
  geom_line(aes(col=model_pair),size=2) +
  geom_point(aes(col=model_pair), size=4) +
  labs(y=y_label, 
       x="Block Size (in trials)") +
  scale_colour_brewer(palette = "Set1") # change color palette

plot(gg+theme(text = element_text(size=30)))

# the following will plot absolute error
y_label <- "Absolute Error"
true_lin_gamma <- 6.7457
rows_to_scale <- fig4_data$model_pair == "L-L" | fig4_data$model_pair == "L-NL"
fig4_data[rows_to_scale,]$error <- fig4_data[rows_to_scale,]$error * true_lin_gamma^2  
gg2 <- ggplot(fig4_data,aes(x=trial_nb,y=error)) +
  geom_line(aes(col=model_pair),size=2) +
  geom_point(aes(col=model_pair), size=4) +
  labs(y=y_label, 
       x="Block Size (in trials)") +
  scale_colour_brewer(palette = "Set1") # change color palette

plot(gg2+theme(text = element_text(size=30)))