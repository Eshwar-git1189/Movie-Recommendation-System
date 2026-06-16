# Association Rule Mining Results

1. Apriori Algorithm

---

Parameters Used

Minimum Support = 0.10

Minimum Confidence = 0.60

Maximum Length = 3

Top Association Rules (Sorted by Confidence)

1.

{5952, 49272} => {7153}

Support = 0.1032787

Confidence = 1.0000

Lift = 3.2973

2.

{357, 377} => {356}

Support = 0.1098361

Confidence = 1.0000

Lift = 1.8541

3.

{1196, 60069} => {260}

Support = 0.1049180

Confidence = 1.0000

Lift = 2.4303

4.

{4993, 6934} => {7153}

Support = 0.1065574

Confidence = 1.0000

Lift = 3.2973

5.

{1196, 6934} => {260}

Support = 0.1032787

Confidence = 1.0000

Lift = 2.4303

6.

{260, 2985} => {1196}

Support = 0.1032787

Confidence = 1.0000

Lift = 2.8910

7.

{10, 597} => {356}

Support = 0.1081967

Confidence = 1.0000

Lift = 1.8541

8.

{1210, 2791} => {260}

Support = 0.1016393

Confidence = 1.0000

Lift = 2.4303

9.

{5952, 32587} => {4993}

Support = 0.1049180

Confidence = 1.0000

Lift = 3.0808

10.

{1196, 48516} => {260}

Support = 0.1032787

Confidence = 1.0000

Lift = 2.4303

2. Eclat Algorithm

---

Important Frequent Itemsets

{296,300,318}

Support = 0.1000

{300,356}

Support = 0.1000

{296,300}

Support = 0.1164

{292,380,457}

Support = 0.1164

{292,356,457}

Support = 0.1164

{434,380}

Support = 0.1426

{161,457}

Support = 0.1393

{356,454}

Support = 0.1377

These itemsets represent groups of movies frequently watched together.

3. Maximal Frequent Itemsets

---

Examples:

{296,300,318}

{110,208,292}

{165,292,457}

{292,316,380}

{150,292,457}

{292,380,457}

{349,454,457}

These are the largest frequent itemsets and do not have any frequent supersets.

4. Closed Frequent Itemsets

---

Closed itemsets were extracted from the Eclat results.

Examples include:

{292,356}

{292,296}

{434,380}

{454,457}

{161,457}

{356,454}

Closed frequent itemsets reduce redundancy while preserving support information.

## Interpretation

Association rule mining revealed patterns of movies frequently watched together by users. Apriori and Eclat algorithms were used to discover these relationships. Maximal and closed frequent itemsets helped identify meaningful combinations while minimizing redundancy. Such patterns can be utilized to improve recommendation systems similar to Netflix and YouTube.
