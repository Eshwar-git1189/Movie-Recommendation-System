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