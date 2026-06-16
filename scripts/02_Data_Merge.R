movie_data <- merge(ratings, movies, by = "movieId")

head(movie_data)

dim(movie_data)

str(movie_data)
summary(movie_data)