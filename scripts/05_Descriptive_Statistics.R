#Summary Statistics
summary(movie_data$rating)

#Mean Rating
mean(movie_data$rating)


#Median Rating
median(movie_data$rating)

#Standard Deviation
sd(movie_data$rating)

#Variance
var(movie_data$rating)

#Histogram of Ratings
png("outputs/plots/histogram_ratings.png",
    width=800,
    height=600)

hist(movie_data$rating,
     main="Distribution of Ratings",
     xlab="Rating",
     col="lightblue")

dev.off()

#Boxplot of Ratings
png("outputs/plots/boxplot_ratings.png",
    width=800,
    height=600)

boxplot(movie_data$rating,
        main="Boxplot of Ratings",
        col="orange")

dev.off()
#Bar Plot of Rating Frequencies
png("outputs/plots/barplot_ratings.png",
    width=800,
    height=600)
barplot(table(movie_data$rating),
        main = "Frequency of Ratings",
        xlab = "Rating",
        ylab = "Count",
        col = "lightgreen")
dev.off()

# Write metrics to JSON for report generation (update existing file)
std_dev <- sd(movie_data$rating)
variance <- var(movie_data$rating)
source("scripts/_write_metrics.R")
update_metrics(list(std_dev = round(std_dev, 4), variance = round(variance, 4)), "outputs/results/metrics.json")
cat("Metrics written to outputs/results/metrics.json\n")