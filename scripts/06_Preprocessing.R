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
movie_level <- merge(movie_level, movie_genres, by = c("movieId", "title"))

# Inspect the movie-level dataset
head(movie_level)
dim(movie_level)

# Save for clustering
save(movie_level, file = "data/movie_level_data.RData")

cat("Preprocessing complete.\n")
cat("Movie-level dataset:", nrow(movie_level), "movies\n")
cat("Features:", ncol(movie_level), "\n")

# Write PCA metrics to JSON for report generation
prop_var <- pca_model$sdev^2 / sum(pca_model$sdev^2)
cum_var <- cumsum(prop_var)
source("scripts/_write_metrics.R")
update_metrics(list(
  pc1_var = round(prop_var[1], 4),
  pc1_cum = round(cum_var[1], 4),
  pc2_var = round(prop_var[2], 4),
  pc2_cum = round(cum_var[2], 4),
  pc3_var = round(prop_var[3], 4),
  pc3_cum = round(cum_var[3], 4)
), "outputs/results/metrics.json")
cat("PCA metrics written to outputs/results/metrics.json\n")
