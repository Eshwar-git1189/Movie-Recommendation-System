# Classification using Genre Features

# Load the dataset with genre columns
load("data/movie_data_with_genres.RData")

# Define genre columns
genre_list <- c("Action", "Adventure", "Animation", "Children", "Comedy",
                "Crime", "Documentary", "Drama", "Fantasy", "Film.Noir",
                "Horror", "Musical", "Mystery", "Romance", "Sci.Fi",
                "Thriller", "War", "Western")

# Create the target variable: liked = 1 if rating >= 4, else 0
movie_data$liked <- ifelse(movie_data$rating >= 4, 1, 0)

# Split the data into training (80%) and testing (20%)
set.seed(123)
index <- sample(1:nrow(movie_data), 0.8 * nrow(movie_data))
train_data <- movie_data[index, ]
test_data <- movie_data[-index, ]

# ==================================================
# Logistic Regression
# ==================================================

# Build formula: liked ~ all genre indicators
log_formula <- as.formula(paste("liked ~", paste(genre_list, collapse = " + ")))

# Train Logistic Regression model
log_model <- glm(log_formula, data = train_data, family = binomial)

# View model summary
summary(log_model)

# Predict on test data
prob_pred <- predict(log_model, newdata = test_data, type = "response")
class_pred <- ifelse(prob_pred > 0.5, 1, 0)

# Confusion Matrix
conf_matrix <- table(Predicted = class_pred, Actual = test_data$liked)
conf_matrix

# Performance Metrics
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
precision <- conf_matrix[2, 2] / sum(conf_matrix[2, ])
recall <- conf_matrix[2, 2] / sum(conf_matrix[, 2])
f1_score <- 2 * (precision * recall) / (precision + recall)

cat("Logistic Regression Performance:\n")
cat("Accuracy:", accuracy, "\n")
cat("Precision:", precision, "\n")
cat("Recall:", recall, "\n")
cat("F1-Score:", f1_score, "\n\n")

# ==================================================
# K-Nearest Neighbors (KNN)
# ==================================================

library(class)

# Select genre features for training and testing
train_x <- train_data[, genre_list]
test_x <- test_data[, genre_list]
train_y <- train_data$liked
test_y <- test_data$liked

# Normalize the features
train_x_scaled <- scale(train_x)
test_x_scaled <- scale(test_x, center = attr(train_x_scaled, "scaled:center"),
                        scale = attr(train_x_scaled, "scaled:scale"))

# Apply KNN with k = 5
knn_pred <- knn(train = train_x_scaled, test = test_x_scaled, cl = train_y, k = 5)

# Confusion Matrix
conf_matrix_knn <- table(Predicted = knn_pred, Actual = test_y)
conf_matrix_knn

# Performance Metrics
accuracy_knn <- sum(diag(conf_matrix_knn)) / sum(conf_matrix_knn)
precision_knn <- conf_matrix_knn[2, 2] / sum(conf_matrix_knn[2, ])
recall_knn <- conf_matrix_knn[2, 2] / sum(conf_matrix_knn[, 2])
f1_knn <- 2 * (precision_knn * recall_knn) / (precision_knn + recall_knn)

cat("KNN (k=5) Performance:\n")
cat("Accuracy:", accuracy_knn, "\n")
cat("Precision:", precision_knn, "\n")
cat("Recall:", recall_knn, "\n")
cat("F1-Score:", f1_knn, "\n\n")

# ==================================================
# Performance Comparison
# ==================================================

cat("Performance Comparison:\n")
cat("Model                 Accuracy  Precision  Recall  F1-Score\n")
cat("Logistic Regression   ", round(accuracy, 4), "  ", round(precision, 4),
    "  ", round(recall, 4), "  ", round(f1_score, 4), "\n")
cat("KNN (k=5)             ", round(accuracy_knn, 4), "  ", round(precision_knn, 4),
    "  ", round(recall_knn, 4), "  ", round(f1_knn, 4), "\n")

# Write classification metrics to JSON for report generation
source("scripts/_write_metrics.R")
update_metrics(list(
  lr_accuracy = round(accuracy, 4),
  lr_precision = round(precision, 4),
  lr_recall = round(recall, 4),
  lr_f1 = round(f1_score, 4),
  knn_accuracy = round(accuracy_knn, 4),
  knn_precision = round(precision_knn, 4),
  knn_recall = round(recall_knn, 4),
  knn_f1 = round(f1_knn, 4)
), "outputs/results/metrics.json")
cat("Classification metrics written to outputs/results/metrics.json\n")
