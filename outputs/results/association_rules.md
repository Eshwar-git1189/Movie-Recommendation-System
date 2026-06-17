# Association Rule Mining Results

## 1. Apriori Algorithm

### Parameters Used

- Minimum Support = 0.10
- Minimum Confidence = 0.60
- Maximum Length = 3

---

## Top 10 Association Rules (Sorted by Confidence)

     lhs              rhs    support   confidence coverage  lift     count
[1]  {5952, 49272} => {7153} 0.1032787 1          0.1032787 3.297297 63   
[2]  {357, 377}    => {356}  0.1098361 1          0.1098361 1.854103 67   
[3]  {1196, 60069} => {260}  0.1049180 1          0.1049180 2.430279 64   
[4]  {4993, 6934}  => {7153} 0.1065574 1          0.1065574 3.297297 65   
[5]  {1196, 6934}  => {260}  0.1032787 1          0.1032787 2.430279 63   
[6]  {260, 2985}   => {1196} 0.1032787 1          0.1032787 2.890995 63   
[7]  {10, 597}     => {356}  0.1081967 1          0.1081967 1.854103 66   
[8]  {1210, 2791}  => {260}  0.1016393 1          0.1016393 2.430279 62   
[9]  {5952, 32587} => {4993} 0.1049180 1          0.1049180 3.080808 64   
[10] {1196, 48516} => {260}  0.1032787 1          0.1032787 2.430279 63   

---

## 2. FP-Growth (Theory)

FP-Growth (Frequent Pattern Growth) is an efficient frequent pattern mining algorithm.

Unlike Apriori, FP-Growth avoids candidate generation and uses an FP-Tree data structure to discover frequent itemsets efficiently.

---

## Interpretation

Association rule mining revealed patterns of movies frequently watched together by users.

The Apriori algorithm was used to discover these relationships and generate association rules.

Such patterns can be utilized in recommendation systems similar to Netflix and YouTube to improve content suggestions.

---

## Conclusion

Frequent pattern mining identified groups of movies that are commonly watched together.

Apriori was implemented to generate association rules, while FP-Growth was studied theoretically as an efficient alternative.
