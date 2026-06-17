
# ==================================================
# Descriptive Statistics
# ==================================================

# Summary Statistics
summary(movie_data$rating)

# Mean Rating
mean(movie_data$rating)

# Median Rating
median(movie_data$rating)

# Standard Deviation
sd(movie_data$rating)

# Variance
var(movie_data$rating)


# ==================================================
# Histogram of Ratings
# ==================================================

png("outputs/plots/histogram_ratings.png",
    width = 800,
    height = 600)

hist(movie_data$rating,
     main = "Distribution of Ratings",
     xlab = "Rating",
     col = "lightblue")

dev.off()


# ==================================================
# Boxplot of Ratings
# ==================================================

png("outputs/plots/boxplot_ratings.png",
    width = 800,
    height = 600)

boxplot(movie_data$rating,
        main = "Boxplot of Ratings",
        col = "orange")

dev.off()


# ==================================================
# Bar Plot of Rating Frequencies
# ==================================================

png("outputs/plots/barplot_ratings.png",
    width = 800,
    height = 600)

barplot(table(movie_data$rating),
        main = "Frequency of Ratings",
        xlab = "Rating",
        ylab = "Count",
        col = "lightgreen")

dev.off()


# ==================================================
# Create Results File
# ==================================================

sink("outputs/results/descriptive_statistics.md")

cat("# Descriptive Statistics Results\n\n")

cat("## Summary Statistics\n\n")

print(summary(movie_data$rating))

cat("\n---\n\n")

cat("## Measures of Central Tendency and Dispersion\n\n")

cat("- Mean Rating: ",
    round(mean(movie_data$rating), 4),
    "\n",
    sep = "")

cat("- Median Rating: ",
    round(median(movie_data$rating), 4),
    "\n",
    sep = "")

cat("- Standard Deviation: ",
    round(sd(movie_data$rating), 4),
    "\n",
    sep = "")

cat("- Variance: ",
    round(var(movie_data$rating), 4),
    "\n",
    sep = "")

cat("\n---\n\n")

cat("## Visualizations\n\n")

cat("- Histogram of Ratings (`histogram_ratings.png`)\n")
cat("- Boxplot of Ratings (`boxplot_ratings.png`)\n")
cat("- Bar Plot of Rating Frequencies (`barplot_ratings.png`)\n")

cat("\n---\n\n")

cat("## Interpretation\n\n")

cat("Descriptive statistics were used to understand the distribution of movie ratings.\n\n")

cat("The mean and median provide measures of central tendency, while the standard deviation and variance describe the variability in ratings.\n\n")

cat("Histogram, boxplot, and bar plot were used to visualize the distribution and frequency of ratings.\n")

sink()

cat("Results written to outputs/results/descriptive_statistics.md\n")

