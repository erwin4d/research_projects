# Random Projections With Control Variates

This was a paper (Random Projection with Control Variates) submitted to ICPRAM 2017 (February). An extended version was written (Control Variates as a Variance Reduction Technique for Random Projections) as well, but there doesn't seem to be any indication if it has been accepted...

In this folder, there is code to do more extensive experiments (compute RMSE of all pairwise distances of inner products and Euclidean distances on normalized data), so as to get a sense of how control variates perform, rather than showing how well it does on certain pairs of vectors.

# tl;dr summary of control variates

The graph on Page 11 (Control Variates as a Variance Reduction Technique for Random Projections) show how control variates perform for the Euclidean distance and inner product respectively.

As vectors are far apart, control variates for Euclidean distances perform well. You can use the code provided to try this on datasets where vectors are far apart.

While the control variate correction is in terms of a, using an estimate of the inner product (even the ordinary random projection estimate) can provide better variance reduction, rather than computing the empirical control variate correction.

As vectors are correlated, control variates for inner products perform well. You can use the code provided to try this on datasets where vectors are corelated. 

Again, while the control variate correction is in terms of a, using an estimate of the inner product (even the ordinary random projection estimate - which we have to compute anyway!) can provide a better variance reduction, rather than computing the empirical control variate correction.


# Why is this useful?

For Euclidean distances, consider complete linkage clustering (this looks at the furthest distance between two clusters). Control variates improves this distance estimate. 

For inner products, consider similarity detection (vectors which are correlated). Control variates improve the inner product estimate.

