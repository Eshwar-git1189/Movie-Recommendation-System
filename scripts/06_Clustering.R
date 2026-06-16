#Start Unit IV: Clustering in a new file.

#First, perform K-Means Clustering on the scaled data created in 05_Preprocessing.R.

kmeans_model <- kmeans(scaled_data, centers = 3)

#View the clustering results:
  
kmeans_model

#See how many observations are in each cluster:

kmeans_model$size

#You can also view the cluster assigned to each observation:

head(kmeans_model$cluster)

#Visualize the K-Means clusters:
install.packages("factoextra")
library(factoextra)

png("outputs/plots/kmeans_cluster.png",
    width=800,
    height=600)

fviz_cluster(kmeans_model,
             data=scaled_data)

dev.off()

#This plot will show how the observations are grouped into the 3 clusters.



#Now perform DBSCAN Clustering.

#Load the package:
install.packages("dbscan")
library(dbscan)

#Run DBSCAN:
  
dbscan_model <- dbscan(scaled_data,
                       eps = 0.5,
                       minPts = 5)

#View the cluster assignments:

head(dbscan_model$cluster)

#See the number of points in each cluster:

table(dbscan_model$cluster)

#This completes the second clustering technique in Unit IV.



#Add Clustering Validation using the Silhouette Method:
  
library(cluster)

sil <- silhouette(kmeans_model$cluster,
                  dist(scaled_data))

png("outputs/plots/silhouette_plot.png",
    width=800,
    height=600)

plot(sil)

dev.off()


#The error:
  
  #cannot allocate vector of size 37.9 Gb

#occurs because:
  
  dist(scaled_data)

#tries to create a distance matrix for all ~100,000 rows, which requires enormous memory.

  
#Instead of using the entire dataset, take a sample:
  
set.seed(123)

sample_index <- sample(1:nrow(scaled_data), 5000)

sample_data <- scaled_data[sample_index, ]

#Now compute the silhouette:
  
library(cluster)

sil <- silhouette(
  kmeans(sample_data, centers = 3)$cluster,
  dist(sample_data)
)

plot(sil)