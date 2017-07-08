#########################################################
################### BTRY 3520 ###########################
################## Homework 2 ###########################
############# Due: March 10, 2017 #########################
#########################################################


# Instructions: save this file in the format <NetID>_HW2.R. 
# Complete each question using code below the question number.
# You need only upload this file to CMS. 

# Note, we assume your working directory contains any files
# that accompany this one. 

# Further note: 10% will be deducted if your file produces
# an error when run. If your code produces an error and you 
# cannot find it, comment out that portion of the code and we
# will give partial credit for it. 

# Do not use the function set.seed() or rm(list=ls())
# or setwd() in your code. 

#########################################
# Question 1:  Solving Linear Equations #
#########################################


# In this question you will write a program to solve the matrix 
# equation 
#
#            A x = b                                    (1)
#
# for x.  
#
# The answer to the question will be a single program

# NOTE: you may not use the solve() command for this question. 

LinSolve = function(A,b){

  return(x)
}

# but there are several requirements of it that we will check. 
# We recommend that you build it up to fit each requirement in turn.

# The methods we use below are not the most efficient or statistically
# stable, but they are fairly direct. 

# A) Recall that you can solve (1) manually by diagnonalizing A. 
# That is, you 
#
#   -  Divide the first row A[1,] and b[1] by A[1,1] so the diagonal
#      is 1. 
#
#   -  Subtract A[i,1]*A[1,] and A[i,1]*b[1] from A[i,] and b[i] 
#      respectively for each i. 
#      
#      You should find that the new A has first column which is zeros
#      apart from A[1,1] = 1. 
#
#   -  Repeat this for each column j, to make A[,j] all zeros except for
#      A[j,j] = 1  (doing the same operations to b). 
#
#  In the end you should have a new equation I x = b where I is the identity 
#  matrix and therefore x solves Ax = b since we performed the same operations
#  on each side of the equation. Return the value of x. 

# NOTE: you may break this up into several sub-functions and put those functions
# together. This will not affect the autograder. We strongly recommend 
# parceling this code into smaller chunks. 

#  Write a program that implements this algorithm. Use it to test

A1 = matrix(1:5,4,4) 
b = 1:4

# (this will give you a warning matrix, but the matrix A is what we intend)


# B) The user of LinSolve may mistakenly try and use it with matrices whose 
# dimensions don't match. Make sure you check the dimensions of the inputs and 
# return and error message 'Dimensions do not match', if you cannot solve the system. 




# C) Make sure your system can accept a matrix A that has more columns than rows. With
# l rows and k columns, you can identify the first l values of x, but set the remaining
# k-l values of x to zero. (Ensure this is still a solutions to the equation). Technically 
# this  is solving a generalized inverse. 
#
# Try it with the following example 

A4 = A1[-1,]
b2 = 2:4

# D) Check that your function will allow b to be replaced by a matrix B, where you
# performn your operations on rows of B. Show that using 

B = diag(4)
X = LinSolve(A1,B)

# yeilds X being the inverse of A. 


# BONUS: Try the algorithm with the input

A2 = A1
A2[4,] = c(4,7,5,8)

# What goes wrong? Modify your function so that if it finds A[j,j] = 0, it looks down  
# the remaining rows of A and finds A[k,j] (with k > j) that is not zero. It then swaps
# rows k and j (and b[k] and b[j]) uses the "new" A[j,j] to zero out the remainder of the
# column. If all the A[k,j] = 0, it lets x[j] = 0 and b[j] = 0 and continues. 

# Also try

A3 = A1
A3[3,] = c(4,11,13,10)



#################################################################
# Question 2:  Vectorization  and the Nadaraya-Watson Estimator #
#################################################################

# There are times when a data set clearly exhibits more complex behavior 
# than linear regression, or even a quadratic curve. In such cases, we often 
# turn to non-parametric methods. In this case, we will look at the Nadaraya-Watson 
# estimator.

# This estimator is defined by a _weighted_ average. If we have data Y_1,...,Y_n
# and weights w_1,...w_n, the weighted average is
#
#     Y_w =  sum(w_i Y_i)/sum(w_i)
#
# so that the weight for each Y_i is  w_i/sum(w_i), and these sum to 1. 

# For our estimator, we have data pairs (X_i,Y_i) and want to plot the relationship
# between these two. We think of this as being interested in the value of y at 
# some new point x. To get this, we weight each Y_i by how far X_i is from x: the closer
# X_i, the higher the weight is. 

# In the function below, we say that the weight decays like a normal distribution does
# away from x and set (with an unpardonable mixing of R and math notation)
#  
#     w_i(x) = dnorm(x,mean=X_i,sd=sigma)
#
# where sigma controls how quickly points far from x decay. 

# An function to calculate this Nadaraya-Watson estimator is given below. 


NadarayaWatson = function(x,X,Y,sigma){
  # x = point to evaluate our estimate.
  # X = vector of observation X values
  # Y = vector of observation Y values
  # sigma = standard deviation of the normal kernel.

  # Set up some arrays to hold results
  weights = rep(0,length(X))  # vector of weights
  sumweights = 0              # sum of the weights
  smooth = 0                  # value of the smooth

  for(i in 1:length(X)){
    # Calculate current weight
    weights[i] = dnorm(x,mean=X[i],sd=sigma)

    # Add weight to the sum
    sumweights = sumweights + weights[i]

    # Add weighted Y[i] to current value
    smooth = smooth + weights[i]*Y[i]
  }

  # Now divide by the sum of the weights
  return( smooth/sumweights )
}

# To explore this, we also use the data in 

data = read.csv('Rupert.csv')

# which gives the average precipitation on each day of the year in 
# Prince Rupert, British Columbia. The first column indicates days
# of the year and are listed half-way through the day. 


# A) Write a function that takes a data set, X and Y and a vector x of 
# places to make a prediction using NadarayaWatson(). If x is not given, 
# it should generate an x with 101 equally spaced points over the range of X. It should 
# return both x and the corresponding values of of the Nadaraya-Watson smoother. 

# The output should be a list with elements xseq and ypred giving these two
# values

NadarayaWatsonVec = function(x=NULL,X,Y,sigma){


}

# Test this on the data with sigma set to 10:

datapred = NadarayaWatsonVec(X=data$day,Y=data$rainfall,sigma=10)

# It might help to plot this up

plot(data$day,data$rainfall,xlab='Day',ylab='Precipitation')
lines(datapred$xseq,datapred$ypred)


# B) Re-write NadarayWatson to produce a new function to replace 
# NadarayaWatsonVec() which uses as few for loops as possible and
# no apply statements. It should have the same input and output as 
# NadarayaWatsonVec. 

NadarayaWatson2 = function(x=NULL,X,Y,sigma){


}

# Test the the comparison in computational speed with

start = proc.time()
datapred1 = NadarayaWatsonVec(datapred$xseq,data$day,data$rainfall,sigma=10)
time1 = proc.time()-start

start = proc.time()
datapred2 = NadarayaWatson2(datapred$xseq,data$day,data$rainfall,sigma=10)
time2 = proc.time()-start


# C) Write a function that takes X, Y and a vector of values of sigma and
# produces a plot containing the data and lines for the smooth with each
# value of sigma. Return a list containing xvec -- the 101 xpoints in
# the plot and ymat -- 101-by-k matrix giving the values to plot for each
# value of sigma

PlotNW = function(X,Y,sigmavec){


  return(list(xvec=xvec,ymat=ymat))
}

# and labels the graph to indicate which line corresponds to which sigma. 
# Test this with 

sigmavec = c(2,10,20,50)

PlotNW(data$day,data$rainfall,sigmavec)

# Submit a plot of 2c)


###################################################################
# Question 3:  Simulation, Multiple Testing and Permutation Tests #
###################################################################

# This question will use simulation to examine how to correct a t-test for 
# multiple comparisons. 

# In micro-array experiments, it is possible to measure the expression levels of
# hundreds (now tens of thousands) of genes at once. A tissue sample is smeared
# onto a "chip" with many spots containing RNA that bind to the RNA in the tissue.
# The more binding, the more the spot lights up under flourescent light. 
#
# (Appologies to biologists in the class offended by my butchering the 
# description of this process). 
#
# Generally, samples come from subjects with different conditions (healthy
# tissue versus breast cancer, for example) and we are interested in listing
# which genes appear to operate differently between the two conditions. 

# This technology posed real problems for statistical analysis because it
# lead to mutliple testing on a scale statisticians had not conceived before
# the late 1990's. Here we will try some simulations to see how badly 
# multiple testing can screw up statistical inference, and what we can 
# do about it. 

# A) Write a function to generate simulated data for micro-arrays for two
# groups of subjects. It should accept arguments
#
#  - n: the number of subject in each group
#  - p: the number of genes measured in each group
#  - s: the number of genes whose expression differs between the groups 
#    (default to 0)
#  - d: the difference between group means on the s genes that differ
#    (default to 0)
#
# It should return a list with elements X1 and X2 giving the expression levels
# in each group. These should each be n by p matrices with N(0,1) entries, except
# that the first s columns of X2 should be N(d,1). 

SimulateMA = function(n,p,s=0,d=0){
 
}

# Test this by simulating an experiment with n = 8 subjects in each group and 
# p = 100 genes tested with no differences between the groups. 

SimData = SimulateMA(8,100)

# B) Write a function that will take the output of SimulateMA and return the vector
# of t-statistics (one for each gene) to test for differences between the groups. 

SimulateTs = function(SimData){

}

# BONUS if your function runs within 120% of the time of our vectorized code. 

# What would be the critical value for this test (we will check this value)?

Tthresh = 

# How many of your 100 genes are reported to be significantly differently expressed 
# even though none of them are different in reality (we will also check this)?

numSig = 


# C) The results above might be slightly concerning. Of course we would like to 
# know how replicable they are. Simulate repeat the simulation above 200 times and 
# use the results to evaluate the following, using the value of Tthresh from above. 

# The average number of genes declared significant

numSigMean = 

# The variance in the number of genes decared significant

numSigVar = 


# The probability that at least one gene is declared significant (otherwise known
# as the Family-Wise Error Rate)

FWER = 


# Give an estimate for the standard deviation (over repeating the simulation) for 
# your value of numSigMean.

numSigMean.sd = 



# How many simulations do you estimate we would need to be able to reduce this value 
# to 1? (Put the calculation in so we may check it with a new random number seed)

numSimNeeded = 



# D) One way to ensure that we stop getting false positives is to change the threshold 
# at which we declare a gene significant. By simulating 1,000 data sets, estimate a critical
# value so that the _maximum_ of the p t-statistics exceeds this threshhold only 5% of the time. 
# This means that if no genes make any difference, we will mistakenly declare one important 
# only in 5% of the replications. 

# Report your new threshhold in 

newTthresh = 


# As an aside, it is worth noting that this approach is generic. If we thought the responses
# from different genes were correlated -- say by how close they were on the genome -- we could
# incorporate this into the simulation when selecting newTthresh. 


# E) Now we will assess power. To do this, simulate 200 data sets, but set s = 10 and d = 3 (ie 
# the first 10 genes are expressed 3 standard deviations more in group 2 than group 1). Record 
# the vector of length 10 indicating the probability that each of these "real" differences was found. 

# Put your code in a function that takes the number of simulations and the threshold to use as well 
# as s, d, n, and p and produces the power to detect each of the s significant variables. 

SimPower = function(n,p,s,d,nsim,thresh){

  return(svec)
}


# F) So far, everything we have done has been based on a simulation. In the real world, we just have
# data which may or may not be normally distributed. Instead, we can approach this by conducting a 
# permutation test. To do this we
#
#    - First calculate the vector of t-statistics from our data. 
#    - Do nperm times:
#         - Randomly re-arrange the subjects between groups
#           (so group should now have no relationship to response -- it's been mixed up -- 
#            but keep which gene is which the same). 
#         - Calculate a new vector of t-statistics for these mixed up data and record
#           the maximum value of this vector. 
#    - Set the threshold to be the 95th percentile of the nperm maximum t-statistics. 
#    - Declare any gene significant whose _original_ t-statistic passes this threshhold. 
#
# Write a function to accept data from two groups and specify nperm (the number of permutations)
# and return vector containing the indices (ie in 1:p) of which genes are marked as significant. 

PermutationTest = function(X1,X2,nperm=1000){


}

# Try this out on 

SimData2 = SimulateMA(8,100,10,3)

result = PermutationTest(SimData2$X1,SimData2$X2)

# how many genes are correctly and incorrectly identified as significant?