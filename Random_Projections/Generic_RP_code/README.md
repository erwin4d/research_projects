# Generic random projection code

This folder contains generic random projection code to generate random projection matrices and to compute an estimated Euclidean distance / inner product / norms of respective vectors.

-  gen_typeof_R.m

Generates the type of random projection matrix required. Note: The SRHT here is not optimal. Will probably work on this to find the appropriate cutoff point for the recursion.

- gen_typeof_V.m

Creates V = XR, without the scaling factor, since we can always scale the estimates later and avoid a pesky square root.

- compute_generic_all_norm.m ; compute_generic_ED.m ; compute_generic_IP.m

Computes the estimates / actual norms, Euclidean distances, and inner products. 

- derivations.pdf

Shows the derivations of why scaling factor can be taken out for generic random projections

- Relevant papers 

Database Friendly Random Projections, Very Sparse Random Projections, and Improved Analysis of the Subsampled Randomized Hadamard Transform

They give some analysis and explanation on the types of random projections in this folder.
