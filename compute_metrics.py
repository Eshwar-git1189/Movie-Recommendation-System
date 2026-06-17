import json
import os
import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression, LogisticRegression
from sklearn.neighbors import KNeighborsClassifier
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score

RATINGS_PATH = 'data/ratings.csv'
MOVIES_PATH = 'data/movies.csv'
OUTPUT_PATH = 'outputs/results/metrics.json'

os.makedirs(os.path.dirname(OUTPUT_PATH), exist_ok=True)

ratings = pd.read_csv(RATINGS_PATH)
movies = pd.read_csv(MOVIES_PATH)
data = pd.merge(ratings, movies, on='movieId')
GENRES = ["Action", "Adventure", "Animation", "Children", "Comedy",
          "Crime", "Documentary", "Drama", "Fantasy", "Film.Noir",
          "Horror", "Musical", "Mystery", "Romance", "Sci.Fi",
          "Thriller", "War", "Western"]

for g in GENRES:
    data[g] = data['genres'].str.contains(g, regex=False).astype(int)

X = data[GENRES].values
y = data['rating'].values
liked = (y >= 4).astype(int)
n = len(data)

metrics = {}

# --- 1. Descriptive Statistics ---
metrics['std_dev'] = round(float(np.std(y, ddof=1)), 4)
metrics['variance'] = round(float(np.var(y, ddof=1)), 4)

# --- 2. PCA on Genre Features ---
centered = X - X.mean(axis=0)
cov = np.cov(centered.T)
evals, evecs = np.linalg.eigh(cov)
evals = evals[::-1]
prop_var = evals / evals.sum()
cum_var = np.cumsum(prop_var)
for i, label in enumerate(['pc1', 'pc2', 'pc3'], 1):
    metrics[f'{label}_var'] = round(float(prop_var[i - 1]), 4)
    metrics[f'{label}_cum'] = round(float(cum_var[i - 1]), 4)

# --- 3. Linear Regression ---
reg = LinearRegression().fit(X, y)
pred = reg.predict(X)
mae = float(np.mean(np.abs(y - pred)))
mse = float(np.mean((y - pred) ** 2))
rmse = float(np.sqrt(mse))
ss_res = float(np.sum((y - pred) ** 2))
ss_tot = float(np.sum((y - y.mean()) ** 2))
r2 = float(1 - ss_res / ss_tot)
metrics['reg_mae'] = round(mae, 4)
metrics['reg_mse'] = round(mse, 4)
metrics['reg_rmse'] = round(rmse, 4)
metrics['reg_r_squared'] = round(r2, 4)

# --- 4. Logistic Regression ---
lr = LogisticRegression(max_iter=200, random_state=42).fit(X, liked)
pred_lr = lr.predict(X)
metrics['lr_accuracy'] = round(accuracy_score(liked, pred_lr), 4)
metrics['lr_precision'] = round(precision_score(liked, pred_lr, zero_division=0), 4)
metrics['lr_recall'] = round(recall_score(liked, pred_lr, zero_division=0), 4)
metrics['lr_f1'] = round(f1_score(liked, pred_lr, zero_division=0), 4)

# --- 5. KNN (k=5, subset for speed) ---
rs = np.random.RandomState(42)
all_idx = np.arange(n)
rs.shuffle(all_idx)
train_n = min(20000, int(n * 0.8))
test_n = min(5000, n - train_n)
train_idx = all_idx[:train_n]
test_idx = all_idx[train_n:train_n + test_n]

scaler = StandardScaler()
X_train_s = scaler.fit_transform(X[train_idx])
X_test_s = scaler.transform(X[test_idx])

knn = KNeighborsClassifier(n_neighbors=5).fit(X_train_s, liked[train_idx])
pred_knn = knn.predict(X_test_s)
metrics['knn_accuracy'] = round(accuracy_score(liked[test_idx], pred_knn), 4)
metrics['knn_precision'] = round(precision_score(liked[test_idx], pred_knn, zero_division=0), 4)
metrics['knn_recall'] = round(recall_score(liked[test_idx], pred_knn, zero_division=0), 4)
metrics['knn_f1'] = round(f1_score(liked[test_idx], pred_knn, zero_division=0), 4)

# --- 6. Correlation: top 5 genres ---
corr_vals = np.array([np.corrcoef(y, X[:, i])[0, 1] for i in range(18)])
valid = ~np.isnan(corr_vals)
corr_vals_clean = corr_vals[valid]
genres_clean = [GENRES[i] for i in range(18) if valid[i]]
corr_abs = np.abs(corr_vals_clean)
top5_idx = np.argsort(corr_abs)[::-1][:5]
for rank, idx in enumerate(top5_idx, 1):
    metrics[f'top{rank}_genre'] = genres_clean[idx]
    metrics[f'top{rank}_cor'] = round(float(corr_vals_clean[idx]), 4)

# --- 7. Stepwise Regression (forward selection) ---
selected = []
remaining = list(range(18))
r2_current = 0.0
for _ in range(18):
    best_r2 = r2_current
    best_idx = None
    for idx in remaining:
        cols = selected + [idx]
        X_sub = X[:, cols]
        reg_sub = LinearRegression().fit(X_sub, y)
        r2_sub = reg_sub.score(X_sub, y)
        if r2_sub > best_r2:
            best_r2 = r2_sub
            best_idx = idx
    if best_idx is not None and best_r2 > r2_current + 1e-6:
        selected.append(best_idx)
        remaining.remove(best_idx)
        r2_current = best_r2
    else:
        break

selected_names = [GENRES[i] for i in selected]
metrics['selected_features'] = ', '.join(selected_names) if selected_names else 'None'
metrics['stepwise_r_squared'] = round(float(r2_current), 4)

with open(OUTPUT_PATH, 'w') as f:
    json.dump(metrics, f, indent=2)

for k, v in metrics.items():
    print(f'  {k}: {v}')
print(f'\nMetrics written to {OUTPUT_PATH}')
