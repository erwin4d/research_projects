#########################################################
################### BTRY 3520 ###########################
################## Homework 5 ###########################
############# Due: May 10, 2017 #########################
#########################################################


# Instructions: save this file in the format <NetID>_HW5Q2.R. 
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




########################################
# Question 2:  Monte Carlo Integration #
########################################

# Based on JMR 18.6.18. You may not use the rcauchy, pcauchy or qcauchy functions in
# this question. 

# The Cauchy distribution with parameter alpha has density
#
# f(x; alpha) = alpha/[pi*(alpha^2 + x^2)]
#
# with quantile (inverse CDF) function
#
# q(u;alpha) = alpha*tan(pi*(u - 0:5))

# A) Write a function to evaluate the inverse CDF for the Cauchy distribution. Use this to
# sample 1,000 Cauchy-distributed samples with alpha = 0.01 and produce a histogram of these 
# with 100 bins. Limit your x-axis to the range [-2, 2].
# 
# Overlay a plot of the Cauchy density to verify that you are getting sensible answers.

iCauchyCDF = function(u,alpha){


}


cauchy.samples = 

## Upload the histogram to CMS

# B) i) Estimate the expectation of
#
# g(x) = exp[(X-5)/50]/(1 + exp[(X-5)/50])
#
# when X is a Cauchy(2) random variable. g(x) can be calculated with the plogis function.
# Use 1,000 Monte Carlo sample points.  
#
# Note that you may need to re-write g(x) to avoid numerical overflow -- try not to exponentiate
# the positive value of a Cauchy random variable. 

Exp.g.vanilla = 

# Repeat the evaluation using antithetic sampling.

Exp.g.antithetic = 

# ii) Estimate the variance of each of these estimates based on 100 replicates. What is the
# variance reduction (as a percentage of the vanilla Monte Carlo estimate) due to antithetic
# sampling?

var.reduction = 

# C) i) It is well-known that the Cauchy distribution does not have a well-defined mean. We
# can see this in simulation by estimating EX when X is Cauchy(2). Using your inverse
# sampler, estimate the variance a vanilla Monte Carlo evaluation of X based on 10, 100
# and 10,000 samples. Use 50 replicated Monte Carlo expectations for each sample size.
# Store your variances in the 3-vector

cauchy.mean.var = 

# ii) Does the variance of your estimate decrease at rate 1/sqrt(n)? Plot the relationship between
# your variance and n. 




## Upload this plot to CMS (plot_A)

# D)Program a rejection sampler to use the Cauchy distribution to generate standard normal
# random variables.   (Note, that you should pay attention to run time -- if this takes more
# than a minute, talk to the instructor or TAs)

# i) For each value of alpha, what is the optimal value of k?


# ii) Use this in the function below

Cauchy.Reject = function(nsamples,alpha){


}

# iii) For alphas in

alphavec = seq(0.1,1.4,len=20)

# generate 1000 Normal random variables this way. Plot the percentage of
# rejected samples at each alpha, also plot the expected percentage of rejected samples, (k-1)/k.
# What is the optimal alpha?


## Upload this plot onto CMS (plot_B)