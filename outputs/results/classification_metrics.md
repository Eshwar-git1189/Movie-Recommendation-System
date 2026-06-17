# Classification Performance Metrics

## Target Variable

- Liked = 1 if rating >= 4
- Not Liked = 0 otherwise

---

## Logistic Regression

### Confusion Matrix

         Actual
Predicted    0    1
        0 6924 5118
        1 3540 4586

### Accuracy

0.5707 

### Precision

0.5644 

### Recall

0.4726 

### F1-Score

0.5144 

---

## Interpretation

Logistic Regression was used to classify whether a user liked a movie or not based on genre information.

Accuracy, Precision, Recall and F1-Score were used to evaluate the classification performance.

Logistic Regression was chosen as the final classification model because it provided stable predictions and was well suited for binary genre features.

---

## Conclusion

Logistic Regression successfully classified movies into liked and not liked categories and served as the final classification model for the Movie Recommendation System.
