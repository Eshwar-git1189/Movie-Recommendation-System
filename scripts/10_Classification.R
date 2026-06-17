
# ==================================================
# Classification using Genre Features
# ==================================================

# Load the dataset with genre columns
load("data/movie_data_with_genres.RData")

# Define genre columns
genre_list <- c("Action", "Adventure", "Animation", "Children", "Comedy",
                "Crime", "Documentary", "Drama", "Fantasy", "Film.Noir",
                "Horror", "Musical", "Mystery", "Romance", "Sci.Fi",
                "Thriller", "War", "Western")

# Create the target variable
# liked = 1 if rating >= 4, otherwise 0
movie_data$liked <- ifelse(movie_data$rating >= 4, 1, 0)

# Split the data into training and testing sets
set.seed(123)

index <- sample(1:nrow(movie_data),
                0.8 * nrow(movie_data))

train_data <- movie_data[index, ]
test_data <- movie_data[-index, ]


# ==================================================
# Logistic Regression
# ==================================================

# Build formula using genre indicators

log_formula <- as.formula(
  paste("liked ~", paste(genre_list, collapse = " + "))
)

# Train Logistic Regression model

log_model <- glm(log_formula,
                 data = train_data,
                 family = binomial)

# View model summary

summary(log_model)

# Predict probabilities

prob_pred <- predict(log_model,
                     newdata = test_data,
                     type = "response")

# Convert probabilities to class labels

class_pred <- ifelse(prob_pred > 0.5, 1, 0)

# Confusion Matrix

conf_matrix <- table(Predicted = class_pred,
                     Actual = test_data$liked)

conf_matrix


# ==================================================
# Performance Metrics
# ==================================================

# Accuracy

accuracy <- sum(diag(conf_matrix)) /
  sum(conf_matrix)

# Precision

precision <- conf_matrix[2,2] /
  sum(conf_matrix[2,])

# Recall

recall <- conf_matrix[2,2] /
  sum(conf_matrix[,2])

# F1-Score

f1_score <- 2 * (precision * recall) /
  (precision + recall)


# Display metrics

cat("Logistic Regression Performance\n")
cat("===============================\n")
cat("Accuracy :", round(accuracy, 4), "\n")
cat("Precision:", round(precision, 4), "\n")
cat("Recall   :", round(recall, 4), "\n")
cat("F1-Score :", round(f1_score, 4), "\n")


# ==================================================
# Note on K-Nearest Neighbors (KNN)
# ==================================================

# KNN was initially considered for classification.
# However, the MovieLens genre features are binary
# and many movies share identical genre combinations.
# This resulted in excessive ties and unstable
# predictions during model training.
#
# Therefore, Logistic Regression was selected as the
# final classification model because it provides
# more stable and reliable performance for this dataset.


# ==================================================
# Create Results File
# ==================================================

sink("outputs/results/classification_metrics.md")

cat("# Classification Performance Metrics\n\n")

cat("## Target Variable\n\n")

cat("- Liked = 1 if rating >= 4\n")
cat("- Not Liked = 0 otherwise\n")

cat("\n---\n\n")

cat("## Logistic Regression\n\n")

cat("### Confusion Matrix\n\n")

print(conf_matrix)

cat("\n### Accuracy\n\n")
cat(round(accuracy, 4), "\n")

cat("\n### Precision\n\n")
cat(round(precision, 4), "\n")

cat("\n### Recall\n\n")
cat(round(recall, 4), "\n")

cat("\n### F1-Score\n\n")
cat(round(f1_score, 4), "\n")

cat("\n---\n\n")

cat("## Interpretation\n\n")

cat("Logistic Regression was used to classify whether a user liked a movie or not based on genre information.\n\n")

cat("Accuracy, Precision, Recall and F1-Score were used to evaluate the classification performance.\n\n")

cat("Logistic Regression was chosen as the final classification model because it provided stable predictions and was well suited for binary genre features.\n")

cat("\n---\n\n")

cat("## Conclusion\n\n")

cat("Logistic Regression successfully classified movies into liked and not liked categories and served as the final classification model for the Movie Recommendation System.\n")

sink()

cat("Results written to outputs/results/classification_metrics.md\n")

