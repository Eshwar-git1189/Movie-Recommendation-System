# Classification Performance Metrics

## Target Variable

* Liked = 1 if rating >= 4
* Not Liked = 0 otherwise

---

# 1. Logistic Regression

## Confusion Matrix

```text
             Actual
Predicted        0        1
0             7591     6743
1             2873     2961
```

## Accuracy

0.5232051

## Precision

0.5075420

## Recall

0.3051319

## F1-Score

0.3811301

## Interpretation

Logistic Regression achieved an accuracy of 52.32%. However, the model exhibited low recall and F1-score, indicating limited capability in correctly identifying liked movies.

---

# 2. K-Nearest Neighbors (KNN)

## Confusion Matrix

```text
             Actual
Predicted        0        1
0             6604     4111
1             3860     5593
```

## Accuracy

0.6047699

## Precision

0.5916640

## Recall

0.5763603

## F1-Score

0.5839119

## Interpretation

K-Nearest Neighbors (KNN) achieved the highest accuracy and F1-score. It provided a better balance between precision and recall.

---

# Overall Comparison

| Model                     | Accuracy | Precision | Recall | F1-Score |
| ------------------------- | -------: | --------: | -----: | -------: |
| Logistic Regression       |   52.32% |    50.75% | 30.51% |   38.11% |
| K-Nearest Neighbors (KNN) |   60.48% |    59.17% | 57.64% |   58.39% |

---

# Conclusion

Among the classification algorithms considered, K-Nearest Neighbors (KNN) demonstrated superior performance with the highest accuracy and F1-score. Therefore, KNN is selected as the final classification model for predicting whether users liked a movie in the MovieLens recommendation system dataset.
