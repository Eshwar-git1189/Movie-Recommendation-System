# ==================================================
# Attribute Selection using Genre Features
# ==================================================

# Load the dataset with genre columns
load("data/movie_data_with_genres.RData")

# Define genre columns
genre_list <- c("Action", "Adventure", "Animation", "Children", "Comedy",
                "Crime", "Documentary", "Drama", "Fantasy", "Film.Noir",
                "Horror", "Musical", "Mystery", "Romance", "Sci.Fi",
                "Thriller", "War", "Western")

# ==================================================
# 1. Filter Method - Correlation Analysis
# ==================================================

# Compute correlation matrix
cor_vars <- c("rating", genre_list)

corr_matrix <- cor(movie_data[, cor_vars])

# View correlations with rating
corr_matrix["rating", ]

# Visualize the correlation matrix

library(corrplot)

png("outputs/plots/correlation_matrix.png",
    width = 800,
    height = 600)

corrplot(corr_matrix,
         method = "circle",
         type = "lower",
         tl.cex = 0.7,
         tl.col = "black",
         title = "Correlation Matrix - Rating and Genres",
         mar = c(0, 0, 2, 0))

dev.off()

# Identify genres with strongest correlation to rating

rating_cor <- abs(corr_matrix["rating", ])

rating_cor <- sort(
  rating_cor[names(rating_cor) != "rating"],
  decreasing = TRUE
)

cat("Top genres correlated with rating:\n")

print(head(rating_cor, 5))


# ==================================================
# 2. Wrapper Method - Stepwise Regression
# ==================================================

# Build full model

full_formula <- as.formula(
  paste("rating ~", paste(genre_list, collapse = " + "))
)

full_model <- lm(full_formula,
                 data = movie_data)

# Perform stepwise regression

step_model <- step(full_model,
                   direction = "both",
                   trace = 0)

# View selected model

cat("\nStepwise Regression Selected Model:\n")

summary(step_model)

# View selected features

cat("\nSelected features:\n")

selected_feat <- names(coef(step_model))[-1]

cat(selected_feat,
    sep = ", ")

# Compare R-squared values

cat("\n\nFull model R-squared:",
    summary(full_model)$r.squared,
    "\n")

cat("Stepwise model R-squared:",
    summary(step_model)$r.squared,
    "\n")


# ==================================================
# Create Results File
# ==================================================

sink("outputs/results/attribute_selection.md")

cat("# Attribute Selection Results\n\n")

cat("## 1. Filter Method - Correlation Analysis\n\n")

cat("### Top Genres Correlated with Rating\n\n")

cat("| Genre | Absolute Correlation |\n")
cat("|-------|--------------------:|\n")

for(i in 1:min(5, length(rating_cor))){
  
  cat("| ",
      names(rating_cor)[i],
      " | ",
      round(rating_cor[i], 4),
      " |\n",
      sep = "")
}

cat("\n---\n\n")

cat("## Correlation Matrix\n\n")

cat("- Correlation Matrix Plot (`correlation_matrix.png`)\n")

cat("\n---\n\n")

cat("## 2. Wrapper Method - Stepwise Regression\n\n")

cat("### Selected Features\n\n")

if(length(selected_feat) > 0){
  
  for(feat in selected_feat){
    
    cat("- ",
        feat,
        "\n",
        sep = "")
  }
  
} else {
  
  cat("No features were selected.\n")
}

cat("\n---\n\n")

cat("### Model Performance\n\n")

cat("- Full Model R-squared: ",
    round(summary(full_model)$r.squared, 4),
    "\n",
    sep = "")

cat("- Stepwise Model R-squared: ",
    round(summary(step_model)$r.squared, 4),
    "\n",
    sep = "")

cat("\n---\n\n")

cat("## Interpretation\n\n")

cat("The Filter Method was used to identify genres having the strongest correlation with movie ratings.\n\n")

cat("The Wrapper Method used stepwise regression to select important features for predicting ratings.\n\n")

cat("These techniques help reduce dimensionality and improve model interpretability.\n")

cat("\n---\n\n")

cat("## Conclusion\n\n")

cat("Attribute selection methods identified the most influential genre features and provided a simplified model for prediction.\n")

sink()

cat("Results written to outputs/results/attribute_selection.md\n")
