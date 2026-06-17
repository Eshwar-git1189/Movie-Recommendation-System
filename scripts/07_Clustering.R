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
