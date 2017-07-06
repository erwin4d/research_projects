Generic random projection code
This folder shows the power of random projections in getting estimates of
Euclidean distances, inner products, and norms.

Angles, lp distances for even p to be added (much) later.

Types of random projection matrices worked with
 - N(0,1)
 - Rademacher
 - Sparse Bernoulli


This folder contains generic random projection code to demo the accuracy of random projections.

  - gen_typeof_R.m

This function allows the user to generate three types of random projection matrices for demonstration purposes. 

  - gen_typeof_V.m

This function allows the user to generate the V matrix (V := XR) for demonstration purposes.

  - compare_generic_norm_demo.m

This function plots the average RMSE of all estimated norms in the dataset with a pre-selected
random projection matrix. This is to allow the user to get a sense of the error in random projections.

 
  - compare_generic_pairwise_demo.m

This function plots the average RMSE of all estimated pairwise distances of choice (currently, Euclidean distances and inner products only) with a pre-selected random projection matrix. This is to allow the user to get a sense of the error in random projections.

  
  - get_true_vals.m

This function gets the true pairwise estimates of choice (currently, Euclidean distances and inner products only) given some matrix X.

  
  - get_V_ests_generic

This function gets the required estimated values before computing all pairwise RMSE for fixed kval and iteration number. 



- derivations.pdf

Shows the derivations of why scaling factor can be taken out for generic random projections

- Relevant papers 

Database Friendly Random Projections, Very Sparse Random Projections, and Improved Analysis of the Subsampled Randomized Hadamard Transform

They give some analysis and explanation on the types of random projections in this folder.

