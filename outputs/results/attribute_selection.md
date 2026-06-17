# Attribute Selection Results

## 1. Filter Method - Correlation Analysis

### Top Genres Correlated with Rating

| Genre | Absolute Correlation |
|-------|--------------------:|
| Drama | 0.1251 |
| Comedy | 0.0891 |
| Crime | 0.0669 |
| War | 0.0662 |
| Horror | 0.0652 |

---

## Correlation Matrix

- Correlation Matrix Plot (`correlation_matrix.png`)

---

## 2. Wrapper Method - Stepwise Regression

### Selected Features

- Action
- Adventure
- Animation
- Children
- Comedy
- Crime
- Documentary
- Drama
- Fantasy
- Film.Noir
- Horror
- Musical
- Mystery
- Romance
- Sci.Fi
- Thriller
- War
- Western

---

### Model Performance

- Full Model R-squared: 0.0391
- Stepwise Model R-squared: 0.0391

---

## Interpretation

The Filter Method was used to identify genres having the strongest correlation with movie ratings.

The Wrapper Method used stepwise regression to select important features for predicting ratings.

These techniques help reduce dimensionality and improve model interpretability.

---

## Conclusion

Attribute selection methods identified the most influential genre features and provided a simplified model for prediction.
