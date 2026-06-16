#Select the numeric columns:
numeric_data <- movie_data[, c("userId", "movieId", "rating")]
print(numeric_data)
  
# Standardize them:
scaled_data <- scale(numeric_data)
print(scaled_data)
  
# Verify the result:
head(scaled_data)

#This completes the first step of preprocessing. We'll use scaled_data for subsequent analyses.

#Perform Principal Component Analysis (PCA) on the scaled data:
  pca_model <- prcomp(scaled_data)
#View the summary:
  summary(pca_model)
#See how much variance each principal component explains:
  pca_model$sdev^2 / sum(pca_model$sdev^2)
#This starts the dimensionality reduction part of Unit III. We'll visualize the principal components next.
  
  
#Visualize the PCA results.

#Scree Plot
  png("outputs/plots/scree_plot.png",
      width=800,
      height=600)
  
  plot(pca_model,
       type="l",
       main="Scree Plot")
  
  dev.off()
#Biplot
  png("outputs/plots/pca_biplot.png",
      width=800,
      height=600)
  
  biplot(pca_model)
  
  dev.off()  
  #These plots help you understand how much information is captured by the principal components and are useful for your report and PPT.