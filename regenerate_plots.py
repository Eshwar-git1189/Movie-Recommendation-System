import os
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

RATINGS_PATH = 'data/ratings.csv'
MOVIES_PATH = 'data/movies.csv'
PLOTS_DIR = 'outputs/plots'
os.makedirs(PLOTS_DIR, exist_ok=True)

ratings = pd.read_csv(RATINGS_PATH)
movies = pd.read_csv(MOVIES_PATH)
data = pd.merge(ratings, movies, on='movieId')

GENRES = ["Action", "Adventure", "Animation", "Children", "Comedy",
          "Crime", "Documentary", "Drama", "Fantasy", "Film.Noir",
          "Horror", "Musical", "Mystery", "Romance", "Sci.Fi",
          "Thriller", "War", "Western"]

for g in GENRES:
    data[g] = data['genres'].str.contains(g, regex=False).astype(int)

ratings_arr = data['rating'].values
genre_data = data[GENRES].values
n = len(data)

plt.rcParams['font.family'] = 'serif'
plt.rcParams['font.size'] = 11

# 1. Histogram of Ratings
plt.figure(figsize=(8, 6))
plt.hist(ratings_arr, bins=9, range=(0.5, 5.5), color='lightblue', edgecolor='black', rwidth=0.85)
plt.title('Distribution of Ratings', fontsize=14)
plt.xlabel('Rating', fontsize=12)
plt.ylabel('Count', fontsize=12)
plt.grid(axis='y', alpha=0.3)
plt.tight_layout()
plt.savefig(f'{PLOTS_DIR}/histogram_ratings.png', dpi=100)
plt.close()
print('Saved histogram_ratings.png')

# 2. Boxplot of Ratings
plt.figure(figsize=(6, 6))
plt.boxplot(ratings_arr, patch_artist=True, boxprops=dict(facecolor='orange', alpha=0.7))
plt.title('Boxplot of Ratings', fontsize=14)
plt.ylabel('Rating', fontsize=12)
plt.grid(axis='y', alpha=0.3)
plt.tight_layout()
plt.savefig(f'{PLOTS_DIR}/boxplot_ratings.png', dpi=100)
plt.close()
print('Saved boxplot_ratings.png')

# 3. Bar Plot of Rating Frequencies
plt.figure(figsize=(8, 6))
counts = pd.Series(ratings_arr).value_counts().sort_index()
plt.bar(counts.index, counts.values, color='lightgreen', edgecolor='black', width=0.6)
plt.title('Frequency of Ratings', fontsize=14)
plt.xlabel('Rating', fontsize=12)
plt.ylabel('Count', fontsize=12)
plt.grid(axis='y', alpha=0.3)
plt.tight_layout()
plt.savefig(f'{PLOTS_DIR}/barplot_ratings.png', dpi=100)
plt.close()
print('Saved barplot_ratings.png')

# 4. PCA Scree Plot
centered = genre_data - genre_data.mean(axis=0)
cov = np.cov(centered.T)
evals, evecs = np.linalg.eigh(cov)
evals = evals[::-1]
prop_var = evals / evals.sum()

plt.figure(figsize=(8, 6))
plt.plot(range(1, 19), prop_var, 'bo-', linewidth=2, markersize=6)
plt.axhline(y=0.05, color='red', linestyle='--', alpha=0.5, label='5% threshold')
plt.title('Scree Plot - Genre PCA', fontsize=14)
plt.xlabel('Principal Component', fontsize=12)
plt.ylabel('Proportion of Variance Explained', fontsize=12)
plt.legend()
plt.grid(alpha=0.3)
plt.tight_layout()
plt.savefig(f'{PLOTS_DIR}/scree_plot.png', dpi=100)
plt.close()
print('Saved scree_plot.png')

# 5. PCA Biplot
scores = centered @ evecs[:, :2]
loadings = evecs[:, :2]

plt.figure(figsize=(10, 8))
plt.scatter(scores[:, 0], scores[:, 1], alpha=0.1, s=5, c='gray')
for i, g in enumerate(GENRES):
    plt.arrow(0, 0, loadings[i, 0] * 3, loadings[i, 1] * 3,
              color='red', alpha=0.7, head_width=0.05)
    plt.text(loadings[i, 0] * 3.2, loadings[i, 1] * 3.2, g,
             fontsize=9, ha='center', va='center', color='darkred')
plt.title('PCA Biplot - Genre Components', fontsize=14)
plt.xlabel(f'PC1 ({prop_var[0]*100:.1f}%)', fontsize=12)
plt.ylabel(f'PC2 ({prop_var[1]*100:.1f}%)', fontsize=12)
plt.grid(alpha=0.3)
plt.tight_layout()
plt.savefig(f'{PLOTS_DIR}/pca_biplot.png', dpi=100)
plt.close()
print('Saved pca_biplot.png')

# 6. K-Means Cluster Plot (reduced to 2D via PCA for visualization)
from sklearn.cluster import KMeans

movie_avg = data.groupby('movieId')['rating'].mean().reset_index()
movie_avg.columns = ['movieId', 'avg_rating']
rating_counts = data.groupby('movieId').size().reset_index(name='rating_count')
movie_genres = data[['movieId'] + GENRES].drop_duplicates('movieId')
movie_level = movie_avg.merge(rating_counts, on='movieId').merge(movie_genres, on='movieId')

cluster_feats = movie_level[['avg_rating', 'rating_count'] + GENRES].values
scaled = (cluster_feats - cluster_feats.mean(axis=0)) / cluster_feats.std(axis=0)
scaled = np.nan_to_num(scaled, nan=0.0)

kmeans = KMeans(n_clusters=3, n_init=25, random_state=42)
labels = kmeans.fit_predict(scaled)

# PCA for 2D visualization
cov_c = np.cov(scaled.T)
evals_c, evecs_c = np.linalg.eigh(cov_c)
evals_c = evals_c[::-1]
evecs_c = evecs_c[:, ::-1]
scores_c = scaled @ evecs_c[:, :2]

colors = ['red', 'blue', 'green']
plt.figure(figsize=(10, 8))
for i in range(3):
    mask = labels == i
    plt.scatter(scores_c[mask, 0], scores_c[mask, 1],
                c=colors[i], label=f'Cluster {i+1}', alpha=0.5, s=8)
centers_2d = kmeans.cluster_centers_ @ evecs_c[:, :2]
plt.scatter(centers_2d[:, 0], centers_2d[:, 1],
            c=colors, marker='X', s=200, edgecolors='black', linewidths=2, label='Centers')
plt.title('K-Means Clustering of Movies (k = 3)', fontsize=14)
plt.xlabel('PC1', fontsize=12)
plt.ylabel('PC2', fontsize=12)
plt.legend(fontsize=10)
plt.grid(alpha=0.3)
plt.tight_layout()
plt.savefig(f'{PLOTS_DIR}/kmeans_cluster.png', dpi=100)
plt.close()
print('Saved kmeans_cluster.png')

# 7. Cluster Centers Bar Plot
means_df = pd.DataFrame(kmeans.cluster_centers_, columns=['avg_rating', 'rating_count'] + GENRES)
x = np.arange(len(GENRES) + 2)
width = 0.25
plt.figure(figsize=(14, 6))
for i in range(3):
    plt.bar(x + i * width, means_df.iloc[i], width, label=f'Cluster {i+1}', alpha=0.7)
plt.xticks(x + width, means_df.columns, rotation=45, ha='right', fontsize=9)
plt.title('Cluster Centers by Feature', fontsize=14)
plt.ylabel('Mean Value (scaled)', fontsize=12)
plt.legend(fontsize=10)
plt.grid(axis='y', alpha=0.3)
plt.tight_layout()
plt.savefig(f'{PLOTS_DIR}/cluster_centers.png', dpi=100)
plt.close()
print('Saved cluster_centers.png')

# 8. Regression Scatter Plot (Actual vs Predicted)
X = np.column_stack([np.ones(n), genre_data])
beta = np.linalg.lstsq(X, ratings_arr, rcond=None)[0]
pred = X @ beta

plt.figure(figsize=(8, 8))
plt.scatter(ratings_arr, pred, alpha=0.1, s=3, c='blue')
plt.plot([0.5, 5.5], [0.5, 5.5], 'r--', linewidth=2, label='Perfect Prediction')
plt.title('Actual vs Predicted Ratings', fontsize=14)
plt.xlabel('Actual Rating', fontsize=12)
plt.ylabel('Predicted Rating', fontsize=12)
plt.xlim(0.5, 5.5)
plt.ylim(0.5, 5.5)
plt.legend(fontsize=10)
plt.grid(alpha=0.3)
plt.gca().set_aspect('equal')
plt.tight_layout()
plt.savefig(f'{PLOTS_DIR}/scatter_plot.png', dpi=100)
plt.close()
print('Saved scatter_plot.png')

# 9. Residual Plot
resid = ratings_arr - pred
plt.figure(figsize=(8, 6))
plt.scatter(pred, resid, alpha=0.1, s=3, c='darkgreen')
plt.axhline(y=0, color='red', linestyle='-', linewidth=2)
plt.title('Residual Plot - Genre Regression', fontsize=14)
plt.xlabel('Predicted Ratings', fontsize=12)
plt.ylabel('Residuals', fontsize=12)
plt.grid(alpha=0.3)
plt.tight_layout()
plt.savefig(f'{PLOTS_DIR}/residual_plot.png', dpi=100)
plt.close()
print('Saved residual_plot.png')

# 10. Correlation Matrix Heatmap
from sklearn.cluster import KMeans as _  # already imported above

corr_cols = ['rating'] + GENRES
corr_matrix = data[corr_cols].corr().values

plt.figure(figsize=(10, 9))
plt.imshow(corr_matrix, cmap='RdBu_r', vmin=-0.3, vmax=0.3, aspect='auto')
plt.colorbar(label='Correlation')
plt.xticks(range(19), corr_cols, rotation=45, ha='right', fontsize=8)
plt.yticks(range(19), corr_cols, fontsize=8)
for i in range(19):
    for j in range(19):
        val = corr_matrix[i, j]
        color = 'white' if abs(val) > 0.15 else 'black'
        plt.text(j, i, f'{val:.2f}', ha='center', va='center', fontsize=6, color=color)
plt.title('Correlation Matrix - Rating and Genres', fontsize=14)
plt.tight_layout()
plt.savefig(f'{PLOTS_DIR}/correlation_matrix.png', dpi=100)
plt.close()
print('Saved correlation_matrix.png')

print('\nAll 10 plots regenerated.')
