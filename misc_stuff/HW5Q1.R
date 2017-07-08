#########################################################
################### BTRY 3520 ###########################
################## Homework 5 ###########################
############# Due: May 10, 2017 #########################
#########################################################


# Instructions: save this file in the format <NetID>_HW5Q1.R. 
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




#########################################
# Question 1:  2 Dimensional Quadrature #
#########################################


# A) From JMR Exercize 11.4.4:

# Consider
#
# I = integral_0^1 3/2*sqrt(x) dx = 1
#
# Let Tn be the approximation to I given by the trapezoid rule with a partition
# of size n and let Sn be the approximation given by Simpson's rule
# with a partition of size n.
# Let nT(epsilon) be the smallest value of n for which |Tn-I| < epsilon and let 
# nS(epsilon) be the smallest value of n for which |Sn-I| < epsilon. 
#
# Write functions that calculate nT(epsilon) and nS(epsilon)

nT = function(epsilon){


} 

nS = function(epsilon){

}


# Use these to plot nT(epsilon) and nS(epsilon) against log(epsilon) for 
# epsilon = 2^(-k), k = 2, . . . , 16.




# B) Now consider a two-dimensional integral. We know that
#
# integral_(-1)^1 integral_(-1)^1 sqrt(1 - x^2 - y^2) dx dy = 2*pi/3 
#
# where the square root is taken to be positive and set to zero when it isn't defined. 
# This is because it solves the equation for the unit sphere: x^2 + y^2 + z^2 = 1, for 
# z, so we are calculating the volume of a half sphere.

# i. Write a function to implement Simpson's method to two dimensions
# (hint: do the inner integral first, then the outer integral). It should use take inputs
# n, for the number of grid points in each dimension and a function to calculate f(x,y)
# and return the integral. Use the same number, n, of points in x and y. 

Simpson2d = function(fn,n){


}



# ii. You can evaluate 2*pi/3 in R; many grid points do you need to make your partition so that
# your numerical integral is accurate to within 10^(-4)?

N.Needed = 


# iii. Now consider extending this scheme to integrate over p dimensions. For a fixed
# partition size, how does the numerical cost of your scheme grow with p?  You should answer
# this in comments. 



# BONUS: Provide an analysis the approximation accuracy of your two-
# dimensional scheme in terms of the size of the partition.
