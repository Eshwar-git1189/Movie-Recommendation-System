# Attribute Selection using Genre Features

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

# Compute correlation matrix: rating vs all genre indicators
cor_vars <- c("rating", genre_list)
corr_matrix <- cor(movie_data[, cor_vars])

# View correlations with rating
corr_matrix["rating", ]

# Visualize the correlation matrix
library(corrplot)

png("outputs/plots/correlation_matrix.png", width = 800, height = 600)
corrplot(corr_matrix, method = "circle", type = "lower",
         tl.cex = 0.7, tl.col = "black",
         title = "Correlation Matrix - Rating and Genres",
         mar = c(0, 0, 2, 0))
dev.off()

# Identify genres with strongest correlation to rating
rating_cor <- abs(corr_matrix["rating", ])
rating_cor <- sort(rating_cor[names(rating_cor) != "rating"], decreasing = TRUE)
cat("Top genres correlated with rating:\n")
print(head(rating_cor, 5))

# ==================================================
# 2. Wrapper Method - Stepwise Regression
# ==================================================

# Build full model with all genre indicators
full_formula <- as.formula(paste("rating ~", paste(genre_list, collapse = " + ")))
full_model <- lm(full_formula, data = movie_data)

# Perform stepwise regression
step_model <- step(full_model, direction = "both", trace = 0)

# View the selected model
cat("\nStepwise Regression Selected Model:\n")
summary(step_model)

# View selected features
cat("\nSelected features:\n")
cat(names(coef(step_model))[-1], sep = ", ")

# Compare R-squared values
cat("\n\nFull model R-squared:", summary(full_model)$r.squared, "\n")
cat("Stepwise model R-squared:", summary(step_model)$r.squared, "\n")

# Write attribute selection metrics to JSON for report generation
selected_feat <- names(coef(step_model))[-1]
selected_feat_str <- if (length(selected_feat) > 0) paste(selected_feat, collapse = ", ") else "None"
source("scripts/_write_metrics.R")
update_metrics(list(
  top1_genre = names(rating_cor)[1],
  top1_cor = round(rating_cor[1], 4),
  top2_genre = names(rating_cor)[2],
  top2_cor = round(rating_cor[2], 4),
  top3_genre = names(rating_cor)[3],
  top3_cor = round(rating_cor[3], 4),
  top4_genre = names(rating_cor)[4],
  top4_cor = round(rating_cor[4], 4),
  top5_genre = names(rating_cor)[5],
  top5_cor = round(rating_cor[5], 4),
  selected_features = selected_feat_str,
  stepwise_r_squared = round(summary(step_model)$r.squared, 4)
), "outputs/results/metrics.json")
cat("Attribute selection metrics written to outputs/results/metrics.json\n")
