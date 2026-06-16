# Attribute Selection Results

1. Filter Method

---

Correlation Matrix

```
          userId      movieId       rating
```

userId    1.000000    0.006773    -0.049348

movieId   0.006773    1.000000    -0.004061

rating    -0.049348   -0.004061    1.000000

## Interpretation

The correlation analysis indicates that both userId and movieId have very weak relationships with the rating variable. This suggests that additional features would be necessary to improve prediction performance.

---

2. Wrapper Method

---

Stepwise Regression Result

Final Model:

rating ~ userId

Regression Coefficients

Intercept = 3.593

userId coefficient = -0.0002817

Residual Standard Error

1.041

Multiple R²

0.002435

Adjusted R²

0.002425

F-statistic

246.2

p-value

< 2.2 × 10⁻¹⁶

## Interpretation

Stepwise regression selected only userId as a significant predictor and removed movieId from the model. Although the model is statistically significant, the R² value is very small, indicating that the selected feature explains only a small portion of the variation in movie ratings.

---

## Conclusion

Filter and wrapper methods were used for attribute selection. The analysis showed that the available predictors possess limited explanatory power, indicating that additional features would be required to build more accurate recommendation models.
