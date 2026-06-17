# Association Rule Mining Results

## 1. Apriori Algorithm

---

### Parameters Used

* Minimum Support = 0.10
* Minimum Confidence = 0.60
* Maximum Length = 3

---

## Top 10 Association Rules (Sorted by Confidence)

### Rule 1

**{5952, 49272} ⇒ {7153}**

* Support = 0.1032787
* Confidence = 1.0000
* Lift = 3.2973

### Rule 2

**{357, 377} ⇒ {356}**

* Support = 0.1098361
* Confidence = 1.0000
* Lift = 1.8541

### Rule 3

**{1196, 60069} ⇒ {260}**

* Support = 0.1049180
* Confidence = 1.0000
* Lift = 2.4303

### Rule 4

**{4993, 6934} ⇒ {7153}**

* Support = 0.1065574
* Confidence = 1.0000
* Lift = 3.2973

### Rule 5

**{1196, 6934} ⇒ {260}**

* Support = 0.1032787
* Confidence = 1.0000
* Lift = 2.4303

### Rule 6

**{260, 2985} ⇒ {1196}**

* Support = 0.1032787
* Confidence = 1.0000
* Lift = 2.8910

### Rule 7

**{10, 597} ⇒ {356}**

* Support = 0.1081967
* Confidence = 1.0000
* Lift = 1.8541

### Rule 8

**{1210, 2791} ⇒ {260}**

* Support = 0.1016393
* Confidence = 1.0000
* Lift = 2.4303

### Rule 9

**{5952, 32587} ⇒ {4993}**

* Support = 0.1049180
* Confidence = 1.0000
* Lift = 3.0808

### Rule 10

**{1196, 48516} ⇒ {260}**

* Support = 0.1032787
* Confidence = 1.0000
* Lift = 2.4303

---

## 2. FP-Growth (Theory)

FP-Growth (Frequent Pattern Growth) is an efficient frequent pattern mining algorithm used to discover associations among items. Unlike Apriori, FP-Growth avoids candidate generation and uses an FP-Tree data structure to find frequent itemsets more efficiently.

---

## Interpretation

Association rule mining revealed patterns of movies frequently watched together by users. The Apriori algorithm was used to discover these relationships and generate association rules. Such patterns can be utilized in recommendation systems similar to Netflix and YouTube to improve content suggestions and enhance user experience.

---

## Conclusion

Frequent pattern mining identified groups of movies that are commonly watched together. Apriori was implemented to generate association rules, while FP-Growth was studied theoretically as an efficient alternative. These techniques form the basis of recommendation systems used by streaming platforms.
