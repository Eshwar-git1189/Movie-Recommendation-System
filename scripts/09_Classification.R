#Create the target variable:
  
movie_data$liked <- ifelse(movie_data$rating >= 4, 1, 0)
  
#Split the data:
    
set.seed(123)
  
index <- sample(1:nrow(movie_data), 0.8 * nrow(movie_data))

train_data <- movie_data[index, ]
test_data <- movie_data[-index, ]

#Build the Logistic Regression model:
  
log_model <- glm(liked ~ userId + movieId,
                   data = train_data,
                   family = binomial)

#View the model summary:
  
  summary(log_model)

#Generate predictions on the test data:
  
  prob_pred <- predict(log_model,
                       newdata = test_data,
                       type = "response")

class_pred <- ifelse(prob_pred > 0.5, 1, 0)

#Create the confusion matrix: 
  
  table(Predicted = class_pred,
        Actual = test_data$liked)
  
  
#Calculate the performance metrics.

#Accuracy
conf_matrix <- table(Predicted = class_pred,
                     Actual = test_data$liked)

accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)

accuracy

#Precision
precision <- conf_matrix[2,2] / sum(conf_matrix[2,])

precision

#Recall
recall <- conf_matrix[2,2] / sum(conf_matrix[,2])

recall

#F1-Score
f1_score <- 2 * (precision * recall) / (precision + recall)

f1_score

#These cover the Predictive Performance Measures for classification.



#Now implement K-Nearest Neighbors (KNN).

#Load the package:
  
library(class)

#Select the predictor variables:

train_x <- train_data[, c("userId", "movieId")]
test_x <- test_data[, c("userId", "movieId")]

train_y <- train_data$liked
test_y <- test_data$liked

#Normalize the predictor variables:
  
train_x <- scale(train_x)
test_x <- scale(test_x)

#Apply KNN (with k = 5):
  
knn_pred <- knn(train = train_x,
                test = test_x,
                cl = train_y,
                k = 5)

#Create the confusion matrix:
  
conf_matrix_knn <- table(Predicted = knn_pred,
                         Actual = test_y)

conf_matrix_knn


#Calculate the performance metrics for KNN.

#Accuracy
accuracy_knn <- sum(diag(conf_matrix_knn)) / sum(conf_matrix_knn)

accuracy_knn

#Precision
precision_knn <- conf_matrix_knn[2,2] / sum(conf_matrix_knn[2,])

precision_knn

#Recall
recall_knn <- conf_matrix_knn[2,2] / sum(conf_matrix_knn[,2])

recall_knn


#F1-Score
f1_knn <- 2 * (precision_knn * recall_knn) /
  (precision_knn + recall_knn)

f1_knn

#This completes the KNN Classification.



#Now implement Naive Bayes.

#Load the package:
#install.packages("e1071")
library(e1071)

#Train the model:

nb_model <- naiveBayes(as.factor(liked) ~ userId + movieId,
                       data = train_data)

#Generate predictions:

nb_pred <- predict(nb_model,
                   newdata = test_data)

#Create the confusion matrix:

conf_matrix_nb <- table(Predicted = nb_pred,
                        Actual = test_data$liked)

conf_matrix_nb



#Calculate the performance metrics for Naive Bayes.

#Accuracy
accuracy_nb <- sum(diag(conf_matrix_nb)) / sum(conf_matrix_nb)

accuracy_nb

#Precision
precision_nb <- conf_matrix_nb[2,2] / sum(conf_matrix_nb[2,])

precision_nb

#Recall
recall_nb <- conf_matrix_nb[2,2] / sum(conf_matrix_nb[,2])

recall_nb

#F1-Score
f1_nb <- 2 * (precision_nb * recall_nb) /
  (precision_nb + recall_nb)

f1_nb

#This completes the Naive Bayes Classification and thus finishes the Classification section.