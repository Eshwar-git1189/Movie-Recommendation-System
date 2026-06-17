# Regression Analysis using Genre Features

# Load the dataset with genre columns
load("data/movie_data_with_genres.RData")

# Define genre columns
genre_list <- c("Action", "Adventure", "Animation", "Children", "Comedy",
                "Crime", "Documentary", "Drama", "Fantasy", "Film.Noir",
                "Horror", "Musical", "Mystery", "Romance", "Sci.Fi",
                "Thriller", "War", "Western")

# Build regression formula: rating ~ all genre indicators
genre_formula <- as.formula(paste("rating ~", paste(genre_list, collapse = " + ")))

# Perform Linear Regression
reg_model <- lm(genre_formula, data = movie_data)

# View regression results
summary(reg_model)

# --- Predictive Performance Measures ---

# Predict ratings
pred <- predict(reg_model)
actual <- movie_data$rating

# Mean Absolute Error (MAE)
MAE <- mean(abs(actual - pred))
MAE

# Mean Squared Error (MSE)
MSE <- mean((actual - pred)^2)
MSE

# Root Mean Squared Error (RMSE)
RMSE <- sqrt(MSE)
RMSE

# R-squared
R2 <- summary(reg_model)$r.squared
R2

# --- Residual Diagnostics ---

# Residual Plot
png("outputs/plots/residual_plot.png", width = 800, height = 600)
plot(pred, reg_model$residuals,
     main = "Residual Plot - Genre Regression",
     xlab = "Predicted Ratings",
     ylab = "Residuals",
     col = "darkgreen")
abline(h = 0, col = "red", lwd = 2)
dev.off()

# Scatter Plot: Actual vs Predicted
png("outputs/plots/scatter_plot.png", width = 800, height = 600)
plot(actual, pred,
     main = "Actual vs Predicted Ratings",
     xlab = "Actual Rating",
     ylab = "Predicted Rating",
     col = "blue")
abline(0, 1, col = "red", lwd = 2)
dev.off()

# Save metrics
cat("Regression Performance Metrics\n")
cat("=============================\n")
cat("MAE:", MAE, "\n")
cat("MSE:", MSE, "\n")
cat("RMSE:", RMSE, "\n")
cat("R-squared:", R2, "\n")
