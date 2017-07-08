#########################################################
################### BTRY 3520 ###########################
################## Homework 4 ###########################
############# Due: March 31, 2017 #########################
#########################################################


# Instructions: save this file in the format <NetID>_HW4.R. 
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

## NOTE: For this homework we are having you submit 
## separate files for each question (this helps us with
## processing time on the autograder). There are three questions
## in this homework, given in separate files, and you should
## submit one file per question. 


###########################
# Question 1:  Gumbel MLE #
###########################

# Here we will perform maximum likelihood estimation in a context where we 
# can't write the estimators down directly. Instead, we will have to perform
# an optimization step to search for it. 
#
# The Gumel distribution is often used for distributions of positive values that
# have very light tails. The distribution has has density function 

   dgumbel(x,mu,sigma) = exp( -(x-mu)/sigma   - exp(-(x-mu)/sigma) )/sigma

# yes, that is exp of exp. Here we will assume mu is known and focus on estimating
# sigma > 0.  

# A) For a data set x, write down a function to evaluate the log likelihood of a 
# Gumbel distribution

GumbelLL = function(x,mu,sigma)
{


 return( loglik )
}

# The data below records the maximum daily flow in Fall creek over 53 years. 

flood.data = read.table('flood.data.csv')


# and fits a Gumbel distribution very well. Calculate the log likelihood at 
# mu = 471.69,  sigma = 298.82.


# B) Because we're feeling lazy we'll use Golden section search to try and find the
# maximum likelihood estimates of sigma. However in this case we first of all have 
# to try and find the right range to look in. 

# To do this, we will first start with a range search. Since we know that 0 is the 
# lower limit of the interval, we can start with three points
# 
# xl = 0,  xm = 1,  xr = (1 + sqrt(5))/2
#
# If f(xm) > f(xr), we know the maximum is between xl and xr and can use
# these as starting values. 
#
# If f(xm) < f(xr), the maximum might be somewhere larger than xr and we 
# need to expand the range (of course we can now drop xl, because we know 
# we don't need to look in the interval [xl xm]. 
#
# To do this, set xm to be the new xl,  xr to be the knew xm and define a new
# xr that keeps the ratio  (xr-xm)/(xm-xl)  as  (1 + sqrt(5))/2. 

# Implement this scheme in a function

GoldenSectionSearch = function(s,fm,mu=471.69)
{

return( limits )
}

# and use it to find a range in which to look for the maximum likelihood
# estimate of sigma for the flood data. 


interval = 


# C) Define a function that will implement both steps of finding the MLE. First
# search for a good range and then use GoldenSectionSearch to find the MLE. 
#
# You may use the GoldenSectionSearch from class, available in the 'GoldenSection.R'
# file 

source('GoldenSection.R')

# but you don't need to. 

GoldenSectionAll = function(s,fn,tol=1e-8,maxit=100){



}

# What is your MLE for sigma in the flood data?

SigmaMLE = 
			  
			  
################################################
# Question 2:  Constrained Levenberg-Marquardt #
################################################

# So far, our optimization methods have all assumed that the maximum is inside
# the region that we are looking at. However, it's possible that we want to define
# a boundary. If the function is still increasing at the boundary, you'd use that as
# the boundary (or some point along it) as your maximum. 
#
# Note that it is important that you be able to return a point that is exactly on
# the boundary. 
#
# In statistics, it's often naturally to assume that at least some parameters are 
# postive (variances, for example are always non-negative). 
#
# Here we will examine the problem for x = (x_1,...,x_p)
#
#   x = argmax f(x)  such that  x_j >= 0  for some particular j
#
# and we will use a modification of the Levenberg-Marquardt algorithm (see code in
# Lecture 10) to do this.  Here we will use a three-dimensional x = (x_0,x_1,x_2) where we
# want x_2 > 0.  
#
# To enforce the boundary conditions, we modify the algorithm in the following manner 
# for the current estimate x:
#
#  - If x is _not_ on the boundary (ie x_j > 0) 
#       - Calculate the Levenberg-Marquardt step with the current value of lambda.
#         That is, calculate  x* = x + g(lambda) where g is the step to be taken
# 
#       - If this step takes you over the boundary  (x^*_j < 0), shrink the 
#         step until it hits the boundary. Ie, choose
#             x* = x + alpha*g(lambda)
#         where alpha is chosen so that x^*_j >= 0 (and at least one is exactly 0)
#
#       - Now assess whether this yielded and improvement in f(x). If it did not, modify
#         lambda according to the Levenberg-Marquardt algorithm. 
#
#  - If x is on the boundary already:
#       - Calculate the Levenberg-Marquardt step with the current value of lambda.
#         That is, calculate  x* = x + g(lambda) where g is the step to be taken
#
#       - If x* moves back inside the boundary, take the step. 
#
#       - If x* crosses the boundary, calculate the Levenberg-Marquardt step dropping
#         the dimensions of x that are on the boundary. That is, if x_1 = 0, keep 
#         x_1 = 0 and proceed as though you were only optimizing x_2,...,x_p. 
#
#       - If you did not improve your objective function, update lambda appropriately. 


# Our modivation for this is from the data

troutdata = read.table('troutpcb.txt')

# which contains records of PCB levels of trout in Cayuga lake in 1972. There
# are 28 trout with their PCB levels and age in the data.

# We will want to minimize the squared error for the model
#
#  log(PCB) = beta_0 + beta_1 * Age/( 1 + \beta_2 + Age) + e
#
# in other words
#
#          y = f(Age,beta) + e
#
# where beta_2 > 0.  We will fit this with a Levenberg-Marquardt modification
# of Gauss-Newton methods, so we will need functions to calculate the vector
# of f(Age,beta) and J(Age,beta) = df/dbeta.  These will be the arguments of
# fn and J in the functions below.  
# 
# As with Gauss-Newton methods, you can approximate the Hessian of squared error:
#     H = t(J)%*%J
# The derivative of squared error is of course   t(J)%*%(y - f)
#

# A) Write a function to implement this step when x is in the interior

LMStepInterior = function(beta,data,fn,J,lambda)
{

return( betastar )
}


## NEED TEST CASES


# B) Write a function to implement the step when x is on the boundary

LMStepBoundary = function(beta,Bdmim,data,fn,J,lambda)
{
  # Bdim = index of which dimensions of x are on the boundary; x[Bdim] = 0

  return( beta )
}

## NEED TEST CASES


# C) Put these together in a constrained Levenberg-Marquardt algorithm

ConstrainedLevenbergMarquardt = function(beta,data,fn,J,tol=1e-8,maxit=100){



  return( list(sol=sol, iter=iter) )
}




# D) Apply this to the trout data with starting values 

betastart = c( mean(log(troutdata$PCB)), 1, 0 )

result = ConstrainedLevenbergMarqardt(....)


#################################
# Question 3:  LASSO Regression #
#################################


# In this question we will investigate the LASSO -- the basis of modern 
# model selection methods. Here we suppose that we have data from a multiple
# linear regression model
#
# y_i = beta_0 + \beta_1 x_i1 + ... + \beta_p x_ip + \epsilon_i
#
# where we have reason to think that many of the beta_j will be exactly zero
# (ie x_ij will have no impact on y_i), but we don't know which ones. 
#
# The current fad for how to work out which coefficients are zero is based
# on an idea by Rob Tibshirani in 1996. The LASSO proposes to minimize 
# the following criterion
#
# sum_i ( y_i - beta_0 + \beta_1 x_i1 + ... + \beta_p x_ip )^2  + lambda*sum_j |beta_j|
#
# This is the familiar sum of squared errors but we add on some factor times the 
# absolute value of the beta_j. This "penalty" makes the beta a bit smaller (if you're 
# familiar with ridge regression, this replaces beta_j^2 with |beta_j|). It also tends
# to set some of the beta to be exactly zero, producing a model selection effect 
# (we can drop the terms with zero beta).
#
# Obtaining beta_j isn't straightforward because the penalty is not differentiable
# at zero. Here we will use co-ordinate descent (ie, optimize one beta_j at a time). 
# This was described as being very slow in class, but we will see that in this case
# it can be very useful. 


# The motivating data set will be the data

prostate = read.table('prostate.csv')

# which contains 97 observations of prostate tumors including
#
# lcavol = log cancer volume (our response)
# lweight = log prostate weight
# age = age of subject in years
# lbph = log of the amount of benign prostatic hyperplasia
# svi = seminal vesicle invasion
# lcp = log of capsular penetration
# gleason = a numeric vector indicating severity of cancer
# pgg45 = percent of Gleason score 4 or 5
# lpsa = prostate specific antigen measuring a chemical assocated with cancer
#
# These have all been centered so each column has mean zero (see below) and divided
# by the standard deviation.  





# A) First we need to do some theory.  Here we will look at only the one-covariate
# problem: 
#
#  sum (y_i - \beta_1 x_i1)^2 + lambda |\beta_1|                 (*)
#
#  where both y_i and x_i1 have average value zero. This can be achieved by 
#  subtracting the average from each. This then gets rid of beta_0 (convince 
#  yourself of this, but you don't need to show it). 
#
#  i) By looking at the derivative of (*) at beta_1 = 0
#  show that  (*) is minimized at zero if 
#   
#   | sum x_i y_i  | < \lambda/2
#
# To do this while accounting for the use of the absolute value of beta, examine 
# the derivative at zero for the equation on the right of zero, and then for the 
# equation on the left of zero. 
 
 
 
 
 
# ii) If \sum x_i y_i >  \lambda/2, what value of beta_1 minimizes (*)? By symmetry
# what if  - \sum x_i y_i > \lambda/2?



# iii) Write a function to take in vectors x, y and number lambda and calculate the 
# value of beta from above

HardThreshold = function(x,y,lambda)
{


}

# Test this by

HSAge = HardThreshold(prostate[,'age'],prostate[,'lcavol'],50)
HSlpsa = HardThreshold(prostate[,'lps'],prostate[,'lcavol'],50)




# B) We will use this function to minimize the original LASSO problem by optimizing
# one beta_j at a time. You will need to 
#
#  - First center y and all the x_j
#  - Loop over j, each time minimizing
#
#      sum (y^*_i - \beta_j x_ij)^2 + lambda |\beta_j|
#
#    where y^*_i is the residual using the "current" estimates
#    of the beta _except_ for beta_j  (or with beta_j = 0). 
#
#  - Continue until the \beta_j change by less than a tolerance or a maximum
#    number of iterations (one iteration is a loop over 1 through p) is 
#    reached.
#
#  Write a function to carry this scheme out

CoordinateLASSO = function(x,y,lam,tol=1e-8,maxit=100)
{




}



# C) Apply this to the prostate data set


# i) Carry out your scheme with these data and store the corresponding estates of beta
# for each of 

lambda = seq(0,100,by = 2)

# and record these in a 41-by-9 matrix

betamat = 



# ii) Plot the resulting estimates as lambda is changed. Here, insteach of
# plotting against lambda, put your estimates of beta on the y axis, and 
# the x axis should be the sum of absolute values:  \sum_j |\beta_j|
#
# Your plot should connect each coefficient with lines so that we can trace 
# how it changes with \sum_j |\beta_j| as lambda changes. 


LASSOPlot = function(betamat){



}


LASSOPlot(betamat)



# BONUS:  the HardThreshold update rule is very convenient for least-squares
# problems because we have an explicit update formula for \beta_j. However, 
# this approach is quite effective even if we have to find \beta_j numerically
# each time. 
#
# Suppose I had nonlinear model
#
#   y =  exp( beta_0 + \beta_1 x_i1 + ... + \beta_p x_ip ) + \epsilon_i
#
# We would use this to measure cancer volume rather than log cancer volume. 
# Describe how to implement a LASSO estimate using co-ordinate descent
# using the scheme above. 




