# K-Means Clustering Results

## Number of Clusters

- Number of clusters used: 3

---

## Cluster Sizes

| Cluster | Number of Movies |
|---------|----------------:|
| 1 | 944 |
| 2 | 5758 |
| 3 | 3022 |

---

## Cluster Centers

  avg_rating rating_count  Action Adventure Animation Children  Comedy   Crime
1     0.0038       0.0468 -0.0311    0.8778    2.2881   2.5052  0.2299 -0.3164
2     0.1253      -0.1117 -0.3376   -0.2348   -0.2522  -0.2700  0.2528 -0.1841
3    -0.2398       0.1982  0.6529    0.1731   -0.2341  -0.2681 -0.5535  0.4497
  Documentary   Drama Fantasy Film.Noir  Horror Musical Mystery Romance  Sci.Fi
1     -0.2070 -0.5906  0.8530   -0.0939 -0.2778  0.3883 -0.1333 -0.2791  0.1262
2      0.1471  0.2011 -0.1483   -0.0752 -0.2643  0.0294 -0.1897  0.2295 -0.2592
3     -0.2156 -0.1987  0.0161    0.1727  0.5904 -0.1774  0.4032 -0.3501  0.4544
  Thriller     War Western
1  -0.4696 -0.1692 -0.0833
2  -0.4664  0.0934  0.0416
3   1.0354 -0.1252 -0.0532

---

## Sample Movies from Each Cluster

### Cluster 1

                 title avg_rating rating_count
1     Toy Story (1995)   3.920930          215
2       Jumanji (1995)   3.431818          110
8  Tom and Huck (1995)   2.875000            8
13        Balto (1995)   3.125000            8
27 Now and Then (1995)   3.333333            9
33         Babe (1995)   3.652344          128

### Cluster 2

                                title avg_rating rating_count
3             Grumpier Old Men (1995)   3.259615           52
4            Waiting to Exhale (1995)   2.357143            7
5  Father of the Bride Part II (1995)   3.071429           49
7                      Sabrina (1995)   3.185185           54
11     American President, The (1995)   3.671429           70
12 Dracula: Dead and Loving It (1995)   2.421053           19

### Cluster 3

                     title avg_rating rating_count
6              Heat (1995)   3.946078          102
9      Sudden Death (1995)   3.125000           16
10        GoldenEye (1995)   3.496212          132
15 Cutthroat Island (1995)   3.000000           13
20      Money Train (1995)   2.500000           15
21       Get Shorty (1995)   3.494382           89

---

## Visualizations

- K-Means Cluster Plot (`kmeans_cluster.png`)
- Cluster Centers Plot (`cluster_centers.png`)

---

## Interpretation

K-Means clustering was performed using average rating, rating count, and genre indicators.

Movies were grouped into three clusters based on their similarities.

Cluster centers represent the average feature values of each cluster and help understand the characteristics of the movies in each group.
