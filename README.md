# Movie Recommendation System Using Data Analytics Lifecycle

## Project Overview

This project demonstrates the application of the Data Analytics Lifecycle using the MovieLens dataset to simulate a Netflix/YouTube recommendation system. Various data analytics techniques were implemented in R to analyze movie genres, user preferences, discover patterns, and build predictive models.

---

## Dataset

Dataset: **MovieLens Latest Small**

Files used:
- `ratings.csv`
- `movies.csv`

---

## Project Structure

### 01_Data_Import.R
Imported the MovieLens dataset into RStudio.

**Purpose:** To load raw data for analysis.

---

### 02_Data_Merge.R
Merged `ratings.csv` and `movies.csv` using `movieId`.

**Purpose:** To create a single dataset containing user ratings, movie information, and genres.

---

### 03_Data_Cleaning.R
Performed:
- Missing value analysis
- Duplicate checking
- Data type verification

**Purpose:** To ensure data quality before analysis.

---

### 04_Genre_Extraction.R
Parsed the pipe-separated `genres` column and created 18 binary indicator columns (Action, Adventure, Animation, etc.).

**Purpose:** To convert genre information into numerical features suitable for modeling.

---

### 05_Descriptive_Statistics.R
Performed:
- Mean, Median, Variance, Standard deviation

Generated:
- Histogram
- Boxplot
- Bar plot

**Purpose:** To understand the distribution of movie ratings.

---

### 06_Preprocessing.R
Performed:
- Genre-based Principal Component Analysis (PCA)
- Movie-level data aggregation (avg rating, rating count, genre features)

Generated:
- Scree plot
- PCA biplot

**Purpose:** To reduce dimensionality and create movie-level features for clustering.

---

### 07_Clustering.R
Implemented:
- K-Means Clustering on movie-level features

**Purpose:** To group similar movies by their rating profile and genre composition.

---

### 08_Association_Rules.R
Implemented:
- Apriori Algorithm
- FP-Growth (Theory)

**Purpose:** To discover frequently co-occurring movies and user viewing patterns.

---

### 09_Regression.R
Implemented:
- Linear Regression using genre features as predictors

Performance Metrics:
- MAE, MSE, RMSE, R-squared

**Purpose:** To predict movie ratings based on genre composition.

---

### 10_Classification.R
Implemented:
- Logistic Regression (genre-based)
- K-Nearest Neighbors (KNN) (genre-based)

Performance Metrics:
- Accuracy, Precision, Recall, F1-score

**Purpose:** To classify whether users liked a movie using genre features.

---

### 11_Statistical_Tests.R
Performed:
- t-test
- Wilcoxon Rank-Sum Test
- ANOVA (genre-based)

**Purpose:** To test statistical significance and compare rating groups.

---

### 12_Attribute_Selection.R
Implemented:
- Filter Method (correlation analysis with genres)
- Wrapper Method (stepwise regression with genres)

**Purpose:** To identify which genres are most important for predicting ratings.

---

## Execution Order

Run scripts in numerical order (01 through 12). Each script depends on the output of previous scripts. The genre extraction script (04) must run before any analysis scripts (06-12).

### Helper Script

- `_write_metrics.R` — Shared helper sourced by scripts 05, 06, 09, 10, 12 to write computed metrics to `outputs/results/metrics.json`.

### Regenerating the Report

After running all R scripts, regenerate the DOCX report with:

```bash
python gen_report.py
```

The script reads `outputs/results/metrics.json` (written by R scripts 05, 06, 09, 10, 12) to populate metric values. If the JSON file is missing, it falls back to placeholder text.

## Conclusion

This project demonstrates the complete Data Analytics Lifecycle using a recommendation system scenario. Techniques including descriptive statistics, PCA, clustering, association rule mining, regression, classification, statistical testing, and attribute selection were applied to derive meaningful insights from the MovieLens dataset using genre-based features.
