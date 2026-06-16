# Classification Performance Metrics

Target Variable:
Liked = 1 if rating >= 4
Not Liked = 0 otherwise

---

1. Logistic Regression

---

Confusion Matrix

```
             Actual
```

Predicted         0        1
0              7591     6743
1              2873     2961

## Accuracy

0.5232051

## Precision

0.5075420

## Recall

0.3051319

## F1-Score

0.3811301

## Interpretation

Logistic Regression achieved an accuracy of 52.32%. The model exhibited low recall and F1-score, indicating limited capability in correctly identifying liked movies.

---

2. K-Nearest Neighbors (KNN)

---

Confusion Matrix

```
             Actual
```

Predicted         0        1
0              6604     4111
1              3860     5593

## Accuracy

0.6047699

## Precision

0.5916640

## Recall

0.5763603

## F1-Score

0.5839119

## Interpretation

KNN achieved the best performance among all classification models with an accuracy of 60.48%. It provided better balance between precision and recall, resulting in the highest F1-score.

---

3. Naive Bayes

---

Confusion Matrix

```
             Actual
```

Predicted         0        1
0              7482     6604
1              2982     3100

## Accuracy

0.5246926

## Precision

0.5097008

## Recall

0.3194559

## F1-Score

0.3927531

## Interpretation

Naive Bayes achieved an accuracy of 52.47%. Although its precision was comparable to Logistic Regression, the recall and F1-score remained relatively low.

---

## Overall Comparison

Model                  Accuracy    Precision    Recall    F1-Score

Logistic Regression     52.32%       50.75%     30.51%     38.11%

K-Nearest Neighbors     60.48%       59.17%     57.64%     58.39%

Naive Bayes             52.47%       50.97%     31.95%     39.28%

## Conclusion

Among the three classification algorithms, K-Nearest Neighbors (KNN) demonstrated the best performance with the highest accuracy and F1-score. Therefore, KNN is the most suitable classification model for predicting whether users liked a movie in the MovieLens recommendation system dataset.
