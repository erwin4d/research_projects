#########################################################
################### BTRY 3520 ###########################
################## Homework 3 ###########################
############# Due: March 31, 2017 #########################
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

############################################
# Question 1:  Bootstrapping Correlations #
############################################



# A) Write a function to carry out bootstrap procedure to estimate Kendall's correlation 
# Your function should take in a n-by-2 matrix X and report a list with elements
#  (i) Your correlation coefficent (you may use the cor() function)
#  (ii) Your estimate of bias.
#  (iii) The bias-corrected estimate.
#  (iv)  Normal-theory confidence intervals based on bootstrap standard errors.
#  (v) Standard bootstrap confidence intervals.
# (feel free to name these how you will, but make sure they come in this order). 


# While we will call the function SpearBoot below, we recommend you break this up
# task up and write a series of smaller functions to resample, find biases etc. These
# can also be re-used in part C. 

KenBoot = function(X,nboot=1000,alpha=0.05){
 # X = data
 # nboot = number of bootstraps
 # alpha = level of the test or confidence interval

}


# Test this using the Old Faithful data

faithful = read.csv('faithful.csv')            

BootResult = KenBoot(faithful,1000)




# B) In the old faithful data, in addition to the waiting time, the previous eruption length can 
# be an important indicator of the duration of the next eruption. (e.g. plot eruption time versus 
# the previous eruption time in the data set). We will assess this through a residual bootstrap.

# i. Construct a linear regression of eruption on waiting and the previous value of
# eruption (this means you cannot use the first entry in the data set except as a
# covariate). Is the previous value of eruption significant when using the standard
# linear regression theory?


FaithfulModel = 


# ii. Construct a residual bootstrap for this model and report the same statistics as in A
# for the coefficient of the previous value of eruption. Do any of your confidence
# intervals cross zero?

ResidBoot = function(X,nboot=1000,alpha=0.05){
 # X = data
 # nboot = number of bootstraps
 # alpha = level of the test or confidence interval



}


FaithfulBoot = ResidBoot(faithful)

CoeffientBias = FaithfulBoot[[2]]
CorrectedCoefficient = FaithfulBoot[[3]]
NormalCI = FaithfullBoot[[4]]
BootCI = FaithfullBoot[[5]]



# BONUS: If you've written helper functions for the estimate of bias, bias corrected estimate, 
# normal theory confidence intervals, and confidence intervals, you'll realize we use them for 
# both part A) and B). Design a function that lets the user specify a parameter he / she wants 
# to estimate (functions can be inputs to other functions), and returns the results in a list. 
# Points will also be given for documentation of this function, and you can demonstrate how this 
# works on a parameter of your choice.

# We will grade this function manually, so you don't need to worry about the naming of it.










# C) Although permutation tests can generally only be used to tests the global significance
# of a regression, they can be applied for partial effect of some covariate by building a
# model using the other covariates and then permuting the residuals from this model like
# in a residual bootstrap. This ensures that there is no further signal from the covariate of
# interest in the permuted data.

# i. Conduct a permutation test to assess the significance of the entire regression described
# above using the F-statistic from lm. Report the observed p-value of the test.


PermutationPvalue = 


# ii. We can explicitly conduct a permutation test for the previous eruption time as follows
#   A. Estimate a model to predict eruption time just from waiting time.
#   B. Obtain the residuals from this model.
#   C. Permute these residuals and add them back onto the predictions of the model.
#   D. Now estimate the full model (including previous eruption time) and record the
#      F-statistic.
#   E. Repeat the last two steps many times and record the percentage of times the
#      observed F statistic exceeds those using the permuted data.

# Carry out this scheme and report the significance of your test.


PermutationCoefficientPvalue = 






########################################
# Question 2: Two-Way Bisection Search #
########################################

# If X1 and X2 are both N(u,s) but have correlation r, their joint
# distribution function is 
#
#                  exp{ [(X1-u)^2 + (X2-u)^2 - 2r(X1-u)(X2-u)]/(2s^2(1-r^2)) }
# f(X1,X2,u,s,r) = ----------------------------------------------------------- 
#                                sqrt{ 2 pi s^2 (1-r^2) }
#
#  When estimating parameters, statisticians often maximize the log likelihood
# 
#  l(u,s,r) = sum log f(X1i,X2i,u,s,r)
#
# over the data. 
#
# In this case, the best values of u, s, and r are obtained by the mean, variance
# and correlation in the data. 
#
# We will call these values u*, s* and r* below. 
#
# However, we can also use the likelihood to form a confidence interval for r by 
# looking at where l(u*,s*,r) drops below l(u*,s*,r*) by more than a Chi-squared(1)
# critical value. That is we look for the value of r at which
#
# l(u*,s*,r) = l(u*,s*,r*) - qchisq(1,0.95)
#
# Note that there will be two such values -- one for r larger than r* and one for r smaller. 

# Write a function that performs bisection search to determine the range of r for which 
# 
# l(u*,s*,r) > l(u*,s*,r*) - qchisq(1,0.95)
#
# (this is a confidence interval).
#
# Your function should be implemented so it repeats as few calculations as possible when
# performing the search. It should return when each endpoint of the interval is given within 
# a tolerance of 1e-8. 

# Your function should  calculate u*, s* and r* and return a vector of length 2 giving the lower 
# and upper end point of the interval. It may help to recall that r must lie in the interval [-1, 1]. 

CorrelationInterval = function(X){
  # X = n-b-2 matrix of data. 


} 

# (When constructing this function, try to re-compute quantities as little as possible). 

# Check this using the current waiting time and the most recent waiting time in the
# Old Faithful data set. 

OldFaithfulCI = 


# Construct a Boostrap percentile confidence interval. How does this compare?

OldFaithfulBootCI = 



#############################################
# Question 3: Vectorized Secant Root Search #
#############################################

# Because most root-Finding methods only find a local zero of a function, it can be useful to
# start at many places in order to find roots of equations. This question is an exercise in doing
# so efficiently.

# A) Write a function to conduct a Secant root-Finding method for one-dimensional
# problems that accepts a vector of starting values and performs the iteration on each value
# simultaneously. In particular the function should
#   (i) Establish convergence criteria based on a maximum number of iterations as well as
# a tolerance given by the maximal value of the function over the current estimates.
#   (ii) Return the vector of roots found, a matrix containing the history of all iterations of
# the algorithm and an indicator of whether the function stopped because the maximal
# number of iterations was reached or because the tolerance criterion was met.
#
# Running this function should also display to the user what exactly is happening, and the 
# parameters set, such as the tolerance level and the maximum number of iterations considered. 
# You may use print() or cat() or otherwise.
#
# The returns of your function should be understandable to someone who has not read this
# question and it should also work if only given a single initial starting guess.

NewtonRaphsonVec = function(starts,func){
   # starts = a vector of starting values
   # func = function to be set to zero, should accept and return a vector of values

   
   
}


# B) Apply this to Find the roots of x cos(x) with starting guesses a vector of length 201 equally-
# spaced numbers between -10 and 10. 


SecantResult = 


# Extract your final vector of the values where x cos(x) = 0 below

Roots = 


# C) Write a function that takes the output of NewtonRaphsonVec and plots the estimates
# (on the y axis) versus iterations (x axis) designating the values of the iteration from each
# starting guess by a line. Use this to plot the progress for the root finding program in B.

PlotSecant = function(object){


}


PlotSecant(SecantResult)

# How would you go about using these results to specify a unique set of roots?

UniqueRoots = 
