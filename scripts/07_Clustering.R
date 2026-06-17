# Clustering using Movie-Level Genre Features

# Load the movie-level dataset
load("data/movie_level_data.RData")

# Define genre columns
genre_list <- c("Action", "Adventure", "Animation", "Children", "Comedy",
                "Crime", "Documentary", "Drama", "Fantasy", "Film.Noir",
                "Horror", "Musical", "Mystery", "Romance", "Sci.Fi",
                "Thriller", "War", "Western")

# Select features for clustering: avg_rating, rating_count, and genre indicators
cluster_features <- movie_level[, c("avg_rating", "rating_count", genre_list)]

# Scale the features
scaled_features <- scale(cluster_features)

# --- K-Means Clustering (k = 3) ---
kmeans_model <- kmeans(scaled_features, centers = 3, nstart = 25)

# View cluster sizes
kmeans_model$size

# Add cluster assignment to movie_level
movie_level$cluster <- kmeans_model$cluster

# View sample movies per cluster
head(movie_level[movie_level$cluster == 1, c("title", "avg_rating", "rating_count")])
head(movie_level[movie_level$cluster == 2, c("title", "avg_rating", "rating_count")])
head(movie_level[movie_level$cluster == 3, c("title", "avg_rating", "rating_count")])

# Load factoextra for visualization
library(factoextra)

# K-Means Cluster Plot
png("outputs/plots/kmeans_cluster.png", width = 800, height = 600)
fviz_cluster(kmeans_model, data = scaled_features,
             main = "K-Means Clustering of Movies (k = 3)")
dev.off()

# Cluster Centers Plot
png("outputs/plots/cluster_centers.png", width = 800, height = 600)
barplot(kmeans_model$centers, beside = TRUE,
        col = c("red", "blue", "green"),
        main = "Cluster Centers by Feature",
        las = 2, cex.names = 0.7)
legend("topright", legend = paste("Cluster", 1:3),
       fill = c("red", "blue", "green"))
dev.off()

# Print cluster interpretation
cat("Cluster sizes:", kmeans_model$size, "\n")
cat("Cluster centers:\n")
print(kmeans_model$centers)

# ==================================================
# Create Results File
# ==================================================

sink("outputs/results/clustering_results.md")

cat("# K-Means Clustering Results\n\n")

cat("## Number of Clusters\n\n")

cat("- Number of clusters used: 3\n")

cat("\n---\n\n")

cat("## Cluster Sizes\n\n")

cat("| Cluster | Number of Movies |\n")
cat("|---------|----------------:|\n")

for(i in 1:length(kmeans_model$size)) {
  cat("| ",
      i,
      " | ",
      kmeans_model$size[i],
      " |\n",
      sep = "")
}

cat("\n---\n\n")

cat("## Cluster Centers\n\n")

print(round(kmeans_model$centers, 4))

cat("\n---\n\n")

cat("## Sample Movies from Each Cluster\n\n")

cat("### Cluster 1\n\n")
print(head(movie_level[movie_level$cluster == 1,
                       c("title", "avg_rating", "rating_count")]))

cat("\n### Cluster 2\n\n")
print(head(movie_level[movie_level$cluster == 2,
                       c("title", "avg_rating", "rating_count")]))

cat("\n### Cluster 3\n\n")
print(head(movie_level[movie_level$cluster == 3,
                       c("title", "avg_rating", "rating_count")]))

cat("\n---\n\n")

cat("## Visualizations\n\n")

cat("- K-Means Cluster Plot (`kmeans_cluster.png`)\n")
cat("- Cluster Centers Plot (`cluster_centers.png`)\n")

cat("\n---\n\n")

cat("## Interpretation\n\n")

cat("K-Means clustering was performed using average rating, rating count, and genre indicators.\n\n")

cat("Movies were grouped into three clusters based on their similarities.\n\n")

cat("Cluster centers represent the average feature values of each cluster and help understand the characteristics of the movies in each group.\n")

sink()

cat("Results written to outputs/results/clustering_results.md\n")