# Start Unit V: Classification

# Create the target variable

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

# Build the Logistic Regression model

log_model <- glm(liked ~ userId + movieId,
                 data = train_data,
                 family = binomial)

# View model summary

summary(log_model)

# Generate predictions

prob_pred <- predict(log_model,
                     newdata = test_data,
                     type = "response")

class_pred <- ifelse(prob_pred > 0.5, 1, 0)

# Create Confusion Matrix

conf_matrix <- table(Predicted = class_pred,
                     Actual = test_data$liked)

conf_matrix

# Calculate Performance Metrics

# Accuracy

accuracy <- sum(diag(conf_matrix)) /
  sum(conf_matrix)

accuracy

# Precision

precision <- conf_matrix[2,2] /
  sum(conf_matrix[2,])

precision

# Recall

recall <- conf_matrix[2,2] /
  sum(conf_matrix[,2])

recall

# F1-Score

f1_score <- 2 * (precision * recall) /
  (precision + recall)

f1_score


# ==================================================
# K-Nearest Neighbors (KNN)
# ==================================================

# Load the package

library(class)

# Select predictor variables

train_x <- train_data[, c("userId", "movieId")]
test_x <- test_data[, c("userId", "movieId")]

train_y <- train_data$liked
test_y <- test_data$liked

# Normalize the predictor variables

train_x <- scale(train_x)
test_x <- scale(test_x)

# Apply KNN with k = 5

knn_pred <- knn(train = train_x,
                test = test_x,
                cl = train_y,
                k = 5)

# Create Confusion Matrix

conf_matrix_knn <- table(Predicted = knn_pred,
                         Actual = test_y)

conf_matrix_knn

# Calculate Performance Metrics

# Accuracy

accuracy_knn <- sum(diag(conf_matrix_knn)) /
  sum(conf_matrix_knn)

accuracy_knn

# Precision

precision_knn <- conf_matrix_knn[2,2] /
  sum(conf_matrix_knn[2,])

precision_knn

# Recall

recall_knn <- conf_matrix_knn[2,2] /
  sum(conf_matrix_knn[,2])

recall_knn

# F1-Score

f1_knn <- 2 * (precision_knn * recall_knn) /
  (precision_knn + recall_knn)

f1_knn

# This completes:

# ✓ Classification
# ✓ Logistic Regression
# ✓ K-Nearest Neighbors (KNN)
# ✓ Model Validation
# ✓ Accuracy
# ✓ Precision
# ✓ Recall
# ✓ F1-Score