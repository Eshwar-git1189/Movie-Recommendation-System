# Statistical Tests Results

## 1. Difference of Means (t-test)


	Welch Two Sample t-test

data:  high_ratings and low_ratings
t = 422.64, df = 82952, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 1.648725 1.664088
sample estimates:
mean of x mean of y 
 4.359953  2.703546 


---

## Interpretation

The t-test was used to compare the mean ratings of highly rated movies (rating ≥ 4) and low-rated movies (rating < 4).

Since the p-value is less than 0.05, the difference in means is statistically significant.

---

## 2. Wilcoxon Rank-Sum Test


	Wilcoxon rank sum test with continuity correction

data:  high_ratings and low_ratings
W = 2538596480, p-value < 2.2e-16
alternative hypothesis: true location shift is not equal to 0


---

## Interpretation

The Wilcoxon Rank-Sum Test is a non-parametric alternative to the t-test.

The test indicates a statistically significant difference between the two groups.

---

## 3. Analysis of Variance (ANOVA)

                Df Sum Sq Mean Sq F value Pr(>F)    
main_genre      18   2610  145.00   136.6 <2e-16 ***
Residuals   100817 106984    1.06                   
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

---

## Interpretation

ANOVA was used to determine whether mean ratings differ among genres.

The p-value is less than 0.05, indicating significant differences among genres.

---

## Conclusion

Statistical tests revealed that differences in movie ratings are statistically significant. Both parametric and non-parametric methods confirmed the presence of significant variation, and ANOVA indicated that ratings vary across genres.
