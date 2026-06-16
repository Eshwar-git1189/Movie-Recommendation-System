#Perform Linear Regression to predict movie ratings.

reg_model <- lm(rating ~ userId + movieId, data = movie_data)

#View the regression results:
  
summary(reg_model)

#To obtain predicted ratings:
  
predicted_rating <- predict(reg_model)

head(predicted_rating)

#This completes the Regression section.

#Now evaluate the regression model using the performance measures required in Unit V.

pred <- predict(reg_model)
actual <- movie_data$rating
#MAE
MAE <- mean(abs(actual - pred))
MAE
#MSE
MSE <- mean((actual - pred)^2)
MSE
#RMSE
RMSE <- sqrt(MSE)
RMSE
#R²
summary(reg_model)$r.squared

#These correspond directly to:
  
# Predictive Performance Estimation
# Predictive Performance Measures
# MAE
# MSE
# RMSE
# R²