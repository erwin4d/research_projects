#########################################################
################### BTRY 3520 ###########################
################## Final Exam ###########################
############# Due: May 23, 2017 #########################
#########################################################


# Instructions: save this file in the format <NetID>_FinalQ3.R. 
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

# NOTE: There are three questions given in separate files, and 
# you should submit one file per question. 

#### IMPORTANT INSTRUCTIONS FOR THE FINAL

## The final is to be completed as though it were in-class. 
## That means 
##
## 1. You must complete this work independently, without 
## collaboration or external assistance. Violations will
## be treated under the academic code. 
##
## 2. We will not provide office hours. We will monitor 
## Piazza and provide clarifications where questions are
## unclear. 
##
## 3. While we will not, in general, debug your work for you,
## we are happy to try to explain error messages if you can
## isolate the line of code that produces them and, preferably,
## reproduce them with a few-line script.
##
## [Example: R tries to interpret dimensions, but doesn't 
## always get it right.  So the code
##  
##   b = matrix(2,1,1)
##   t(1:3)/b
##
##  returns an error, but (1:3)/b does not.  We think it reasonable
##  to explain something like this to you if you get a message
##
##   Error in t(1:3)/b : non-conformable arrays
##
##  along with other instances of "I know where the error is, I just
##  don't know why R has a problem or how to fix it"]



## QUESTION 3: Log-Spline Density Estimation

# This question will examine maximum likelihood in a flexible 
# class of densities. To do this, we'll use a data set giving 
# the area burned in 270 forest fires. Because there is a lot
# of skew in this distribution, we'll look at the log of the 
# area. 

# This is given in the following data set; we've included a 
# histogram so you can get a sense of the shape of the distribution. 

fire = as.numeric(read.table('ForestFires.csv',head=FALSE)[[1]])

hist(fire,20,prob=TRUE)

# This looks normal-ish, but might be a bit skewed, and maybe 
# a bit light-tailed. We'll try to find a more flexible 
# set of densities to use to model this. 

# The idea is that the log of a normal density is quadratic
#
# log( dnorm(x) ) = [-mu^2/(2*sigma^2) - 1/2*log(2*pi*sigma)] 
#                         + (mu/sigma^2)*x - x^2/(2*sigma^2)   
#                 = a + b*x + c*x^2
# 
# Maybe we could add some additional terms. Say
#
# log( density(x)) = c0 + c1*x + c2*x^2 + c3*x^3 + c4*x^4

# Doing this runs us into a few difficulties: we know that 
# densities must be positive and integrate to one. To see how 
# this affects what we do, let's look at
# 
# density(x) = exp(c1*x + c2*x^2 + c3*x^3 + c4*x^4)/C
#
# Here it is natural to think of C = exp(-c0) as the number
# that makes the density integrate to 1. 

# Of course, we have to work out what C is. In this case, we
# will assume that the density is only defined on the interval
# [-3, 7].  Thus for any [c1,c2,c3,c4] we can obtain C by using 
# Simpson's rule to approximate
#
# int_(-3)^7 exp(c1*x + c2*x^2 + c3*x^3 + c4*x^4)

# A) Write a function to approximate C via Simpson's rule using
# a spacing of h = 0.25 between quadrature points. It should 
# taken in a vector c and return the number C

NormConst = function(c){
  
}

# Try this out on 

coefs = c(0.5,-0.125,0,0)

Const1 = NormConst( coefs )

# Use this to plot your (appropriately normalized) density overlayed on the
# histogram of log fire areas.  You should plot this at each of the 
# evaluation points used to evaluate the constant. Upload this to CMS as 
# density1.png. 


hist(fire,20,prob=TRUE)
lines(....)




# B) For real-world data, we need to maximize the log likelihood.
# We will use a nonlinear optimization algorithm to do this. 

# Recalling that the log likelihood is given as 
#
# sum_i log(density(x_i; c))
#
# write (separate) functions to evaluate the log likelihood along
# with its gradient with respect to c and its Hessian. Remember that
# your normalizing constant will change with C as well. 
#
# You may find the diag function useful, but note that if you wish to
# create a diagonal matrix with vector v on the diagonal, diag(v) only
# works if v is of mode vector. 

loglik = function(coefs,X){
   
  
}


ll.gradient = function(coefs,X){
   
 
}

ll.Hess = function(coefs,X){

}


# Check the values of these functions at this initial guess

val1 = loglik(coefs,fire)

grad1 = ll.gradient(coefs,fire)

Hess1 = ll.Hess(coefs,fire)

# C) The file LevenbergMarquardt.R implements the Levenberg-Marquardt
# optimizer from Lecture 10. It assumes inputs of the form above:

source('LevenbergMarquardt.R')

# You may choose to write your own. In which case it should be pasted in here. 

# Use this to provide maximum likelihood estimates of your coefficients


opt.result = 


## PARTIAL CREDIT if you use the built-in function 'optim' to 
## optimize the log likelihood. (Only applies if your opt.result
## gives the wrong answer). You may complete the rest of the 
## questions with the coefs that you get this way. 
##
## Remember that 'optim' tries to minimize rather than maximize. 


# What is the new normalizing constant for these coefficients?

newconst = 


# Produce a plot of the density overlayed on the histogram of fire values
# using the same points as in Part A. Upload this to CMS as density2.png. 

hist(fire,20,prob=TRUE)
lines(.... )


# D) The researchers who produced these data want to simulate new fires from
# this distribution as part of a larger test of forest fire readiness. They
# notice that we have an inexact normalizing constant and that a 
# Metropolis-Hastings MCMC algorithm will not need to use it. 

# Because we have constrained the data to lie in [-3, 7] the researchers
# propose using an independence sampling approach. That is, generating
# each proposed Y from an independent U[-3, 7] distribution. 

# Write a function to carry this out, without numerical integration. 
# It should take in the coefficients (note that we are NOT performing 
# inference of the coefficients here -- you no longer need the data) and 
# the number of MCMC steps to take.

# It should output two elements: the resulting chain and an estimate of
# the acceptance rate. 


indep.mcmc = function(coefs,nstep){
  
 
  
}


# Use this to generate 1000 new samples

new.samps = indep.mcmc(opt.result$coef,10000)

# What is the acceptance rate?

accrate = new.samps$acc

# What is the mean value in your returned chain?

sample.mean = 


# Plot a histogram of the values of your chain along with lines for
# the target density. Upload this as density3.png. Use 100 bins. 

hist(....,100,prob=TRUE)
lines(....)


# E) The researchers find the restriction to the interval [-3,7] 
# rather artificial. They propose using a random walk MCMC method
# to allow sampling on the whole real line (since we don't need to
# calculate a normalizing constant).  

# Looking at the estimated coefs values, would you recommend this. 
# Why?









# F) (Caution: this is long relative to the number of points it is worth). 

# Another direction the researchers consider is to have a more flexible
# model. As a way to manage this, we'll replace the 
#
# log(density(x)) = c_0 + c_1*x  + c2*x^2 + c3*x^3 + c4*x^4
#
# with a B-spline basis (see final lecture notes). This is a set
# of functions that are polynomial between breaks but join
# up smoothly across breaks. 

# The idea is that with a set of functions phi1(t),...,phiK(t)
# we can approximate a function
#
# f(t) = c1*phi1(t)+c2*phi2(t)+...+cK*phiK(t)

# For this question we'll use some functions already coded
# up in the 'fda' library. You may need to install this library.  

library('fda')

# To define the basis, we will need to produce some break points.
# All of our data are contained in the interval [-3, 7], and we'll 
# set up breaks every integer (we could use other breaks but this is 
# convenient):

breaks = seq(-3,7,by=1)

# We can now create a 'basis' object that defines the B-spline
# basis with the following function

bbasis = create.bspline.basis(range=c(-3,7),norder=6,breaks=breaks)

# It might help to visualize this

plot(bbasis)

# Each line gives a basis function. These look like 'bumps' which cover
# 5 intervals each. Intuitively, we should be able to get pretty close
# to a smooth function by taking weighted combinations of these. 

# As a first problem, we need to be able to work with the numerical 
# values of the basis functions at a given point t.  In fact we can
# evaluate these at a vector of points. 

pts = seq(-3,7,0.25)

# The following function evaluates the basis

basis.values = eval.basis(bbasis,pts)

# Note that basis.values is a matrix: each column corresponds to 
# a basis function, and each row to an element of pts. 

# If we plot the columns of this matrix

matplot(pts,basis.values,type='l')

# we see we get nearly the same plot as we had before (just with
# fewer points along the X axis. 

# It will also be helpful to evaluate the basis at the points in
# our data set

fire.basis = eval.basis(bbasis,fire)

# The way a single function is defined is to give a set 
# of coefficients for each basis. 

# So for example, there are 15 basis functions in bbasis
# if we set coef to be a vector of zeros but with the middle
# two set to one:

spline.coefs = rep(0,bbasis$nbasis)
spline.coefs[7:8] = 1

# We can plot the values of this function at pts with

plot(pts,basis.values%*%spline.coefs,type='l')

# Functions defined this way are referred to as 'splines'.

# Re-write your loglikelihood function, gradient and Hessian
# from part B to use the B-spline basis rather than the four
# terms x, x^2, x^3, x^4. 

# When you do this, you will need to drop the first B-spline.
# This is analogous to the way we removed the term c0 and 
# incorporated it into the constant.

# You should also write these so that they accept an input
# X. Because you need to provide more input than just the data
# this should be a list of objects that you can then access
# inside your functions. Include whatever you think to be appropriate
# but aim to do as little extra computational work as possible.  

# Define your list to be 

Xlist = 
	
	
spline.loglik = function(coefs,X){
   
   
}


spline.ll.gr = function(coefs,X){
  
}


spline.ll.hess = function(coefs,X){
   
}

# We will check the evaluation of these with spline.coefs[-1] (since you should remove the
# first basis function)


spline.val = spline.loglik(spline.coefs[-1],Xlist)

spline.gr = spline.ll.gr(spline.coefs[-1],Xlist)

spline.Hess = spline.ll.hess(spline.coefs[-1],Xlist)


# G) Using the LevenbergMarquardt function provided, find the optimal values for these
# coefficients and plot the resulting density estimate along with the histogram (don't 
# forget to normalize). Upload the plot as density4.png to CMS. 

# Note that you may find that LevenbergMarquardt does not converge in the default number
# of iterations. That is fine -- it gets us close enough. 

result2.opt = 

hist(fire,20,prob=TRUE)
lines(...)


