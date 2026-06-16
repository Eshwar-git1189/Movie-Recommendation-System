# Netflix/YouTube Recommendation System using Data Analytics Lifecycle

## Project Overview

This project demonstrates the application of the Data Analytics Lifecycle using the MovieLens dataset to simulate a Netflix/YouTube recommendation system. Various data analytics techniques were implemented in R to analyze user preferences, discover patterns, and build predictive models.

---

## Dataset

Dataset: **MovieLens Latest Small**

Files used:

* `ratings.csv`
* `movies.csv`

---

## Project Structure

### 01_Data_Import.R

Imported the MovieLens dataset into RStudio.

**Purpose:**
To load raw data for analysis.

---

### 02_Data_Merge.R

Merged `ratings.csv` and `movies.csv` using `movieId`.

**Purpose:**
To create a single dataset containing user ratings, movie information, and genres.

---

### 03_Data_Cleaning.R

Performed:

* Missing value analysis
* Duplicate checking
* Data type verification

**Purpose:**
To ensure data quality before analysis.

---

### 04_Descriptive_Statistics.R

Performed:

* Mean
* Median
* Variance
* Standard deviation

Generated:

* Histogram
* Boxplot
* Bar plot

**Purpose:**
To understand the distribution of movie ratings.

---

### 05_Preprocessing.R

Performed:

* Data scaling
* Principal Component Analysis (PCA)

Generated:

* Scree plot
* PCA biplot

**Purpose:**
To reduce dimensionality and analyze relationships among variables.

---

### 06_Clustering.R

Implemented:

* K-Means Clustering
* DBSCAN
* Silhouette Analysis

**Purpose:**
To group similar observations and validate clusters.

---

### 07_Association_Rules.R

Implemented:

* Apriori Algorithm
* Eclat Algorithm
* Maximal Frequent Itemsets
* Closed Frequent Itemsets
* Association Rules

**Purpose:**
To discover frequently co-occurring movies and user viewing patterns.

---

### 08_Regression.R

Implemented:

* Linear Regression

Performance Metrics:

* MAE
* MSE
* RMSE
* R²

**Purpose:**
To predict movie ratings and evaluate model performance.

---

### 09_Classification.R

Implemented:

* Logistic Regression
* K-Nearest Neighbors (KNN)
* Naive Bayes

Performance Metrics:

* Accuracy
* Precision
* Recall
* F1-score

**Purpose:**
To classify whether users liked a movie.

---

### 10_Statistical_Tests.R

Performed:

* t-test
* Wilcoxon Rank-Sum Test
* ANOVA

**Purpose:**
To test statistical significance and compare groups.

---

### 11_Attribute_Selection.R

Implemented:

* Filter Method
* Wrapper Method

**Purpose:**
To identify important variables for model building.

---

## Conclusion

This project demonstrates the complete Data Analytics Lifecycle using a recommendation system scenario. Techniques including descriptive statistics, PCA, clustering, association rule mining, regression, classification, statistical testing, and attribute selection were applied to derive meaningful insights from the MovieLens dataset.
