# Data Preprocessing and PCA using Genre Features

# Load the dataset with genre columns
load("data/movie_data_with_genres.RData")

# Define genre columns
genre_list <- c("Action", "Adventure", "Animation", "Children", "Comedy",
                "Crime", "Documentary", "Drama", "Fantasy", "Film.Noir",
                "Horror", "Musical", "Mystery", "Romance", "Sci.Fi",
                "Thriller", "War", "Western")

# --- PCA on Genre Features (rating-level data) ---

# Extract genre indicator columns
genre_data <- movie_data[, genre_list]

# Scale the binary genre data
scaled_genres <- scale(genre_data)

# Perform PCA
pca_model <- prcomp(scaled_genres)

# View PCA summary
summary(pca_model)

# Proportion of variance explained
pca_model$sdev^2 / sum(pca_model$sdev^2)

# Scree Plot
png("outputs/plots/scree_plot.png", width = 800, height = 600)
plot(pca_model, type = "l", main = "Scree Plot - Genre PCA")
dev.off()

# Biplot
png("outputs/plots/pca_biplot.png", width = 800, height = 600)
biplot(pca_model, main = "PCA Biplot - Genre Components")
dev.off()

# --- Movie-Level Aggregation for Clustering ---

# Compute average rating per movie
movie_avg <- aggregate(rating ~ movieId, data = movie_data, FUN = mean)
names(movie_avg)[2] <- "avg_rating"

# Compute rating count per movie
rating_counts <- as.data.frame(table(movie_data$movieId))
names(rating_counts) <- c("movieId", "rating_count")
rating_counts$movieId <- as.numeric(as.character(rating_counts$movieId))

# Get unique movie-genre assignments (one row per movie)
movie_genres <- unique(movie_data[, c("movieId", "title", genre_list)])

# Merge into movie-level dataset
movie_level <- merge(movie_avg, rating_counts, by = "movieId")
movie_level <- merge(movie_level,
                     movie_genres,
                     by = "movieId")
# Inspect the movie-level dataset
head(movie_level)
dim(movie_level)

# Save for clustering
save(movie_level, file = "data/movie_level_data.RData")

cat("Preprocessing complete.\n")
cat("Movie-level dataset:", nrow(movie_level), "movies\n")
cat("Features:", ncol(movie_level), "\n")

# ================================================== # Create Results File # ================================================== prop_var <- pca_model$sdev^2 / sum(pca_model$sdev^2) cum_var <- cumsum(prop_var) sink("outputs/results/pca_results.md") cat("# Principal Component Analysis (PCA) Results\n\n") cat("## Variance Explained by Principal Components\n\n") cat("| Principal Component | Proportion of Variance | Cumulative Variance |\n") cat("|-------------------|----------------------:|-------------------:|\n") for(i in 1:length(prop_var)) { cat("| PC", i, " | ", round(prop_var[i], 4), " | ", round(cum_var[i], 4), " |\n", sep = "") } cat("\n---\n\n") cat("## Visualizations\n\n") cat("- Scree Plot (`scree_plot.png`)\n") cat("- PCA Biplot (`pca_biplot.png`)\n") cat("\n---\n\n") cat("## Movie-Level Dataset\n\n") cat("- Number of movies: ", nrow(movie_level), "\n", sep = "") cat("- Number of features: ", ncol(movie_level), "\n", sep = "") cat("\n---\n\n") cat("## Interpretation\n\n") cat("Principal Component Analysis (PCA) was performed on the genre indicator variables after scaling.\n\n") cat("PCA reduces the dimensionality of the data while preserving the maximum amount of information.\n\n") cat("The Scree Plot and PCA Biplot were used to visualize the variance explained by the principal components and the relationships among variables.\n") sink() cat("Results written to outputs/results/pca_results.md\n")
