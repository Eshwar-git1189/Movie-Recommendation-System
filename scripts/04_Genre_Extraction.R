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



# ==================================================
# Create Results File
# ==================================================

sink("outputs/results/genre_extraction.md")

cat("# Genre Extraction Results\n\n")

cat("## Genre Categories\n\n")

cat("The following 18 genres were extracted from the MovieLens dataset:\n\n")

for (g in genre_list) {
  cat("- ", g, "\n", sep = "")
}

cat("\n---\n")

cat("\n## Summary\n\n")

cat("- Total observations: ", nrow(movie_data), "\n", sep = "")
cat("- Number of genre columns added: ", length(genre_list), "\n", sep = "")
cat("- Movies with no genre listed: ",
    sum(movie_data$genres == "(no genres listed)"),
    "\n",
    sep = "")

cat("\n---\n")

cat("\n## Number of Movies Belonging to Each Genre\n\n")

genre_counts <- colSums(movie_data[, genre_columns])

for(i in seq_along(genre_counts)) {
  cat("- ", names(genre_counts)[i],
      ": ",
      genre_counts[i],
      "\n",
      sep = "")
}

cat("\n---\n")

cat("\n## Interpretation\n\n")

cat("Genre information was extracted from the 'genres' column and converted into binary indicator variables. ")
cat("These features can be used for clustering, classification, regression, and recommendation tasks. ")
cat("Each genre column contains 1 if a movie belongs to that genre and 0 otherwise.\n")

sink()
