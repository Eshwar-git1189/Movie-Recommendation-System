# Start Unit IV: Clustering

# Perform K-Means Clustering
kmeans_model <- kmeans(scaled_data, centers = 3)

# View clustering results
kmeans_model

# Number of observations in each cluster
kmeans_model$size

# Cluster assigned to each observation
head(kmeans_model$cluster)

# Load package for visualization
library(factoextra)

# K-Means Cluster Plot
png("outputs/plots/kmeans_cluster.png",
    width = 800,
    height = 600)

fviz_cluster(kmeans_model,
             data = scaled_data)

dev.off()

# Cluster Centers Plot
png("outputs/plots/cluster_centers.png",
    width = 800,
    height = 600)

plot(scaled_data[,1:2],
     col = kmeans_model$cluster,
     main = "K-Means with 3 Clusters")

points(kmeans_model$centers[,1:2],
       col = 1:3,
       pch = 8,
       cex = 3)

dev.off()