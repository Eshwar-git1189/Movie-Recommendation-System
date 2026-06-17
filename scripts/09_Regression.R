
# ==================================================
# Regression Analysis using Genre Features
# ==================================================

# Load the dataset with genre columns
load("data/movie_data_with_genres.RData")

# Define genre columns
genre_list <- c("Action", "Adventure", "Animation", "Children", "Comedy",
                "Crime", "Documentary", "Drama", "Fantasy", "Film.Noir",
                "Horror", "Musical", "Mystery", "Romance", "Sci.Fi",
                "Thriller", "War", "Western")

# Build regression formula
genre_formula <- as.formula(
  paste("rating ~", paste(genre_list, collapse = " + "))
)

# Perform Linear Regression
reg_model <- lm(genre_formula, data = movie_data)

# View regression results
summary(reg_model)

# ==================================================
# Predictive Performance Measures
# ==================================================

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


# ==================================================
# Residual Plot
# ==================================================

png("outputs/plots/residual_plot.png",
    width = 800,
    height = 600)

plot(pred,
     reg_model$residuals,
     main = "Residual Plot - Genre Regression",
     xlab = "Predicted Ratings",
     ylab = "Residuals",
     col = "darkgreen")

abline(h = 0,
       col = "red",
       lwd = 2)

dev.off()


# ==================================================
# Scatter Plot: Actual vs Predicted
# ==================================================

png("outputs/plots/scatter_plot.png",
    width = 800,
    height = 600)

plot(actual,
     pred,
     main = "Actual vs Predicted Ratings",
     xlab = "Actual Rating",
     ylab = "Predicted Rating",
     col = "blue")

abline(0,
       1,
       col = "red",
       lwd = 2)

dev.off()


# ==================================================
# Create Results File
# ==================================================

sink("outputs/results/regression_metrics.md")

cat("# Regression Performance Metrics\n\n")

cat("## Linear Regression Model\n\n")

cat("The target variable was movie rating, and the predictor variables were genre indicator columns.\n\n")

cat("---\n\n")

cat("## Predictive Performance Measures\n\n")

cat("- Mean Absolute Error (MAE): ",
    round(MAE, 4),
    "\n",
    sep = "")

cat("- Mean Squared Error (MSE): ",
    round(MSE, 4),
    "\n",
    sep = "")

cat("- Root Mean Squared Error (RMSE): ",
    round(RMSE, 4),
    "\n",
    sep = "")

cat("- R-squared (R²): ",
    round(R2, 4),
    "\n",
    sep = "")

cat("\n---\n\n")

cat("## Visualizations\n\n")

cat("- Scatter Plot (`scatter_plot.png`)\n")
cat("- Residual Plot (`residual_plot.png`)\n")

cat("\n---\n\n")

cat("## Interpretation\n\n")

cat("Linear regression was used to predict movie ratings using genre features.\n\n")

cat("MAE, MSE, RMSE and R² were used to evaluate the predictive performance of the model.\n\n")

cat("The residual plot was used to assess prediction errors, while the scatter plot compares actual ratings with predicted ratings.\n\n")

cat("---\n\n")

cat("## Conclusion\n\n")

cat("Linear regression provides a baseline model for predicting movie ratings based on genre information.\n")

sink()

cat("Results written to outputs/results/regression_metrics.md\n")

