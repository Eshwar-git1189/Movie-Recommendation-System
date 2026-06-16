summary(movie_data)
sum(is.na(movie_data))

colSums(is.na(movie_data))

sum(duplicated(movie_data))



#Perform data type checking
str(movie_data)

#Also check the number of unique users and movies
length(unique(movie_data$userId))

length(unique(movie_data$movieId))