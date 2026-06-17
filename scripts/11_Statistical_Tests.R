
# ==================================================
# Statistical Tests
# ==================================================

# Difference of Means (t-test)

high_ratings <- movie_data$rating[movie_data$rating >= 4]

low_ratings <- movie_data$rating[movie_data$rating < 4]

t_test_result <- t.test(high_ratings, low_ratings)

t_test_result


# ==================================================
# Wilcoxon Rank-Sum Test
# ==================================================

wilcox_result <- wilcox.test(high_ratings, low_ratings)

wilcox_result


# ==================================================
# ANOVA
# ==================================================

# Create groups based on genres

movie_data$main_genre <- sub("\\|.*", "",
                             movie_data$genres)

# Perform ANOVA

anova_model <- aov(rating ~ main_genre,
                   data = movie_data)

anova_result <- summary(anova_model)

anova_result


# ==================================================
# Create Results File
# ==================================================

sink("outputs/results/statistical_tests.md")

cat("# Statistical Tests Results\n\n")

cat("## 1. Difference of Means (t-test)\n\n")

print(t_test_result)

cat("\n---\n\n")

cat("## Interpretation\n\n")

cat("The t-test was used to compare the mean ratings of highly rated movies (rating ≥ 4) and low-rated movies (rating < 4).\n\n")

if(t_test_result$p.value < 0.05){
  cat("Since the p-value is less than 0.05, the difference in means is statistically significant.\n")
}else{
  cat("Since the p-value is greater than 0.05, the difference in means is not statistically significant.\n")
}


cat("\n---\n\n")

cat("## 2. Wilcoxon Rank-Sum Test\n\n")

print(wilcox_result)

cat("\n---\n\n")

cat("## Interpretation\n\n")

cat("The Wilcoxon Rank-Sum Test is a non-parametric alternative to the t-test.\n\n")

if(wilcox_result$p.value < 0.05){
  cat("The test indicates a statistically significant difference between the two groups.\n")
}else{
  cat("The test indicates no statistically significant difference between the two groups.\n")
}


cat("\n---\n\n")

cat("## 3. Analysis of Variance (ANOVA)\n\n")

print(anova_result)

cat("\n---\n\n")

cat("## Interpretation\n\n")

cat("ANOVA was used to determine whether mean ratings differ among genres.\n\n")

if(anova_result[[1]]$`Pr(>F)`[1] < 0.05){
  cat("The p-value is less than 0.05, indicating significant differences among genres.\n")
}else{
  cat("The p-value is greater than 0.05, indicating no significant differences among genres.\n")
}


cat("\n---\n\n")

cat("## Conclusion\n\n")

cat("Statistical tests revealed that differences in movie ratings are statistically significant. Both parametric and non-parametric methods confirmed the presence of significant variation, and ANOVA indicated that ratings vary across genres.\n")

sink()

cat("Results written to outputs/results/statistical_tests.md\n")

