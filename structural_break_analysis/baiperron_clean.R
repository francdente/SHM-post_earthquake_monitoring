#install.packages("mbreaks")
library(mbreaks)

TCN_path = "../transformed_data/TCN_last_layer.csv"
CONFIG <- list(
  path = TCN_path,
  target = "scaled_target"
)

df <- read.csv(CONFIG$path, header = TRUE)

# Define dependent and independent variables
y_name <- CONFIG$target  # Dependent variable
z_name <- colnames(df)[!colnames(df) %in% "scaled_target"]

resultsSEQUA = dosequa(
  y_name = y_name,
  z_name = z_name,
  data = df,
  eps1 = 0.05,  # Trimming (minimum segment length)
  m = 10,
  signif = 4,
)

plot_model(resultsSEQUA, CI = 0.95, title = NULL)

print(resultsSEQUA)

fitted_values <- resultsSEQUA$fitted.values  # Extract fitted values
output_df <- data.frame(
  Index = 1:nrow(df),  # Adding an index column
  Scaled_Target = df[[y_name]],  # Actual values
  Fitted_Values = fitted_values  # Estimated values
)

write.csv(output_df, "fitted_values.csv", row.names = FALSE)
head(output_df)

#earthquake
eq_indx = 8889

df_aftereq <- df[eq_indx:nrow(df),]

resultsSEQUA_aftereq = dosequa(
  y_name = y_name,
  z_name = z_name,
  data = df_aftereq,
  eps1 = 0.05,  # Trimming (minimum segment length)
  m = 10,
  signif = 4,
)

plot_model(resultsSEQUA_aftereq, CI = 0.95, title = NULL)

print(resultsSEQUA_aftereq)

fitted_values <- resultsSEQUA_aftereq$fitted.values  # Extract fitted values
output_df <- data.frame(
  Index = 1:nrow(df_aftereq),  # Adding an index column
  Scaled_Target = df_aftereq[[y_name]],  # Actual values
  Fitted_Values = fitted_values  # Estimated values
)

#write.csv(output_df, "fitted_values_after.csv", row.names = FALSE)
head(output_df)

#doprintplot(resultsSEQUA_aftereq, df_aftereq)

### now test recovering
# last piece before the earthquake vs last part of the timeseries

recovery_indx <- resultsSEQUA_aftereq$date[nrow(resultsSEQUA_aftereq$date)]+eq_indx

start_last_normal <- resultsSEQUA$date[3]
end_last_normal <- resultsSEQUA$date[4]

end_df <- df[recovery_indx:nrow(df),]
norm_df <- df[start_last_normal,end_last_normal]

df_recovery <- rbind(norm_df,end_df)

resultsSEQUA_RECOVERY = dosequa(
  y_name = y_name,
  z_name = z_name,
  data = df_recovery,
  eps1 = 0.05,  # Trimming (minimum segment length)
  m = 10,
  signif=4
)

print(resultsSEQUA_RECOVERY, df_recovery)

#resultsSEQUA_RECOVERY_MDL = mdl(
#  y_name = y_name,
#  z_name = z_name,
#  data = df_recovery,
#  eps1 = 0.05,  # Trimming (minimum segment length)
#)

#plot_model(resultsSEQUA_RECOVERY_MDL)


