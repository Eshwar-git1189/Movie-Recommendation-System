# Start Unit IV: Frequent Pattern Mining

# Load the package
library(arules)

# Convert movie IDs watched by each user into transactions

movie_list <- split(movie_data$movieId,
                    movie_data$userId)

transactions <- as(movie_list,
                   "transactions")

# Display transaction summary

summary(transactions)

# ------------------------------
# Apriori Algorithm
# ------------------------------

rules <- apriori(transactions,
                 parameter = list(
                   supp = 0.1,
                   conf = 0.6,
                   maxlen = 3
                 ))

# Display generated rules

inspect(rules)

# ------------------------------
# Top 10 Rules by Confidence
# ------------------------------

top_rules <- sort(rules,
                  by = "confidence")[1:10]

inspect(top_rules)

# ------------------------------
# FP-Growth (Theory)
# ------------------------------

# FP-Growth is another frequent pattern mining algorithm.
# Unlike Apriori, FP-Growth avoids candidate generation
# and uses an FP-Tree structure to efficiently find
# frequent itemsets.

# This completes:

# ✓ Frequent Itemsets
# ✓ Minimum Support Threshold
# ✓ Apriori Algorithm
# ✓ FP-Growth (Theory)
# ✓ Association Rules

# ==================================================
# Create Results File
# ==================================================

sink("outputs/results/association_rules.md")

cat("# Association Rule Mining Results\n\n")

cat("## 1. Apriori Algorithm\n\n")

cat("### Parameters Used\n\n")

cat("- Minimum Support = 0.10\n")
cat("- Minimum Confidence = 0.60\n")
cat("- Maximum Length = 3\n")

cat("\n---\n\n")

cat("## Top 10 Association Rules (Sorted by Confidence)\n\n")

inspect(top_rules)

cat("\n---\n\n")

cat("## 2. FP-Growth (Theory)\n\n")

cat("FP-Growth (Frequent Pattern Growth) is an efficient frequent pattern mining algorithm.\n\n")

cat("Unlike Apriori, FP-Growth avoids candidate generation and uses an FP-Tree data structure to discover frequent itemsets efficiently.\n")

cat("\n---\n\n")

cat("## Interpretation\n\n")

cat("Association rule mining revealed patterns of movies frequently watched together by users.\n\n")

cat("The Apriori algorithm was used to discover these relationships and generate association rules.\n\n")

cat("Such patterns can be utilized in recommendation systems similar to Netflix and YouTube to improve content suggestions.\n")

cat("\n---\n\n")

cat("## Conclusion\n\n")

cat("Frequent pattern mining identified groups of movies that are commonly watched together.\n\n")

cat("Apriori was implemented to generate association rules, while FP-Growth was studied theoretically as an efficient alternative.\n")

sink()

cat("Results written to outputs/results/association_rules.md\n")