#Create a new file and start Frequent Pattern Mining (Apriori Algorithm).

#First, install and load the required package:

install.packages("arules")
library(arules)

#Then we'll prepare the data for association rule mining. Don't run Apriori yet.

#Convert movie IDs watched by each user into transactions:

movie_list <- split(movie_data$movieId, movie_data$userId)

transactions <- as(movie_list, "transactions")

#Check the transactions:

summary(transactions)


#Run the Apriori algorithm:

rules <- apriori(transactions,
               parameter = list(supp = 0.1,
                                conf = 0.6,
                                maxlen = 3))

#View the generated rules:

inspect(rules)

#View the top 10 rules sorted by confidence:

inspect(sort(rules, by = "confidence")[1:10])

#This completes the Apriori algorithm part of Frequent Pattern Mining.



#Eclat Algorithm
eclat_rules <- eclat(transactions,
                   parameter = list(supp = 0.1,
                                    maxlen = 3))

#View the frequent itemsets:

inspect(eclat_rules)


#FP-Growth
#The arules package does not implement FP-Growth. Since your syllabus only requires understanding and demonstration, you can mention FP-Growth theoretically in the report and presentation. If your instructor specifically asks for implementation, let me know and we'll use another package.

#Maximal Frequent Itemsets
#Extract maximal itemsets:

maximal_itemsets <- is.maximal(eclat_rules)

inspect(eclat_rules[maximal_itemsets])


#Closed Frequent Itemsets
#Extract closed itemsets:

closed_itemsets <- is.closed(eclat_rules)

inspect(eclat_rules[closed_itemsets])

#This completes the remaining topics of Unit IV:

#✅ Eclat
#✅ FP-Growth (Theory)
#✅ Maximal Frequent Itemsets
#✅ Closed Frequent Itemsets
#✅ Association Rules