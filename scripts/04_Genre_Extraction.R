# Extract Genre Indicators from MovieLens data

# List of all genre categories in the dataset
genre_list <- c("Action", "Adventure", "Animation", "Children", "Comedy",
                "Crime", "Documentary", "Drama", "Fantasy", "Film-Noir",
                "Horror", "Musical", "Mystery", "Romance", "Sci-Fi",
                "Thriller", "War", "Western")

# Create binary indicator columns for each genre
for (g in genre_list) {
  safe_name <- make.names(g)
  movie_data[[safe_name]] <- ifelse(grepl(g, movie_data$genres), 1, 0)
}

# Verify the new columns
genre_columns <- make.names(genre_list)
head(movie_data[, genre_columns])

# Check how many movies have each genre
colSums(movie_data[, genre_columns])

# Check for movies with no genre listed
sum(movie_data$genres == "(no genres listed)")

# Save the enhanced dataset
save(movie_data, file = "data/movie_data_with_genres.RData")

# Print summary
cat("Genre extraction complete.\n")
cat("Total observations:", nrow(movie_data), "\n")
cat("Genre columns added:", length(genre_list), "\n")
