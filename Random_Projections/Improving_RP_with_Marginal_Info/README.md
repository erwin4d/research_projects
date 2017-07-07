# Improving Random Projections with Marginal Information

This is a really cool paper by Li, Hastie, and Church using the likelihood function of bivariate normal to estimate the inner product. The relevant paper is included.

Matlab code is given here to demo this (compute all pairwise observations). The relevant functions are as follows

- li_MLE_IP_demo.m

This computes the average RMSE of the pairwise inner products for a dataset both using the ordinary method, and Li's method. The comparison is shown.


- cardano_fn.m

This computes the roots of Li's method using Cardano's formula. It may error for low values of K.

- li_vectorized_NR.m

This computes the roots of Li's method using Newton Raphson. It is vectorized. 


Note that not all datasets perform well with this method. If a dataset has many vectors which are close to uncorrelated, Li's method may not yield an improvement, or may even be worse than ordinary random projections. However, Li's method does give a substantial improvement for datasets in general.

Some good datasets to try this on: Arcene dataset, MNIST dataset.