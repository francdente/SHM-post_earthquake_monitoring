library(mbreaks)
library(dplyr)
library(zoo)
library(tidyr)
library(ggplot2)

CONFIG <- list(
  path = "../data/full_dataset.csv",
  target = "Mean_freq",
  covariates = c("Temp", "Wind", "Pressure", "Humidity", "Rainfall_rolling_mean", "Temp_rolling_mean")
)

df <- read.csv(CONFIG$path, check.names = FALSE)
df$Date <- as.POSIXct(df[[1]], format="%Y-%m-%d %H:%M:%S", tz="UTC")

df <- df[, -1]
print(nrow(df))
df <- df %>%
  mutate(
    Temp_shifted = lag(Temp, 2),
    Humidity_shifted = lag(Humidity, 13),
    Rainfall_shifted = lag(Rainfall, 106),
    Rainfall_rolling_mean = rollmean(Rainfall, 450, fill = NA, align = "right") + rnorm(n(), mean = 0, sd = 0.0001),
    Temp_rolling_mean = rollmean(Temp, 150, fill = NA, align = "right")
  )


df <- df %>% drop_na()

print(nrow(df))


resultsSEQUA <- dosequa(
  y_name = CONFIG$target,
  z_name = c("Temp_shifted", "Wind", "Pressure", "Humidity_shifted", "Rainfall_rolling_mean", "Temp_rolling_mean"),
  data = df,
  eps1 = 0.05,  # Trimming (minimum segment length)
  m = 10,
  signif = 4,
  robust = 1,
)

resultsSEQUA

plot_model(resultsSEQUA, CI = 0.95, title = NULL)

head(output_df)


