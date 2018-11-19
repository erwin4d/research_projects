Actual distances

Suppose we have X1, a n1 by p matrix with n1 observations and p parameters.
Suppose we have X2, a n2 by p matrix with n2 observations and p parameters.

Most Matlab files in this folder takes in X1, X2 as inputs, and outputs a dist_struct object with two fields. 

The first field is a distance matrix given by an n1 by n2 matrix D, where each (i,j)th entry of D gives the pairwise distance of choice between the ith observation of X1 and the jth observation of X2.

The second field is a string denoting the type of pairwise distance looked at.

Other functions in this folder may take in more parameters - see the derivations.pdf file for more information.


The code in this folder is used for several purposes, such as:
  - Part of implementation for nearest (or farthest) neighbours 
  - Comparing estimates of pairwise distances with true pairwise distance values


List of functions in this folder

  - get_pairwise_distances.m  
  - get_pairwise_distances_big.m

  - get_pairwise_squared_euclidean_distance.m
  - get_pairwise_euclidean_distance.m
  - get_pairwise_dot_product.m
  - get_pairwise_angular_distance.m
  - get_pairwise_squared_lp_even_distance.m
  - get_pairwise_lp_even_distance.m
  - get_pairwise_resemblance.m
  - get_pairwise_hamming_distance.m
  - get_pairwise_squared_lp_odd_distance.m
  - get_pairwise_lp_odd_distance.m
  - get_pairwise_l1_distance.m
  - get_pairwise_l_infinity_distance.m
  - get_pairwise_squared_lp_distance.m
  - get_pairwise_lp_distance.m
  - get_pairwise_jaccard_similarity.m


