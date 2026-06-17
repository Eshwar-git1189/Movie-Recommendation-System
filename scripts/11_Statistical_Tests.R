#Continue with the remaining topics from Unit II.

#Difference of Means (t-test)
high_ratings <- movie_data$rating[movie_data$rating >= 4]

low_ratings <- movie_data$rating[movie_data$rating < 4]

t.test(high_ratings, low_ratings)

#Wilcoxon Rank-Sum Test
wilcox.test(high_ratings, low_ratings)

#ANOVA

#First create groups based on genres:
  
movie_data$main_genre <- sub("\\|.*", "", movie_data$genres)

#Then perform ANOVA:
  
anova_model <- aov(rating ~ main_genre, data = movie_data)

summary(anova_model)