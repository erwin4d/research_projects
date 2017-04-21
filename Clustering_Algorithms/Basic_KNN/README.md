# K nearest neighbors

This folder contains generic K nearest neighbors code, which computes K nearest neighbors for training / testing datasets. Code computes lp distances. Most of this code is inspired by BTRY 6520 (Computationally Intensive Statistical Methods) when it was taught in Fall 2012.

The matlab code in this folder is relatively unoptimized.

 - basic_KNN.m
 
 Runs basic KNN to get a list of labels 

 - compute_LP_normal_basic.m

 Helper function which computes the LP distance for non integer p / odd p (relatively unoptimized)
 
 - compute_LP_split_basic.m

 Helper function which computes the LP distance for even p. Uses vectorization to speed things up a bit.

 - RP_KNN_demo.m

 Runs basic KNN with some randomly projected data. Datasets are not provided, but can be found at the UCI machine learning repository, or otherwise.

 - load_MNIST.m ; loadMNISTImages.m ; loadMNISTLabels.m

 Helper functions to load MNIST data, taken from http://ufldl.stanford.edu/wiki/index.php/Using_the_MNIST_Dataset

