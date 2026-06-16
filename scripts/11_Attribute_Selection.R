#Now cover the remaining topics in Unit III.

#Filter Method

#Compute the correlation between the numeric variables:
  
cor(movie_data[, c("userId", "movieId", "rating")])

#This helps identify relevant attributes based on statistical relationships.

#You can also visualize it:
  
#install.packages("corrplot")    # Run once in Console
library(corrplot)

corr_matrix <- cor(movie_data[, c("userId", "movieId", "rating")])

png("outputs/plots/correlation_matrix.png",
    width=800,
    height=600)

corrplot(corr_matrix,
         method="circle")

dev.off()
#Wrapper Method

#Use stepwise regression for feature selection:
  
full_model <- lm(rating ~ userId + movieId, data = movie_data)

step_model <- step(full_model)

#View the selected attributes:
  
summary(step_model)